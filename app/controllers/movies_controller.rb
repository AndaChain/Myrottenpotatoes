# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController

########## HOMEPAGE ##########
    def index
      @movie = Movie.all
      @sort_movies = @movie.sort_by(&:title)
    end

########## SHOW ##########
    def show
        begin
            id = params[:id]
            @movie = Movie.find(id)

        rescue ActiveRecord::RecordNotFound => e
            flash[:warning] = "No movie with the given ID could be found."
            return redirect_to movies_path
        end
    end

########## CREATE NEW MOVIE ##########
    def new
		@movie = Movie.new
        # default: render 'new' template
    end

    def create
        @movie = Movie.create(params[:movie].permit(:title,:rating,:release_date,:description))
        flash[:notice] = "#{@movie.title} was successfully created."
    
		if @movie.save
		  flash[:notice] = "#{@movie.title} was successfully created."
		  #redirect_to movies_path # go to index
		  redirect_to movie_path(@movie) # go to infor
		else
		  render 'new' # note, 'new' template can access @movie's field values!
		end

	end
 
########## UPDATE MOVIE ##########
    def edit
        @movie = Movie.find params[:id]
    end

    def update
		@movie = Movie.find params[:id]
		  if @movie.update(params[:movie].permit(:title,:rating,:release_date,:description))
			flash[:notice] = "#{@movie.title} was successfully updated."
			#redirect_to movie_path(@movie)

			# อะไรสักอย่าง
			respond_to do |client_wants|
				client_wants.html {  redirect_to movie_path(@movie)  } # as before
				client_wants.xml  {  render :xml => @movie.to_xml  }
			end
			#########################
		  else
			render 'edit' # note, 'edit' template can access @movie's field values!
		  end
    end

########## DELETE MOVIE ##########
    def destroy
        @movie = Movie.find(params[:id])
        @movie.destroy
        flash[:notice] = "Movie '#{@movie.title}' deleted."
        redirect_to movies_path
    end

end
