class MaintainerDecorator < Draper::Decorator
  delegate_all

  def as_json(*args)
    super only: [:id, :name, :email, :login, :time_zone, :jabber, :info, :website, :location], methods: [:created_at, :updated_at]
  end

  def avatar_url
    "https://gravatar.com/avatar/#{ gravatar_id }.png?s=420&r=g"
  end

  private

  def gravatar_id
    Digest::MD5.hexdigest(email.downcase)
  end

  def created_at
    model.created_at.iso8601
  end

  def updated_at
    model.updated_at.iso8601
  end
end
