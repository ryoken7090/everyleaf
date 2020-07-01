class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  PER  = 10
  # GET /tasks
  def index
    @tasks = Task.page(params[:page]).per(PER)
    if params[:sort_expired]
      @tasks = @tasks.order(expired_at: "ASC")
    end

    if params[:sort_priority]
      @tasks = @tasks.order(priority: "DESC")
    end

    if params[:title].present? && params[:status].present?
      @tasks = @tasks.title_search(params[:title]).status_search(params[:status])
    elsif params[:title].present?
      @tasks = @tasks.title_search(params[:title])
    elsif params[:status].present?
      @tasks = @tasks.status_search(params[:status])
    end
  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      redirect_to @task, notice: 'タスクが生成されました'
    else
      render :new
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      redirect_to @task, notice: '更新しました'
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'タスクを消去しました'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:title, :content, :expired_at, :status, :priority)
    end
end
