# frozen_string_literal: true

class NamedSrpm < ApplicationRecord
  belongs_to :branch
  belongs_to :srpm

  scope :by_branch_id, ->(id) { where(branch_id: id) }

  validates_presence_of :branch_id, :name
end
