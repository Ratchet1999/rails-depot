module CurrentUser
  private

    def current_user
      User.find(session[:user_id])
    end
end
