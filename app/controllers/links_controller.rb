class LinksController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  

  # GET /links
  # GET /links.json
  def index
    @links = Link.all
  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)
    @link.save!
    flash[:notice] = '成功新增連結'
    redirect_to action: "index"
    rescue ActiveRecord::RecordInvalid
    render :action=>:edit
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    if @link.update(link_params)
      flash[:notice] = '成功更新連結'
      redirect_to action: "index"
    else
      render :edit
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    redirect_to links_url, notice: '成功刪除連結' 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:name, :web_addr)
    end
end
