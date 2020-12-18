class TasksController < ApplicationController
  
  def index
    @todo_list = Task.where(status: "todo")
    @inprogress_list = Task.where(status: "inprogress")
    @done_list = Task.where(status: "done")
  end

  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
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
    Task.change_position(task, params[:position].to_i)
  end

private 
  
  def task_params
    params.require(:task).permit(:id, :name, :position, :status)
  end
end

