require 'test_helper'

class SecretSantaTest < ActiveSupport::TestCase

  test "can create" do
    p = create :secret_santa
    assert p
  end

end
