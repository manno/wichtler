class ValidationMailer < ActionMailer::Base
  default from: Rails.configuration.wichtler.from_email

  def validate_mail(person)
    @person = person
    @token = Token.for(person)
    I18n.with_locale(person.locale) do
      mail to: person.email
    end
  end
end
