require 'test_helper'

class NotificationMailerTest < ActionMailer::TestCase

  test "your_partner" do
    person = create :person
    receiver = create :person
    SecretSanta.create santa: person, receiver: receiver

    mail = NotificationMailer.your_partner(person)
    assert_equal [person.email], mail.to
    assert_equal [Rails.configuration.wichtler.from_email], mail.from
    assert_match person.name, mail.body.encoded
    assert_match receiver.name, mail.body.encoded
  end

end
