class User < ApplicationRecord
  before_create :generate_uuid, :generate_team

  enum team: [:red, :green, :blue]

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end

  def generate_team
    # TODO: find smaller team and assign it to the user
    self.team = :red
  end
end
