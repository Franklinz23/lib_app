class LibrariesController < ApplicationController

  def index
    @libraries = Library.all
  end

  def new
    @library = Library.new
    render :new
  end

  def create
    library_params = params.require(:library).permit(:name, :floor_count, :floor_area)
    @library = Library.create(library_params)

    redirect_to libraries_path
  end

  def show
    @library = Library.find_by_id params[:id]
    render :show
  end


end
