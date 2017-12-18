# frozen_string_literal: true

class Mirror < ApplicationRecord
  belongs_to :branch

  validates :order_id, presence: true

  validates :name, presence: true

  validates :uri, presence: true

  validates :protocol, presence: true
end
