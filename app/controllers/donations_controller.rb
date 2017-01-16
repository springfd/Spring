class DonationsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_donation, only: [:show, :edit, :update, :destroy]

  # GET /donations
  # GET /donations.json
  def index
    @donations = Donation.all
  end

  # GET /donations/1
  # GET /donations/1.json
  def show
    @project_name = Project.find(@donation.project_id).name
  end

  # GET /donations/new
  def new
    @donation = Donation.new
  end

  # GET /donations/1/edit
  def edit
  end

  # POST /donations
  # POST /donations.json
  def create
    @donation = Donation.new(donation_params) 
    @donation.save!
    @donation.order_num = generate_order_num()    
    @donation.save!  
    redirect_to @donation, notice: '成功新增捐款' 
    rescue ActiveRecord::RecordInvalid
    render :edit
  end

  # PATCH/PUT /donations/1
  # PATCH/PUT /donations/1.json
  def update
    if @donation.update(donation_params)
      redirect_to @donation, notice: '成功更新捐款' 
    else
      render :edit 
    end
  end

  # DELETE /donations/1
  # DELETE /donations/1.json
  def destroy
    @donation.destroy
    redirect_to donations_url, notice: '成功刪除捐款' 
  end

  private
    def generate_order_num
      order_no = "NO"; 
      order_no  << Date.today.to_s.gsub(/[^0-9]/, '')
      order_no << "_"+@donation.id.to_s
      return order_no
    end
      
    # Use callbacks to share common setup or constraints between actions.
    def set_donation
      @donation = Donation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def donation_params
      params.require(:donation).permit(:name, :amount, :donate_way, :donate_date, :donate, :project_id, :receipt_title, :receipt_address, :phone, :email, :description, :order_num)
    end
end
