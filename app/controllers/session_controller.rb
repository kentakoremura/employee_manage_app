class SessionController < ApplicationController
  # ログイン画面表示
  def login_form
    logger.info "#{self.class.name}\##{__method__} start"
    @employee = Employee.new
    logger.info "#{self.class.name}\##{__method__} end"
  end

  # ログイン認証
  # 成功：リスト画面にリダイレクト
  # 失敗：ログイン画面再表示
  def login
    logger.info "#{self.class.name}\##{__method__} start"
    employee = Employee.find_by(email: session_params[:email])
    if employee&.authenticate(session_params[:password])
      session[:employee_id] = employee.id
      flash[:notice] = I18n.t("dictionary.messages.login_success")
      redirect_to("/employee/index")
    else
      @login_error = I18n.t("dictionary.messages.login_error")
      # modelが空になるので再設定
      @employee = Employee.new(email: session_params[:email], password: session_params[:password])
      render :login_form
      return
    end
    logger.info "#{self.class.name}\##{__method__} end"
  end

  # ログアウト
  # ログイン画面にリダイレクト
  def logout
    logger.info "#{self.class.name}\##{__method__} start"
    session[:employee_id] = nil
    flash[:notice] = I18n.t("dictionary.messages.logout_success")
    redirect_to("/login")
    logger.info "#{self.class.name}\##{__method__} end"
  end

  # ストロングパラメータ
  def session_params
    params.require(:employee).permit(:email, :password)
  end
end
