module SessionsHelper

  def sign_in(user)
    logger.info "AAA Signing in user."
    logger.info "AAA User remember_token is " + user.remember_token + "."
    # cookies.permanent[:remember_token] = user.remember_token
    cookies[:remember_token] = { value:   user.remember_token,
                             expires: 20.years.from_now.utc }
    self.current_user = user
    logger.info "AAA Cookies remember token is " + cookies[:remember_token]
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
    logger.info "AAA Setting current user. User is " + user.username ||  + "." if not user.nil?
    logger.info "AAA Setting current user. Current user is " + @current_user.username + "." if not @current_user.nil?
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == current_user
    logger.info "AAA In method current_user? User is " + user.username ||  + "." if not user.nil?
    logger.info "AAA In method current_user? Current user is " + @current_user.username + "." if not @current_user.nil?
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
end
