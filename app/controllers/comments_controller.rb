class CommentsController < ApplicationController

    before_action :authenticate_user!,  only: [:create, :destroy]
    before_action :get_post, only: [:create, :destroy]


    def create
        @comment = @post.comments.build(comment_params)

        # associating with user -- can also use merge in above line itself
        @comment.user_id = current_user.id

        @comment.save
        redirect_to post_path(@post)
    end

    def destroy
        @user= User.find(current_user.id)
        @comment = @post.comments.find(params[:id])

        # checks corrent user
        redirect_to(root_url) unless current_user.id == @comment.user.id

        @comment.destroy
        redirect_to post_path(@post)
    end

    private def get_post
        @post = Post.find(params[:post_id])
    end


    private def comment_params
        params.require(:comment).permit(:body)
    end
    
end
