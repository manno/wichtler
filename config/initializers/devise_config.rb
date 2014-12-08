Devise.setup do |config|
  config.secret_key = ENV['DEVISE_SECRET_KEY']
  config.mailer_sender = ENV['DEVISE_MAIL_SENDER']
end
