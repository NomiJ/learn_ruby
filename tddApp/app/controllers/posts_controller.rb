class PostsController < ApplicationController

  before_action :find_post, only: [:show]

  def index
  end
  def new
    @post = Post.new
  end
  
  def show
  end
  
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  private 
    def post_params
      params.require(:post).permit(:title, :caption)
    end

    def find_post
      @post = Post.find(params[:id])
    end


end
