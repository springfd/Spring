class StoriesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_story, only: [:show, :edit, :update, :destroy]

  # GET /stories
  # GET /stories.json
  def index
    @stories = Story.all
  end

  # GET /stories/1
  # GET /stories/1.json
  def show
  end

  # GET /stories/new
  def new
    @story = Story.new
  end

  # GET /stories/1/edit
  def edit
  end

  # POST /stories
  # POST /stories.json
  def create
    @story = Story.new(story_params)
    @story.save!
    if params[:images]
        params[:images].each { |image|
          @story.pictures.create(image: image)
       }
    end
    redirect_to @story, notice: '成功新增最新消息' 
    rescue ActiveRecord::RecordInvalid
    render :action=>:edit
  end

  # PATCH/PUT /stories/1
  # PATCH/PUT /stories/1.json
  def update
    if params[:images_delete] == 'true'
      @story.pictures.destroy_all
    end
    
    if params[:images]
        params[:images].each { |image|
          @story.pictures.create(image: image)
       }
    end
    if @story.update(story_params)
      redirect_to @story, notice: '成功更新最新消息' 
    else
      render :action => :edit
    end
    
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    @story.destroy
    redirect_to stories_url, notice: 'Story was successfully destroyed.' 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_params
      params.require(:story).permit(:description, :topic, :video_url)
    end
end
