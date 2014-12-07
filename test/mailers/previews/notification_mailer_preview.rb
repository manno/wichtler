# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notification_mailer/your_partner
  def your_partner
    NotificationMailer.your_partner(Person.all.shuffle.first)
  end

end
