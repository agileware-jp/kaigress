# frozen_string_literal: true

class Connection < ApplicationRecord
  belongs_to :from, class_name: 'User', foreign_key: :from_id, inverse_of: false
  belongs_to :to, class_name: 'User', foreign_key: :to_id, inverse_of: false

  after_create :notify

  validate :from_and_to_are_different
  validate :same_connection_does_not_exist
  validate :same_team

  def as_json(_opts = nil)
    { from: from_id, to: to_id }
  end

  private

  def from_and_to_are_different
    errors.add(:base, :same_user) if from_id == to_id
  end

  def same_connection_does_not_exist
    errors.add(:base, :already_connected) if Connection.where(from: from, to: to).or(Connection.where(from: to, to: from)).exists?
  end

  def same_team
    errors.add(:base, :different_teams) if from.team != to.team
  end

  def notify
    StateChannel.broadcast_new_connection(self)
  end
end
