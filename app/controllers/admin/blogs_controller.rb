class Admin::BlogsController < Admin::ApplicationController
  before_filter :load_new_blog, :only => %w[new create]
  before_filter :load_blog,     :only => %w[edit update destroy]

  def create
    if @blog.save
      redirect_to @blog.continue_editing ? edit_admin_blog_path(@blog) : admin_root_path
    else
      render :action => 'new'
    end
  end

  def update
    if @blog.update_attributes(params[:blog])
      redirect_to @blog.continue_editing ? edit_admin_blog_path(@blog) : admin_root_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @blog.destroy
    redirect_to admin_root_path
  end

  private

  def load_new_blog
    @blog = Blog.new(params[:blog])
  end

  def load_blog
    @blog = Blog.find(params[:id])
  end
end
