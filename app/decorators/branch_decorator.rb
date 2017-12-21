# frozen_string_literal: true

class BranchDecorator < Draper::Decorator
  delegate_all

  def as_json(*)
    {
      id: id,
      name: name,
      order_id: order_id,
      path: path,
      created_at: created_at.iso8601,
      updated_at: updated_at.iso8601,
      count: srpms.count
    }
  end
end
