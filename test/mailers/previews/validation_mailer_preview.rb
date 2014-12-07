# Preview all emails at http://localhost:3000/rails/mailers/validation_mailer
class ValidationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/validation_mailer/validate_mail
  def validate_mail
    ValidationMailer.validate_mail(Person.all.shuffle.first)
  end

end
