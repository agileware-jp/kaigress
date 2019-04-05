# frozen_string_literal: true

class Team
  def self.smallest_teams
    minimum_member_count = member_counts.values.min
    member_counts.keys.select { |t| member_counts[t] == minimum_member_count }
  end

  def self.member_counts
    User.teams.keys.each_with_object({}) { |t, result| result[t] = User.send(t).count }.symbolize_keys
  end

  def self.connections_of(team)
    Connection.merge(User.where(team: team)).joins(:from)
  end

  def self.connections_by_team
    User.teams.keys.to_h { |team| [team, connections_of(team)] }.symbolize_keys
  end
end
