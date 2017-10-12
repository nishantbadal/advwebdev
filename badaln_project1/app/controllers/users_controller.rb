class UsersController < ApplicationController
    
    def show
        @user = session[:user_id]
        if User.where(:name => params[:name]).count > 0
         @userAccount = User.find_by(name: params[:name])
         @posts = Post.where(:user_id => @userAccount.id)
         @likes = Like.all
        else
            flash[:notice] = 'User not found.'
            redirect_to root_path
        end
    end
    
    
end