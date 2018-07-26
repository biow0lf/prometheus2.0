# frozen_string_literal: true

class AllSrpmsWithName
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def search
    Srpm.where(name: name)
        .includes(:branches)
        .order('branches.order_id')
  end
end
