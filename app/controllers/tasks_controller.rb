class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.created_at_sorted.page(params[:page])
    click_sort_expired_and_priority
    click_search
  end

  def show
    unless @task.user_id == current_user.id
      redirect_to tasks_path
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
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
      if params[:task][:tag_ids].present?
        flash[:notice] = "タスクを編集しました！"
        redirect_to tasks_path
      else
        @task.taggings.each do |task|
          task.destroy if task.task_id == @task.id
        end
        flash[:notice] = "タスクを編集しました！"
        redirect_to tasks_path
      end       
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
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority, tag_ids: [])
  end
  
  def set_task
    @task = Task.find(params[:id])
  end
end