class BranchDecorator < Draper::Decorator
  delegate_all

  def as_json(*args)
    super only: [:id, :name, :order_id, :path], methods: [:created_at, :updated_at, :count]
  end

  private

  def count
    srpms.count
  end

  def updated_at
    model.updated_at.iso8601
  end

  def created_at
    model.created_at.iso8601
  end
end
