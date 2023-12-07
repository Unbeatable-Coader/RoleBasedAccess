class UserController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    puts "user = #{@user.usertype}"
    if @user.usertype == "admin"
      @admin = Admin.new(user_params)
      if @admin.save
        redirect_to  login_path
      else
        render :new
      end
    elsif @user.usertype == "manager"
      @manager = Manager.new(user_params)
      if @manager.save
        redirect_to login_path
      else
        puts "Manager save failed: #{@manager.errors.full_messages}"
        render :new
      end
    else
      puts "inside employee"
      @employee = Employee.new(user_params)
      puts "employee = #{@employee}"
      if @employee.save
        puts "after save"
        redirect_to login_path
      else
        puts "Validation errors: #{@employee.errors.full_messages}"
        flash[:alert] = @employee.errors.full_messages
        return
      end
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :usertype, :password, :password_confirmation)
  end
end
