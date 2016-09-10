class SignReportsController < ApplicationController
  before_filter :authenticate_user!  
  before_action :set_sign_report, only: [:show, :edit, :update, :destroy]

  # GET /sign_reports
  # GET /sign_reports.json
  def index
    @sign_reports = SignReport.all
  end

  # GET /sign_reports/1
  # GET /sign_reports/1.json
  def show
  end

  # GET /sign_reports/new
  def new
    @sign_report = SignReport.new
  end

  # GET /sign_reports/1/edit
  def edit
  end

  # POST /sign_reports
  # POST /sign_reports.json
  def create
    @sign_report = SignReport.new(sign_report_params)
    unless params[:sign_report][:year].blank?
      @sign_report.year = DateTime.strptime(params[:sign_report][:year], "%Y")
    end
    @sign_report.save!
    flash[:notice] = '成功新增簽證報告'
    redirect_to action: 'index'
    rescue ActiveRecord::RecordInvalid
    render "edit"
  end

  # PATCH/PUT /sign_reports/1
  # PATCH/PUT /sign_reports/1.json
  def update
    if params[:sr_attachment_delete] == 'true' #delete sign_report attachments
      @sign_report.sr_attachment = nil
    end
    @sign_report.update(sign_report_params)
    unless params[:sign_report][:year].blank?
      @sign_report.year = DateTime.strptime(params[:sign_report][:year], "%Y")
    end
    @sign_report.save!
    flash[:notice] = '成功更新簽證報告'
    redirect_to action: 'index'
    rescue ActiveRecord::RecordInvalid
    render "edit"
  end

  # DELETE /sign_reports/1
  # DELETE /sign_reports/1.json
  def destroy
    @sign_report.destroy
    redirect_to({ controller: "sign_reports", action: 'index'}, notice: '成功刪除報告') 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sign_report
      @sign_report = SignReport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sign_report_params
      params.require(:sign_report).permit(:title, :year, :sr_attachment)
    end
end
