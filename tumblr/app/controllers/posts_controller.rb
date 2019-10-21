class PostsController < ApplicationController

	def index 
		@posts = Post.all.order('created_at DESC')
	end

	def new 
		@post = Post.new

	end
	def show
		@post = Post.find(params[:id])
	end
	
	def create
		@post= Post.new(post_param)
		@post.save

		redirect_to @post
	end

	private
	
		def post_param
			params.require(:post).permit(:title, :body)
		end


end
