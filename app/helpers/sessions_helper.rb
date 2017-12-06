module SessionsHelper

  # Logs in the given user.
  def log_in(member)
    session[:member_id] = member.id
    session[:email]=member.email
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= Member.find_by(id: session[:member_id])
  end
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
    reset_session
  end

  def is_admin?
    if Member.find_by(email: session[:email]).state=='admin'
      session[:is_admin?] = true
    end
  end

  def is_sysadmin?
    if Member.find_by(email: session[:email]).state=='sysadmin'
      session[:is_sysadmin?] = true
      session[:is_admin?]=true
    end
  end
end