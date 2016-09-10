class SpecialProjectsController < ApplicationController
  before_filter :authenticate_user!  
  before_action :set_special_project, only: [:show, :edit, :update, :destroy]

  # GET /special_projects
  # GET /special_projects.json
  def index
    @special_projects = SpecialProject.all
  end

  # GET /special_projects/1
  # GET /special_projects/1.json
  def show
  end

  # GET /special_projects/new
  def new
    @special_project = SpecialProject.new
  end

  # GET /special_projects/1/edit
  def edit
  end

  # POST /special_projects
  # POST /special_projects.json
  def create
    @special_project = SpecialProject.new(special_project_params)
    @special_project.save!
    flash[:notice] = '成功新增專案合作'
    redirect_to action: 'index'
    rescue ActiveRecord::RecordInvalid
    render :action=>:edit
  end

  # PATCH/PUT /special_projects/1
  # PATCH/PUT /special_projects/1.json
  def update
    @special_project.update(special_project_params)
    @special_project.save!
    flash[:notice] = '成功更新專案合作'
    redirect_to action: 'index'
    rescue ActiveRecord::RecordInvalid
    render "edit"
  end

  # DELETE /special_projects/1
  # DELETE /special_projects/1.json
  def destroy
    @special_project.destroy
    redirect_to({ controller: "special_projects", action: 'index'}, notice: '成功刪除專案合作') 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_special_project
      @special_project = SpecialProject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def special_project_params
      params.require(:special_project).permit(:title, :title_enlarge, :link, :description)
    end
end
