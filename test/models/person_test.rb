require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test 'can create person' do
    p = create :person
    assert p.save!
  end

  test 'does add partner' do
    p = create :person
    o = create(:person)

    p.partner = o
    p.save

    assert_equal o, p.partner
  end

  test 'bidirectional_partnership' do
    p = create :person
    o = create(:person)

    Person.bidirectional_partnership(p, o)

    assert_equal o, p.partner
    assert_equal p, o.partner
  end

  test 'does validate' do
    p = create :person
    assert p.valid?
  end

  test 'assigns partners' do
    create :person
    create :person
    create :person
    create :person
    Person.assign_partners(Person.all)
    assert_equal SecretSanta.all.count, 4
    assert_not SecretSanta.all.map(&:receiver).any?(&:nil?)
  end

  test 'possible partners' do
    person, old_partner = create_pair
    new_partner = create :person, partner: person
    other_person = create :person
    create_pair

    partners = Person.possible_partners(person)
    assert_equal 3, partners.count
    assert_includes partners, old_partner
    assert_includes partners, new_partner
    assert_includes partners, other_person
  end

  def create_pair
    partner = create :person
    person = create :person
    Person.bidirectional_partnership(partner, person)
    [person, partner]
  end
end
