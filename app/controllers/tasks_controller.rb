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
    else

      # error_string = @task.errors.messages.inject('') { |text, (key, value)| "#{text}\n#{key} #{value.join(', ')}" }
      # flash[:error] = { title: 'Submission Error', body: error_string }
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

