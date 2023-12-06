class TasksController < ApplicationController
  before_action :set_current_user, only: [:new, :create, :show, :review]




  def new
    @task = Task.new
  end

  def create
    if @current_user.usertype == "employee"
      flash[:warning] = "You are not an authorised person to create a task."
      redirect_to newTask_path
    elsif
      @task = @current_user.tasks.build(task_params)
      puts "created by = #{@createdBy}"
      @role = @task.assign_to
    end
    if @current_user.usertype == "admin" || @current_user.usertype == "manager"
      if @task.save
        redirect_to tasks_path, notice: 'Task was successfully created.'
      else
        render :new
      end
    end
  end

  def show
    @current_user
    puts "current user = #{@current_user}"
    @tasks = Task.all
  end


  def review
    @current_user
    puts "current user in review def = #{@current_user}"
    if @current_user.usertype == "employee"
      @task = Task.find_by(id: params[:task_id])
    else
      @task = Task.find_by(params[:id])
    end
    @reviews = ReviewTask.all
    puts "task = #{@task.id}"
    if @current_user.present?
      if @current_user.usertype == "employee"
        @reviewTask = ReviewTask.new(@task.attributes)
        @reviewTask.save
      end
    else
      redirect_to review_path
    end

  end

  def reviewTask
    puts "current user in reviewTask def = #{@current_user}"
    if @current_user.usertype == "manager" || @current_user.usertype == "admin"
      @reviewTask = ReviewTask.new(@task.attributes)
      @reviewTask.save
    end
  end


  def update
    @task = ReviewTask.find(params[:task_id])
    puts "task id = #{@task.id}"
    puts "Params: #{params.inspect}"
    review_status = params[:status]
    if review_status == 'done'
      @task.color = 'lightgreen'
      @task.status = 'done'
    elsif review_status == 'pending'
      @task.color = 'lightcoral'
      @task.status = 'pending'
    else
      @task.color = 'yellow'
      @task.status = 'active'
    end
    @task.save
    redirect_to review_path
  end




  private

  def task_params
    params.require(:task).permit(:title, :description, :assign_to, :status)
  end

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
