class BranchDecorator < Draper::Decorator
  delegate_all

  def as_json(*args)
    {
      id: id,
      name: name,
      order_id: order_id,
      path: path,
      created_at: created_at,
      updated_at: updated_at,
      count: srpms.count
    }
  end
end
