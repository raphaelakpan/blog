class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all.order(:created_at).page(params[:page]).per(params[:size] || 2)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(projects_params)

    if @project.save
      redirect_to projects_path, notice: "Project successfully created!"
    else
      render :new, error: "There was an error"
    end
  end


  def edit
  end

  def update
    if @project.update(projects_params)
      redirect_to projects_path, notice: "Project successfully updated"
    else
      render :edit, error: "There was an error updating project"
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  private

  def projects_params
    params.require(:project).permit(:title, :description, :link, :image_link)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
