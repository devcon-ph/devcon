class EntitiesController < ApplicationController
  load_resource :find_by => :slug
  load_and_authorize_resource 

  def index
    @entities = Entity.all
  end

  def new
  end

  def create
    @entity = Entity.create(entity_params)
    if @entity.save
      redirect_to entity_path(@entity), :notice => "Entity successfully created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @entity.update_attributes(entity_params)
      redirect_to entity_path(@entity), :notice => "Entity successfully updated"
    else
      render :edit
    end
  end

  def show
    @entity = Entity.find_by_slug!(params[:id])
  end

  private

    def entity_params
      params.require(:entity).permit(:blurb, :description, :level, :logo, :name, :slug, :type, :formal_name, :short_name
)
    end
end
