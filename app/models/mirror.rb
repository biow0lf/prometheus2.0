class Mirror < ActiveRecord::Base
  validates :branch_id, :presence => true
  validates :order_id, :presence => true
  validates :name, :presence => true
  validates :uri, :presence => true
  validates :protocol, :presence => true

  belongs_to :branch
end
