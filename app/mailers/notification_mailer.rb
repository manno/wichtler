class NotificationMailer < ActionMailer::Base
  default from: Rails.configuration.wichtler.from_email

  def your_partner(person)
    @person = person
    I18n.with_locale(person.locale) do
      mail to: person.email
    end
    person.update_attributes(state: 'notified')
  end

end
