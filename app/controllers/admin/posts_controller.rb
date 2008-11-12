class Admin::PostsController < Admin::ApplicationController
  before_filter :load_new_post, :only => %w[new create]
  before_filter :load_post,     :only => %w[edit update destroy]

  def create
    if @post.save
      redirect_to @post.continue_editing ? edit_admin_post_path(@post) : admin_root_path
    else
      render :action => 'new'
    end
  end

  def update
    if @post.update_attributes(params[:post])
      redirect_to @post.continue_editing ? edit_admin_post_path(@post) : admin_root_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to admin_root_path
  end

  private

  def load_new_post
    @post = Post.new(params[:post])
  end

  def load_post
    @post = Post.find(params[:id])
  end
end
