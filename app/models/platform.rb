# frozen_string_literal: true

class Platform < ApplicationRecord
  validates :name, presence: true

  validates :version, presence: true
end
