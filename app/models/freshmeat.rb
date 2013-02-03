# encoding: utf-8

class Freshmeat < ActiveRecord::Base
  validates :name, presence: true
  validates :version, presence: true
end
