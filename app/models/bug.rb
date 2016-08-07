class Bug < ApplicationRecord
  validates :bug_id, presence: true, numericality: { only: :integer }
end
