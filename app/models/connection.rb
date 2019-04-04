# frozen_string_literal: true

class Connection < ApplicationRecord
  belongs_to :from, class_name: 'User', foreign_key: :from_id, inverse_of: false
  belongs_to :to, class_name: 'User', foreign_key: :to_id, inverse_of: false

  validate :from_and_to_are_different
  validate :same_connection_does_not_exist

  private

  def from_and_to_are_different
    errors.add(:base, :invalid) if from_id == to_id
  end

  def same_connection_does_not_exist
    errors.add(:base, :invalid) if Connection.where(from: from, to: to).or(Connection.where(from: to, to: from)).exists?
  end
end
