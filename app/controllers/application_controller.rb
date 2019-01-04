class ApplicationController < ActionController::Base
  before_action :set_current_employee

  def set_current_employee
    logger.info "#{self.class.name}\##{__method__} start"
    @current_employee = Employee.find_by(id: session[:employee_id])
    logger.info "#{self.class.name}\##{__method__} end"
  end

  def authenticate_user
    logger.info "#{self.class.name}\##{__method__} start"
    if session[:employee_id] == nil
      flash[:notice] = I18n.t("dictionary.messages.login_yet")
      redirect_to("/login")
    end
    logger.info "#{self.class.name}\##{__method__} end"
  end
end
