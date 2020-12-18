class TasksController < ApplicationController
  
  def index
    @todo_list = Task.where(status: 1)
    @inprogress_list = Task.where(status: 2)
    @done_list = Task.where(status: 3)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end
end


private 

def task_params
  params.require(:task).permit(:name)
end