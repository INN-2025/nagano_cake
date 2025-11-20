class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
# 各アクションで毎回 @customer = ... と書かなくて済むためのコード
  before_action :set_customer, only: [:show, :edit, :update]

  def index
  end

  def edit
  end

  def show
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to public_customer_my_page_path, notice: "会員情報を更新しました。"
    else
      render :edit
    end
  end

  def unsubscribe

  end

  def withdraw
    @customer = Customer.find(params[:id])
    @user.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  private

  def set_customer
    @customer = current_customer
  end

  def customer_params
    params.require(:customer).permit(
      :last_name, :first_name,
      :last_name_kana, :first_name_kana,
      :email,
      :postal_code, :address, :telephone_number
    )
  end




end
