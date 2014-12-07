class PublicController < ApplicationController
  def confirm
    code = params[:code]
    token = Token.find_by(code: code)
    unless token
      flash.now[:error] = t(:invalid_token)
      return
    end

    token.person.update_attributes(state: 'validated')
    token.delete
    flash.now[:notice] = t(:email_validated)
  end
end
