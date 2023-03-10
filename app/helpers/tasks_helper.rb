module TasksHelper
  def click_sort_expired_and_priority
    if params[:sort_expired]
      @tasks = current_user.tasks.expired_at_sorted.page(params[:page])
    elsif params[:sort_priority]
      @tasks = current_user.tasks.priority_sorted.page(params[:page])
    end
  end

  def click_search
    if params[:task].present?
      if params[:task][:title].present? && params[:task][:status].present? && params[:task][:tag_id].present?
        taggings_tasks = Tag.tag_search(params[:task][:tag_id]).tasks
        @tasks = taggings_tasks.title_and_status_current_user_search(params[:task][:title], params[:task][:status], current_user.id).page(params[:page])
      elsif params[:task][:title].present? && params[:task][:status].present?
        @tasks = current_user.tasks.title_and_status_search(params[:task][:title], params[:task][:status]).page(params[:page])
      elsif params[:task][:title].present? && params[:task][:tag_id].present?
        taggings_tasks = Tag.tag_search(params[:task][:tag_id]).tasks
        @tasks = taggings_tasks.title_current_user_search(params[:task][:title], current_user.id).page(params[:page])              
      elsif params[:task][:status].present? && params[:task][:tag_id].present?
        taggings_tasks = Tag.tag_search(params[:task][:tag_id]).tasks
        @tasks = taggings_tasks.status_current_user_search(params[:task][:status], current_user.id).page(params[:page])   
      elsif params[:task][:title].present?
        @tasks = current_user.tasks.title_search(params[:task][:title]).page(params[:page])           
      elsif params[:task][:status].present?
        @tasks = current_user.tasks.status_search(params[:task][:status]).page(params[:page])          
      elsif params[:task][:tag_id].present?
        taggings_tasks = Tag.tag_search(params[:task][:tag_id]).tasks
        @tasks = taggings_tasks.tag_search(current_user.id).page(params[:page])
      end
    end
  end
end
