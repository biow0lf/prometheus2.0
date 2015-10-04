class MaintainerDecorator < Draper::Decorator
  delegate_all

  def as_json(*args)
    {
      id: id,
      name: name,
      email: email,
      login: login,
      time_zone: time_zone,
      jabber: jabber,
      info: info,
      website: website,
      location: location,
      created_at: created_at.iso8601,
      updated_at: updated_at.iso8601
    }
  end

  def avatar_url
    "http://gravatar.com/avatar/#{ gravatar_id }.png?s=420&r=g"
  end

  private

  def gravatar_id
    Digest::MD5.hexdigest(email.downcase)
  end
end
