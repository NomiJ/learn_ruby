class CommentsController < ApplicationController

    before_action :find_post, only: [:create, :destroy]


	def index 
		@comments = Comment.all.order('created_at DESC')
	end

	def new 
		@comment = Comment.new

	end
	def show
	end
	def edit
	end
	def destroy
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to	post_path(@post)
	end
	def update
		if @comment.update(comment_param)
			redirect_to @comment
		else
			render 'edit'
		end
	end

	def create
		@comment= @post.comments.create(comment_param)
		if @comment.save
			redirect_to post_path(@post)
		end
	end

	private
	
		def comment_param
			params.require(:comment).permit(:name, :body)
		end

		def find_comment
			@comment = Comment.find(params[:id])
		end


		def find_post
			@post = Post.find(params[:post_id])
		end


end
