class EmployeeController < ApplicationController
  before_action :authenticate_user

  # リスト画面表示
  def index
    logger.info "#{self.class.name}\##{__method__} start"
    # 検索
    @q = Employee.ransack(params[:q])
    @employees = @q.result(distinct: true).page(params[:page])
    logger.info "#{self.class.name}\##{__method__} end"
  end

  # 新規登録画面表示
  def new
    logger.info "#{self.class.name}\##{__method__} start"
    @employee = Employee.new
    logger.info "#{self.class.name}\##{__method__} end"
  end

  # 新規登録
  def create
    logger.info "#{self.class.name}\##{__method__} start"
    # 社員情報を登録
    @employee = Employee.new(employee_params)
    if @employee.save
      flash[:notice] = I18n.t("dictionary.messages.create_success")
      redirect_to("/employee/index")
    else
      render("employee/new")
    end
    logger.info "#{self.class.name}\##{__method__} end"
  end

  # 編集画面表示
  def edit
    logger.info "#{self.class.name}\##{__method__} start"
    @employee = Employee.find_by(id: params[:id])
    @employee.stores
    logger.info "#{self.class.name}\##{__method__} end"
  end

  # 編集画面表示
  def update
    logger.info "#{self.class.name}\##{__method__} start"
    @employee = Employee.find_by(id: params[:id])
    if @employee.update(employee_params)
      flash[:notice] = I18n.t("dictionary.messages.update_success")
      redirect_to("/employee/index")
    else
      render("employee/edit")
    end
    logger.info "#{self.class.name}\##{__method__} end"
  end

  # 削除
  def destroy
    logger.info "#{self.class.name}\##{__method__} start"
    employee = Employee.find_by(id: params[:id])
    if employee.destroy
      flash[:notice] = I18n.t("dictionary.messages.destroy_success")
      # 自身のログイン中ユーザを削除した場合ログアウトする
      if session[:employee_id] == params[:id].to_i
        session[:employee_id] = nil
        redirect_to("/login")
      else
        redirect_to("/employee/index")
      end
    else
      render("employee/index")
    end
    logger.info "#{self.class.name}\##{__method__} end"
  end

  # ストロングパラメータ
  def employee_params
    params.require(:employee).permit(:name,:email,:password,:birthday,:joinday,:sex, { store_ids: [] })
  end
end
