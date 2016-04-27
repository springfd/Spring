class ProjectsController < ApplicationController
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
    @project.year = DateTime.strptime(params[:project][:year], "%Y")
    @project.save!
    redirect_to @project, pj_kind: @project.kind, notice: 'Project was successfully created.'
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    if params[:attachment_delete] == 'true'
      @project.pj_attachment = nil
    end
    @project.update(project_params)
    @project.year = DateTime.strptime(params[:project][:year], "%Y")
    @project.save!
    redirect_to @project, pj_kind: @project.kind, notice: 'Project was successfully updated.'
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    redirect_to({ controller: "projects", action: 'index' , pj_kind: @project.kind}, notice: 'Project was successfully destroyed.') 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:kind, :year, :name, :budget, :exp_personnel, :exp_business, :exp_mix, :exp_other, :exe_desc, :donate_flag, :abbreviation, :account_begin, :account_end, :income, :p_account, :p_password, :pj_attachment)
    end
end
