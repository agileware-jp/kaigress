class Connection < ApplicationRecord
  belongs_to :from, class_name: 'User', foreign_key: :from_id
  belongs_to :ti, class_name: 'User', foreign_key: :to_id
end
