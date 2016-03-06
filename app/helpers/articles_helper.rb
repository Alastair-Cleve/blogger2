module ArticlesHelper
  def article_params
    params.require(:article).permit(:title, :writer, :body, :tag_list, :image)
  end
end
