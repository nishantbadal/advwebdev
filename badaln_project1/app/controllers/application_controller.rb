class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
    
    before_action :set_page


    def set_page
      @user = session[:user_id]
      if session[:user_id] == nil
          @userSes = "Hello, guest!"
      else
          @userSes = User.find_by(id: session[:user_id])
          @userSes = "Hello, " + @userSes.name + "!"
      end
    end
end
