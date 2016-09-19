class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    sort = params[:sort_by]
    ratings = params["ratings"]
    
    if(!sort)
      @movies = Movie.all
    elsif sort == "title"
      @movies = Movie.order(:title)
    elsif sort == "release_date"
      @movies = Movie.order(:release_date)
    end
    
    if(!ratings)
      filter = @all_ratings
    else
      filter = params["ratings"].keys
    end
    
    @checked_boxes = Movie.checked_box filter
    @movies = Movie.where(:rating => filter)
    
 
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    params.permit!
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
