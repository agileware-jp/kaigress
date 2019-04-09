# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :singleton_connection

    def global_connection
      :singleton_connection
    end
  end
end
