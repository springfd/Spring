class ProjectsController < ApplicationController
  before_filter :authenticate_user!, except: [:checkLogin]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :get_next_stage_id, only: [:new, :edit]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.where("kind = ? and id != ?", params[:pj_kind], 1).order('id DESC').paginate(per_page: 30, page: params[:page])
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
    set_pj_account
  end

  # GET /projects/1/edit
  def edit
    @pj_account = @project.account
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    unless params[:project][:year].blank?
      @project.year = DateTime.strptime(params[:project][:year], "%Y")
    end
    @project.save!
    #stage create
    unless params[:stage_id].blank?
      params[:stage_id].each do |key, value|
        stage = Stage.create(project_id: @project.id, title: params[:stage_title][key], stageDate: params[:stage_date][key], description: params[:stage_description][key], video_url: params[:stage_url][key])
        store_stage_image(stage, params[:stage], key)
        stage.save!
      end
    end
    #end stage create
    redirect_to @project, pj_kind: @project.kind, notice: '成功新增計畫'
    rescue ActiveRecord::RecordInvalid
    params[:pj_kind] = params[:project][:kind].to_i
    get_next_stage_id
    set_pj_account
    render "edit"
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    check_delete exp_at: params[:exp_attachment_delete], don_at: params[:donation_attachment_delete], pj_at: params[:attachment_delete], cover_at: params[:cover_delete]
    @project.update(project_params)
    unless params[:project][:year].blank?
      @project.year = DateTime.strptime(params[:project][:year], "%Y")
    end
    @project.save!
    record_log
    #stage update
    unless params[:stage_id].blank?
      params[:stage_id].each do |key, value|
        stage = @project.stages.find_by_id(key)
        #delete stage image
        unless stage.blank?
          if params[:stage_image_delete][key] == 'true'
            stage.image = nil
          end
          stage.title = params[:stage_title][key]
          stage.stageDate = params[:stage_date][key]
          stage.description = params[:stage_description][key]
          stage.video_url = params[:stage_url][key]
          store_stage_image(stage, params[:stage], key)
        else
          stage = Stage.create(project_id: @project.id, title: params[:stage_title][key], stageDate: params[:stage_date][key], description: params[:stage_description][key], video_url: params[:stage_url][key])
          store_stage_image(stage, params[:stage], key)    
        end
        stage.save!
      end
    end
    #end stage update
    redirect_to @project, pj_kind: @project.kind, notice: '成功更新計畫'
    rescue ActiveRecord::RecordInvalid
    params[:pj_kind] = params[:project][:kind].to_i
    get_next_stage_id
    @pj_account = @project.account
    render "edit"
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    redirect_to({ controller: "projects", action: 'index' , pj_kind: @project.kind}, notice: '成功刪除計畫') 
  end
  
  def delete_stage
    stage = Stage.find_by_id(params[:id])
    stage.destroy
    render json: {success: true, message: '成功刪除' }.to_json
  end
  
  def checkLogin
    @project = Project.find_by_account_and_password(params[:project_account], params[:project_password])
    if @project.blank?
      render json: { success: false }.to_json
    else
      render json: { success: true, id: @project.id, 
                     name: @project.name, budget: @project.budget, exe_desc: @project.exe_desc,
                     description: @project.description, year: @project.year.strftime("%Y"),
                     file_name: @project.pj_attachment_file_name, file_url: @project.pj_attachment.url(:original, false),
                     exp_personnel: @project.exp_personnel, exp_mix: @project.exp_mix,
                     exp_business: @project.exp_business, exp_other: @project.exp_other,
                     balance: @project.balance,                      
                     income: @project.donations.where("donate_date >= ? and donate = ? ", Time.zone.now.beginning_of_year, true ).sum(:amount),
                     exp_file_name: @project.pj_exp_attachment_file_name, exp_file_url: @project.pj_exp_attachment.url}.to_json
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:kind, :year, :name, :description, :budget, :balance, :exe_desc, :abbreviation, :account_begin, :account_end, :income, :account, :password, :pj_attachment, :pj_cover, :donate_begin_at, :donate_end_at, :pj_exp_attachment, :pj_donation_attachment, :email, :phone, :holder)
    end
    
    def record_log
      Log.create(user_id: current_user.id, project_id: @project.id )
    end
    
    def get_next_stage_id #so that we can generate a Stage id won't collide with existing Stage id
      unless Stage.maximum(:id).blank?
        @stage_next_id = Stage.maximum(:id).next
      else
        @stage_next_id = 1
      end
    end
    
    def get_next_project_id
      unless Project.maximum(:id).blank?
        @pj_next_id = Project.maximum(:id).next
      else
        @pj_next_id = 1
      end
    end
    
    def set_pj_account
      get_next_project_id
      @pj_account = DateTime.now.strftime("%Y%m%d")+"_"+@pj_next_id.to_s
    end
    
    def store_stage_image(stage, stage_params, key)
      unless stage_params.blank?
        unless stage_params[:image][key].blank?
          stage.image = stage_params[:image][key]
        end
      end
    end
    
    def check_delete(options = {})
      if options[:exp_at] == 'true' #delete project expense attachments
        @project.pj_exp_attachment = nil
      end
      if options[:don_at] == 'true' #delete project donation attachments
        @project.pj_donation_attachment = nil
      end
      if options[:pj_at] == 'true' #delete project attachments
        @project.pj_attachment = nil
      end
      if options[:cover_at] == 'true' #delete project cover photo
        @project.pj_cover = nil
      end
    end
    
end
