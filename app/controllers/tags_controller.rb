class TagsController < ApplicationController
  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to new_task_path, notice: 'タグが生成されました'
    else
      render :new
    end
  end

  def index
    @tags = Tag.all
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to new_task_path, notice: 'タグをを消去しました'
  end

  private
  def tag_params
    params.require(:tag).permit(:title)
  end
end
