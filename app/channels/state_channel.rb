# frozen_string_literal: true

class StateChannel < ApplicationCable::Channel
  def subscribed
    stream_from "new_#{params[:model_type]}"
  end

  def self.broadcast_new_user(user)
    ActionCable.server.broadcast 'new_user', user.as_json
  end

  def self.broadcast_new_connection(connection)
    ActionCable.server.broadcast 'new_connection', connection.as_json
  end
end
