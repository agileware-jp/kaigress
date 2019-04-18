# frozen_string_literal: true

class User < ApplicationRecord
  before_create :generate_uuid, :generate_team
  after_create :notify

  enum team: %i[red green blue]

  def as_json(_opt = nil)
    {
      id: id,
      nickname: nickname.delete_prefix('@'),
      team: team,
      github: github_account?
    }
  end

  def connect_to(user)
    Connection.new(from: self, to: user).save
  end

  private

  def github_account?
    nickname.start_with? '@'
  end

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end

  def generate_team
    self.team ||= Team.smallest_teams.sample
  end

  def notify
    StateChannel.broadcast_new_user(self)
  end
end
