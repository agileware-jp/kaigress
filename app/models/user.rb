class User < ApplicationRecord
  before_create :generate_uuid, :generate_team

  enum team: [:red, :green, :blue]

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end

  def generate_team
    self.team ||= User.smallest_teams.sample
  end

  def self.smallest_teams
    minimum_member_count = member_counts.values.min
    member_counts.keys.select { |t| member_counts[t] == minimum_member_count }
  end

  def self.member_counts
    teams.keys.each_with_object({}) { |t, result| result[t] = User.send(t).count }.symbolize_keys
  end

  def connect_to(user)
    Connection.create(from: self, to: user)
  end
end
