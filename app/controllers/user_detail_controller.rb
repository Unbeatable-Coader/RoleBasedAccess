class UserDetailController < ApplicationController
  before_action :set_current_user, only: [:userDetails]


  def userDetails
    @current_user

    if @current_user.nil?
      flash[:warning] = "please Login first"
      redirect_to login_path
    end
  end

  private

  def set_current_user
    token = session[:user_token]
    puts "Session token: #{token.inspect}"

    if token.present?
      user_info = JsonWebToken.decode(token)
      puts "Decoded user info: #{user_info.inspect}"

      user_id = user_info[:email]
      if user_id.present?
        puts "user email = #{user_id}"
        @current_user = Admin.find_by(email: user_id) || Manager.find_by(email: user_id) || Employee.find_by(email: user_id)
        puts "Found user: #{@current_user.inspect}"
      else
        puts "user id inside else = #{user_id}"
        @current_user = nil
      end
    else
      @current_user = nil
    end
  end
end
