class TasksController < ApplicationController
  
  def index
    @todo_list = Task.where(status: "todo", user_id: current_user).order(position: :asc)
    @inprogress_list = Task.where(status: "inprogress", user_id: current_user).order(position: :asc)
    @done_list = Task.where(status: "done", user_id: current_user).order(position: :asc)
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    @todo_list = Task.where(status: "todo")
    @task.position = @todo_list.length + 1
    if @task.save
      redirect_to tasks_path
      # the respond to format.js is useful if i want to do more specific stuff after the ajax call, need to have a create.js.erb file in views/tasks
      # respond_to do |format|
      #   format.html { redirect_to tasks_path }
      #   # format.json { render json: { success: true } }
      #   format.js
      # end
    else
      flash.alert = "Content can not be blank"
      redirect_to tasks_path
    end
  end
  
  def move_task
    task = Task.find(params[:id].to_i)
    task.update(status: params[:status])
    new_position = params[:position].to_i
    user_id = current_user.id
    Task.persist_position(task, new_position)
  end

  def destroy
    task = Task.find(params[:id].to_i)
    task.destroy
    Task.update_array(task)
    redirect_to tasks_path
  end

private 
  
  def task_params
    params.require(:task).permit(:id, :name, :position, :status)
  end
end

