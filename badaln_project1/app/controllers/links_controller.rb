require 'securerandom'
class LinksController < ApplicationController
    
    
    def index
        @user = session[:user_id]
        
        if @user != nil
		  @l = Link.where(:user_id => session[:user_id])
        else
        end
        
    end
    
    def new
        @user = session[:user_id]
        if @user == nil
          flash[:notice] = "Log in to make a link."
          redirect_to(root_path)
        else
 		  @link = Link.new :user_id => session[:user_id], :short_url => SecureRandom.urlsafe_base64, :overall_usage => 0
        end
 	end
    
    def create
        @user = session[:user_id]
        if @user != nil
        @link = Link.new(link_params)
 		if @link.save
 			redirect_to link_path(:id => @link.short_url)
 		else
 			render :new
 		end
        else
          flash[:notice] = "Log in to shorten link."
          redirect_to(root_path)
        end
 	end
    
    def show
        @user = session[:user_id]
        @link = Link.find_by(short_url: params["id"])
        
        if @user == nil
            flash[:notice] = "You must login view this link's stats."
            redirect_to(root_path)
        elsif @link == nil
            flash[:notice] = "Hm. This link doesn't appear to exist."
            redirect_to(root_path)
        elsif @user != @link.user_id
            flash[:notice] = "You do not have the right permissions to view this link's stats."
            redirect_to(root_path)
        else 
        end
    
    end
    
    def go
        @link = Link.find_by(short_url: params["id"])
        
        if @link != nil
        url = @link.url
        num = @link.overall_usage + 1
        @link.overall_usage = num
        @link.save
        redirect_to(url)
        else
            flash[:notice] = "Hm. This link doesn't appear to exist."
            redirect_to(root_path)
        end
    end
    
    private 
 	def link_params
 		params.require(:link).permit(:title, :url, :user_id, :short_url, :overall_usage)
 	end
    
end