# frozen_string_literal: true

class Connection < ApplicationRecord
  belongs_to :from, class_name: 'User', foreign_key: :from_id, inverse_of: false
  belongs_to :to, class_name: 'User', foreign_key: :to_id, inverse_of: false

  validate :from_and_to_are_different

  private

  def from_and_to_are_different
    errors.add(:base, :invalid) if from_id == to_id
  end
end
