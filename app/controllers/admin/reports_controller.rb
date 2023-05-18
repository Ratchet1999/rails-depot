class Admin::ReportsController < ApplicationController
  before_action :authorize_admin

  def new
  end

  def update
  end

  def index
    @from = params[:from].to_time if params[:from]
    @to = params[:to].to_time if params[:to]
    if @from && @to
      @orders = current_user.orders.where(created_at: @from..@to)
    else
      @orders = current_user.orders.where(created_at: 5.days.ago..Time.current())
    end
  end

  def create
  end

  def destroy
  end

  def show
  end

  def current_user
    User.find(session[:user_id])
  end

  protected def authorize_admin
    unless current_user.admin?
      redirect_to store_index_path, notice: "You don't have privilege to access this section"
    end
  end

end
