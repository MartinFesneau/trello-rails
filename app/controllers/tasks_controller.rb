class TasksController < ApplicationController
  
  def index
    @todo_list = Task.where(status: "todo", user_id: current_user).order(position: :asc)
    @inprogress_list = Task.where(status: "inprogress", user_id: current_user).order(position: :asc)
    @done_list = Task.where(status: "done", user_id: current_user).order(position: :asc)
  end

  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    @task.user = current_user
    @todo_list = Task.where(status: "todo")
    @task.position = @todo_list.length + 1
    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end
  
  def move_task
    task = Task.find(params[:id].to_i)
    task.update(status: params[:status])
    position = params[:position].to_i
    user_id = current_user.id
    Task.change_position(task, position, user_id)
  end

private 
  
  def task_params
    params.require(:task).permit(:id, :name, :position, :status)
  end
end

