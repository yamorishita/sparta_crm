class CustomersController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = Customer.ransack(params[:q])
    @customers = Customer.page(params[:page])
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer
    else
      render :new
    end
  end

    def edit
  end

  def update
    @customer = Customer.find(params[:id])
    if  @customer.update(customer_params)
      redirect_to @customer
    else
      render :edit
    end
  end

  def show
    @customer = Customer.find(params[:id])
    @comment = Comment.new
    @comments = @customer.comments
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to customers_url
  end


  private
  def customer_params
    params.require(:customer).permit(
      :family_name,
      :given_name,
      :email
      )
  end

end
