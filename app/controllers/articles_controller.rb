class ArticlesController < ApplicationController
  before_filter :paginate_articles, :only => :index
  load_resource :find_by => :slug
  load_and_authorize_resource

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @article.author = current_user
    if @article.save
      flash[:success] = 'Successfully published an article.'
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    params[:article][:category_ids] ||= []

    if @article.update_attributes(article_params)
      flash[:success] = 'Article has been updated!'
      redirect_to @article
    else
      render :action => 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = 'Successfully destroyed article'
    redirect_to articles_path
  end

  private

    def paginate_articles
      query = if user_signed_in? && (current_user.role?(:admin) ||
                                     current_user.role?(:author))
                Article.all
              else
                Article.where(:draft => false)
              end
      @articles = query.paginate(:page => params[:page])
    end

    def article_params
      params.require(:article).permit(:title, :draft, :content, { :category_ids => []}, :slug, :thumbnail, :opengraph_image, :summary)
    end
end
