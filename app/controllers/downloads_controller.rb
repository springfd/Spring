class DownloadsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_download, only: [:show, :edit, :update, :destroy]

  # GET /downloads
  # GET /downloads.json
  def index
    @downloads = Download.all
  end

  # GET /downloads/1
  # GET /downloads/1.json
  def show
  end

  # GET /downloads/new
  def new
    @download = Download.new
  end

  # GET /downloads/1/edit
  def edit
  end

  # POST /downloads
  # POST /downloads.json
  def create
    @download = Download.new(download_params)
    @download.save!
    flash[:notice] = '成功新增下載'
    redirect_to action: :index
    rescue ActiveRecord::RecordInvalid
    render :action=>:edit
  end

  # PATCH/PUT /downloads/1
  # PATCH/PUT /downloads/1.json
  def update
    if params[:download_file_delete] == 'true' #delete sign_report attachments
      @download.file_at = nil
    end
    if @download.update(download_params)
      flash[:notice] = '成功更新下載'
      redirect_to action: "index"
    else
      render :edit
    end
  end

  # DELETE /downloads/1
  # DELETE /downloads/1.json
  def destroy
    @download.destroy
    redirect_to downloads_url, notice: '成功刪除下載' 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_download
      @download = Download.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def download_params
      params.require(:download).permit(:title, :file_at)
    end
end
