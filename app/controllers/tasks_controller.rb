class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.created_at_sorted.page(params[:page])
    if params[:sort_expired]
      @tasks = Task.expired_at_sorted.page(params[:page])
    elsif params[:sort_priority]
      @tasks = Task.priority_sorted.page(params[:page])
    elsif params[:task].present?
        if params[:task][:title].present? && params[:task][:status].present?
          @tasks = Task.title_and_status_search(params[:task][:title], params[:task][:status]).page(params[:page])
        elsif params[:task][:title].present?
          @tasks = Task.title_search(params[:task][:title]).page(params[:page])
        elsif params[:task][:status].present?
          @tasks = Task.status_search(params[:task][:status]).page(params[:page])
        end
      end
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
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority)
  end
  
  def set_task
    @task = Task.find(params[:id])
  end
end