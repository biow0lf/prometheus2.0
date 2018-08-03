# frozen_string_literal: true

class Architecture < ApplicationRecord
  belongs_to :platform

  validates :name, presence: true
end
