class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all.order(created_at: :desc)
    @tasks = Task.all.order(expired_at: :desc) if params[:sort_expired]
    @tasks = Task.where("title LIKE ?", "%#{params[:task][:title]}%") if params[:task].present?
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "タスクを作成しました！"
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:notice] = "タスクを編集しました！"
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = "タスクを削除しました！"
    redirect_to tasks_path
  end


  private

  def task_params
    params.require(:task).permit(:title, :content, :expired_at, :status)
  end
  
  def set_task
    @task = Task.find(params[:id])
  end
end