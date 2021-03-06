# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController
    before_action :has_moviegoer_and_movie, :except => [:index, :show]

    def has_moviegoer_and_movie
        unless @current_user
          flash[:warning] = 'You must be logged in.'
          redirect_to movies_path
        end
    end

    def index
      @movies = Movie.all.sort_by { |name| name.title}
    end

    def show
        id = params[:id] # retrieve movie ID from URI route
        begin
            @movie = Movie.find(id) # look up movie by unique ID
        rescue 
            flash[:notice] = "No movie with the given ID could be found."
            redirect_to movies_path
        end
        # @movie = Movie.find(id) # look up movie by unique ID
        # will render app/views/movies/show.html.haml by default
    end



    def new
        @movie = Movie.new
        # default: render 'new' template
    end 



    def create
        params.require(:movie)
        permitted = params[:movie].permit(:title,:rating,:release_date,:description)
        @movie = Movie.new(permitted)
        if @movie.save
            flash[:notice] = "#{@movie.title} was successfully created."
            redirect_to movies_path # redirect to the index action after a successful create
            #redirect_to action: "show", id: @movie.id # redirect to the show action after a successful create
        else
            render 'new' # note, 'new' template can access @movie's field values!
        end
    end



    def edit
        @movie = Movie.find params[:id]
    end



    def update
        @movie = Movie.find params[:id]
        permitted = params[:movie].permit(:title,:rating,:release_date,:description)
        if @movie.update(permitted)
            flash[:notice] = "#{@movie.title} was successfully updated."
            redirect_to movie_path(@movie) # redirect to the show action after a successful create
        else
            render 'edit' # note, 'edit' template can access @movie's field values!
        end
    end



    def destroy
        @movie = Movie.find(params[:id])
        @movie.destroy
        flash[:notice] = "Movie '#{@movie.title}' deleted."
        redirect_to movies_path
    end

    def movies_with_filters
        @movies = Movie.with_good_reviews(params[:threshold])
        @movies = @movies.for_kids          if params[:for_kids]
        @movies = @movies.with_many_fans    if params[:with_many_fans]
        @movies = @movies.recently_reviewed if params[:recently_reviewed]
    end

    # or even DRYer:
    # def movies_with_filters
    #     @movies = Movie.with_good_reviews(params[:threshold])
    #     %w(for_kids with_many_fans recently_reviewed).each do |filter|
    #       @movies = @movies.send(filter) if params[filter]
    #     end
    #   end
    # end

    def search_tmdb
        # hardwire to simulate failure
        @movies = Movie.find_in_tmdb(params[:search_terms])
        @search = Tmdb::Search.new
        @search.query(params[:search_terms]) # the query to search against
        @search = @search.fetch # makes request
        @movie = Movie.new
    end

    def create_from_tmdb
        flash[:notice] = params
        movie_id = params[:tmdb_id]
		m = Movie.get_from_tmdb(movie_id)
		l = Movie.releases_from_tmdb(movie_id)
		@movie = Movie.new({
            :title => m["title"], 
            :rating => l['countries'][0]['certification'],   
            :release_date => m["release_date"], 
            :description => m["overview"]
		})
        # @movie.save
		if @movie.save
			flash[:notice] = "'#{@movie.title}' was successfully created."
			redirect_to new_movie_review_path(@movie)
        
		end
	end
    
end
