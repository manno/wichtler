require 'test_helper'

class PublicControllerTest < ActionController::TestCase
  test "should confirm" do
    t = create :token
    person = t.person
    assert_difference('Token.count', -1) do
      get :confirm, code: t.code
    end
    assert_response :success
    assert_equal I18n.t(:email_validated), flash[:notice]
    person.reload
    assert_equal 'validated', person.state
  end

  test "should fail to confirm" do
    get :confirm, code: 'FAIL'
    assert_response :success
    assert_equal I18n.t(:invalid_token), flash[:error]
  end

end
