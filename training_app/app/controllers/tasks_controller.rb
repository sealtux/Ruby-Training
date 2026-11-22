class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = accessible_tasks.order(created_at: :desc)
  end

  def show
    @comment = Comment.new
  end

  def new
    @task = accessible_tasks.new
  end

  def create
    @task = accessible_tasks.new(task_params)
    if @task.save
      redirect_to @task, notice: "Task created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: "Task updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy!
    redirect_to tasks_path, notice: "Task deleted.", status: :see_other
  end

  private

  def set_task
    @task = accessible_tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :completed)
  end
end
