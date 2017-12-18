if Rails.env.production?
  Rails.application.config.middleware.use ExceptionNotification::Rack,
                                          email: {
                                            email_prefix: '[ERROR] ',
                                            sender_address: %('Sisyphus 2.0 Error' <prometheus-noreply@altlinux.org>),
                                            exception_recipients: ['igor.zubkov@gmail.com']
                                          }
end
