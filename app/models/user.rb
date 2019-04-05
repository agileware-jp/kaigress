# frozen_string_literal: true

class User < ApplicationRecord
  before_create :generate_uuid, :generate_team, :generate_connection_token

  enum team: %i[red green blue]

  def as_json(_opt)
    { id: id, nickname: nickname, team: team }
  end

  def connect_to(user)
    ActiveRecord::Base.transaction do
      Connection.create!(from: self, to: user)
      user.generate_connection_token
      user.save!
      true
    rescue ActiveRecord::RecordInvalid
      false
    end
  end

  def generate_connection_token
    self.connection_token = SecureRandom.uuid
  end

  private

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end

  def generate_team
    self.team ||= Team.smallest_teams.sample
  end
end
