class TagsController < ApplicationController
  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to new_tag_path, notice: 'タスクが生成されました'
    else
      render :new
    end
  end

  def index
  end

  def destroy

  end

  private
  def tag_params
    params.require(:tag).permit(:title)
  end
end
