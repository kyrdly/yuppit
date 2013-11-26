class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  
  def index
   @ideas = Idea.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 8)
 end

  def show
  end

  def new
    @idea = current_user.ideas.build
  end

  def edit
  end

  def create
    @idea = current_user.ideas.build(idea_params)
    if @idea.save
      redirect_to @idea, notice: 'nice'
    else
      render action: 'new'
    end
  end

  def update
    if @idea.update(idea_params)
      redirect_to @idea, notice: 'nice'
    else
      render action: 'edit'
    end
  end

  def destroy
    @idea.destroy
    redirect_to ideas_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end

    def correct_user 
      @idea = current_user.ideas.find_by(id: params[:id])
      redirect_to ideas_path, notice: "Not authorized to edit this" if @idea.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def idea_params
      params.require(:idea).permit(:description, :image)
    end
end