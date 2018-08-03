# frozen_string_literal: true

class Platform < ApplicationRecord
  has_many :architectures, dependent: :destroy

  # has_many :sources, through: :architectures
  #
  # has_many :binaries, through: :sources

  validates :name, presence: true

  validates :version, presence: true
end
