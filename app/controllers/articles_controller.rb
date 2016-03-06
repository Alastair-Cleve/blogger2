class ArticlesController < ApplicationController
  include ArticlesHelper

  before_filter :require_login, except: [:index, :show]

  def require_login
    redirect_to root_path unless current_user
  end

  before_filter :check_username, only: [:destroy, :edit, :update]

  def check_username
    @article = Article.find(params[:id])
    redirect_to article_path(@article) unless current_user.username == @article.writer
  end

  def index
    @articles = Article.all
  end
  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comment.article_id = @article.id
  end
  def new
    @article = Article.new
  end
  def create
    @article = Article.new(article_params)
    @article.writer = current_user.username
    @article.save

    flash.notice = "Article '#{@article.title}' Created!"

    redirect_to article_path(@article)
  end
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    flash.notice = "Article '#{@article.title}' Destroyed!"

    redirect_to articles_path
  end
  def edit
    @article = Article.find(params[:id])
  end
  def update
    @article = Article.find(params[:id])
    @article.update(article_params)

    flash.notice = "Article '#{@article.title}' Updated!"

    redirect_to article_path(@article)
  end

end