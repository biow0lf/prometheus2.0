class Bug < ApplicationRecord
  validates :bug_id, presence: true

  validates :bug_id, numericality: { only_integer: true }
end
