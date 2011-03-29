class Mirror < ActiveRecord::Base
  belongs_to :branch

  validates :branch, :presence => true
  validates :order_id, :presence => true
  validates :name, :presence => true
  validates :uri, :presence => true
  validates :protocol, :presence => true
end
