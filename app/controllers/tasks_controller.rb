class TasksController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  respond_to :html, :js

  def create
    @task = current_user.tasks.build(task_params)
    @feed_items = current_user.feed.paginate(page: params[:page])
    if @task.save
      respond_with root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @feed_items = current_user.feed.paginate(page: params[:page])
    @task.destroy
    respond_with root_url
  end

  private

    def task_params
      params.require(:task).permit(:content)
    end

    def correct_user
      @task = current_user.tasks.find_by(id: params[:id])
      redirect_to root_url if @task.nil?
    end
end
