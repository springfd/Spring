class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.where("kind = ? ", params[:pj_kind]).order('id DESC').paginate(per_page: 30, page: params[:page])
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    unless params[:project][:year].blank?
      @project.year = DateTime.strptime(params[:project][:year], "%Y")
    end
    @project.save!
    redirect_to @project, pj_kind: @project.kind, notice: '成功新增計畫'
    rescue ActiveRecord::RecordInvalid
    params[:pj_kind] = params[:project][:kind].to_i
    render "edit"
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    if params[:attachment_delete] == 'true' #delete project attachments
      @project.pj_attachment = nil
    end
    if params[:cover_delete] == 'true' #delete project cover photo
      @project.pj_cover = nil
    end
    @project.update(project_params)
    @project.year = DateTime.strptime(params[:project][:year], "%Y")
    @project.password = params[:project][:encrypted_password]
    @project.save!
    record_log
    redirect_to @project, pj_kind: @project.kind, notice: '成功更新計畫'
    rescue ActiveRecord::RecordInvalid
    render "edit", pj_kind: @project.kind
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    redirect_to({ controller: "projects", action: 'index' , pj_kind: @project.kind}, notice: '成功刪除計畫') 
  end

  def check_login
    @project = Project.find_by_account_and_password(params[:login_name], params[:login_pass])
    if @project.blank?
      flash[:error] = '帳號密碼錯誤'
      flash.keep(:notice)
      render :json => {:success => false, :location => url_for(:controller => 'main', :action => 'donation')}.to_json
    else
      render :json => {:success => true, :location => url_for(:controller => 'projects', :action => 'show', :id => @project.id)}.to_json
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:kind, :year, :name, :budget, :exp_personnel, :exp_business, :exp_mix, :exp_other, :exe_desc, :donate_flag, :abbreviation, :account_begin, :account_end, :income, :account, :password, :pj_attachment, :pj_cover, :donate_begin_at, :donate_end_at)
    end
    
    def record_log
      Log.create(user_id: current_user.id, project_id: @project.id )
    end
    
end
