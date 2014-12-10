Wichtler::Application.configure do
  config.action_mailer.default_url_options = { :host => ENV['VHOST'],  protocol: ENV['VHOST_PROTOCOL'] || 'http' }
  config.action_mailer.smtp_settings = {
    address: ENV['MAIL_HOST'],
    user_name: ENV['MAIL_USER'],
    password: ENV['MAIL_PASSWORD'],
    authentication: ENV['MAIL_AUTH_TYPE'],
    enable_starttls_auto: true,
    openssl_verify_mode: 'none'
  }
end
