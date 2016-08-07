class Bug < ApplicationRecord
  validates :bug_id, presence: true, numericality: { only_integer: true }
end
