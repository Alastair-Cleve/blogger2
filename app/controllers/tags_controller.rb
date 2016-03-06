class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end
  def show
    @tag = Tag.find(params[:id])
  end

  before_filter :require_login, only: [:destroy]

  def require_login
    redirect_to root_path unless current_user
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    flash.notice = "Tag '#{@tag.name}' Destroyed!"

    redirect_to tags_path
  end
end
