require 'test_helper'

class ValidationMailerTest < ActionMailer::TestCase
  test "validate_mail" do
    person = create :person

    mail = ValidationMailer.validate_mail(person)
    #assert_equal "Validate mail", mail.subject
    assert_equal [person.email], mail.to
    assert_equal [Rails.configuration.wichtler.from_email], mail.from

    assert_match person.name, mail.body.encoded
    assert_match Token.first.code, mail.body.encoded
  end

end
