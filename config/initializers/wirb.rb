if Rails.env.test? || Rails.env.development?
  Wirb.start
end
