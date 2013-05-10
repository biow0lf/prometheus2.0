if Rails.env.test? || Rails.env.development?
  Hirb.enable
end
