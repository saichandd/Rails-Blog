class PostsController < ApplicationController

    before_action :authenticate_user!,  except: [:index, :show]
    before_action :get_post, only: [:show, :edit, :update, :destroy]
    before_action :check_correct_user,   only: [:edit, :update, :destroy]

    def index
        @posts = Post.all.reverse_order
    end

    def new
        @post = current_user.posts.build
    end

    def create
        # current user to be asssociate d with posts in model
        @post = current_user.posts.build(post_params)
        if @post.save
            redirect_to @post
        else
            # a redirect would lose new http refresh, so we'd lose he content already entered
            render 'new'
        end
    end

    def show
    end

    def edit
    end

    def update
        if @post.update(post_params)
            redirect_to @post
        else
            render 'edit'
        end
    end

    def destroy
        @post.destroy
        redirect_to root_path
    end

    private def get_post
        @post = Post.find(params[:id])
    end

    private def post_params
        #strong parameters rails 4
        params.require(:post).permit(:title, :image)
    end

    def check_correct_user
       @user= User.find(current_user.id)
       redirect_to(root_url) unless current_user.id == @post.user.id
   end

end
