class Admin::ArticlesController < Admin::ApplicationController
  before_filter :load_new_article, :only => %w[new create]
  before_filter :load_article,     :only => %w[edit update destroy]

  def create
    if @article.save
      redirect_to @article.continue_editing ? edit_admin_article_path(@article) : admin_root_path
    else
      render :action => 'new'
    end
  end

  def update
    if @article.update_attributes(params[:article])
      redirect_to @article.continue_editing ? edit_admin_article_path(@article) : admin_root_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to admin_root_path
  end

  private

  def load_new_article
    @article = Article.new(params[:article])
  end

  def load_article
    @article = Article.find(params[:id])
  end
end
