# frozen_string_literal: true

class User < ApplicationRecord
  before_create :generate_uuid, :generate_team, :generate_connection_token

  enum team: %i[red green blue]

  def self.smallest_teams
    minimum_member_count = member_counts.values.min
    member_counts.keys.select { |t| member_counts[t] == minimum_member_count }
  end

  def self.member_counts
    teams.keys.each_with_object({}) { |t, result| result[t] = User.send(t).count }.symbolize_keys
  end

  def connect_to(user)
    ActiveRecord::Base.transaction do
      Connection.create!(from: self, to: user)
      generate_connection_token
      save!
      true
    rescue ActiveRecord::RecordInvalid
      false
    end
  end

  private

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end

  def generate_team
    self.team ||= User.smallest_teams.sample
  end

  def generate_connection_token
    self.connection_token = SecureRandom.uuid
  end
end
