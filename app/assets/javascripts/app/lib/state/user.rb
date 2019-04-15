# frozen_string_literal: true

class User
  attr_reader :id, :team
  attr_accessor :connections

  def initialize(user_json)
    @id = user_json[:id]
    @team = user_json[:team]
    @connections = 0
  end
end
