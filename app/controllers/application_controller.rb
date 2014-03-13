class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :log_history

  before_action :configure_permitted_parameters, if: :devise_controller?
  
  #layout :layout_by_resource

  #Output action history log.
  def log_history
    logger.info('[]' + request.method + "\t" + request.fullpath + "\t" + request.remote_ip + "\t" + Time.now.strftime('%Y-%m-%d %H:%M:%S'))
  end

  # Get a password.
  def get_password
    begin
      pw = generate_password
    end while Customer.exists?(:password => pw)
    return pw
  end
  
  # Generate a password.
  def generate_password
    [*1..9, *'A'..'Z', *'a'..'z'].sample(8).join
  end

  # Redirect to /admin
#  User::ROLES.each do |role|
#    define_method("authenticate_#{role}!") {
#      unless current_user.send("#{role}?")
#        redirect_to admin_path, alert: "Invalid role."
#      end
#    }
#  end
  protected

  def configure_permitted_parameters
    #strong parametersを設定し、usernameを許可
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end  


  def layout_by_resource
    if devise_controller?
      "admin/application"
    else
      "application"
    end
  end
end
