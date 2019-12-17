module SessionsHelper


  def log_in(user)
    session[:user_email] = user.email
  end
  
  
  def current_user
    @current_user ||= Driver.find_by(email: session[:user_email])
    @current_user ||= Student.find_by(email: session[:user_email])
    @current_user ||= Manager.find_by(email: session[:user_email])
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def log_out
    session.delete(:user_email)
    @current_user = nil
  end
  
    
  def get_user_type
    if @current_user.class.to_s == 'Student'
      'student'
    elsif @current_user.class.to_s == 'Driver'
      'driver'
    elsif @current_user.class.to_s == 'Manager'
     'manager'
    else
      nil
    end
    
  end
  def get_user_controller
    s = get_user_type
    if !s.nil?
      s + 's'
    else 
      nil
    end
  end
    
end
