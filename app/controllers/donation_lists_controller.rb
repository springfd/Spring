class DonationListsController < ApplicationController
  before_filter :authenticate_user!  
  before_action :set_donation_list, only: [:show, :edit, :update, :destroy]

  # GET /donation_lists
  # GET /donation_lists.json
  def index
    @donation_lists = DonationList.all
  end

  # GET /donation_lists/1
  # GET /donation_lists/1.json
  def show
  end

  # GET /donation_lists/new
  def new
    @donation_list = DonationList.new
  end

  # GET /donation_lists/1/edit
  def edit
  end

  # POST /donation_lists
  # POST /donation_lists.json
  def create
    @donation_list = DonationList.new(donation_list_params)
    unless params[:donation_list][:year].blank?
      @donation_list.year = DateTime.strptime(params[:donation_list][:year], "%Y")
    end
    @donation_list.save!
    flash[:notice] = '成功新增捐款徵信'
    redirect_to action: 'index'
    rescue ActiveRecord::RecordInvalid
    render "edit"
  end

  # PATCH/PUT /donation_lists/1
  # PATCH/PUT /donation_lists/1.json
  def update
    if params[:dl_attachment_delete] == 'true' #delete donation_list attachments
      @donation_list.dl_attachment = nil
    end
    @donation_list.update(donation_list_params)
    unless params[:donation_list][:year].blank?
      @donation_list.year = DateTime.strptime(params[:donation_list][:year], "%Y")
    end
    @donation_list.save!
    flash[:notice] = '成功更新捐款徵信'
    redirect_to action: 'index'
    rescue ActiveRecord::RecordInvalid
    render "edit"
  end

  # DELETE /donation_lists/1
  # DELETE /donation_lists/1.json
  def destroy
    @donation_list.destroy
    redirect_to({ controller: "donation_lists", action: 'index'}, notice: '成功刪除捐款徵信') 
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donation_list
      @donation_list = DonationList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def donation_list_params
      params.require(:donation_list).permit(:title, :year, :dl_attachment)
    end
end
