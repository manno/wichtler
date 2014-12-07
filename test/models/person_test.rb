require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test "can create person" do
    p = create :person
    assert p.save!
  end

  test "does add partner" do
    p = create :person
    o = create(:person)

    p.partner = o
    p.save

    assert_equal o, p.partner
  end

  test "bidirectional_partnership" do
    p = create :person
    o = create(:person)

    Person.bidirectional_partnership(p, o)

    assert_equal o, p.partner
    assert_equal p, o.partner
  end

  test "does validate" do
    p = create :person
    assert p.valid?
  end

  test "assigns partners" do
    create :person
    create :person
    create :person
    create :person
    Person.assign_partners(Person.all)
    assert_equal SecretSanta.all.count, 4
    assert_not SecretSanta.all.map(&:receiver).any?(&:nil?)
  end
end
