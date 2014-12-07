require 'test_helper'

class TokenTest < ActiveSupport::TestCase
  test "can create" do
    assert create(:token)
  end

  test "new with code" do
    p = create :person
    token =  Token.new person: p
    token.generate
    assert token.code
  end

  test "for" do
    p = create :person
    t = Token.for(p)
    assert t.id
    assert t.code
  end
end
