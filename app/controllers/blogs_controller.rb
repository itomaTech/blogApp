class BlogsController < ApplicationController


  def index
    @blogs = Blog.all.includes(:user).order("created_at DESC")
  end

  def new
  end

  def create
    Blog.create(text: blog_params[:text], user_id: current_user.id)
    redirect_to root_path
  end

  def destroy
    blog = Blog.find(params[:id])
    blog.destroy
    redirect_to root_path
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    blog = Blog.find(params[:id])
    if current_user.id == blog.user_id
      blog.update(blog_params)
    end
    redirect_to root_path
  end

  protected
  def  blog_params
    params.require(:blog).permit(:text)
  end
end
