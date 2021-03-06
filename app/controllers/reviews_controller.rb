class ReviewsController < ApplicationController
    before_action :has_moviegoer_and_movie, :except => [:index]
    protected
    
    
    def has_moviegoer_and_movie
      unless @current_user
        flash[:warning] = 'You must be logged in to create a review.'
        redirect_to movies_path
      end

      unless (@movie = Movie.find(params[:movie_id]))
        flash[:warning] = 'Review must be for an existing movie.'
        redirect_to movies_path
      end
    end
    
    public
    
    def index
      @movie = Movie.find params[:movie_id]
      @movie_reviews = @movie.reviews
    end

    def new
        @review = @movie.reviews.build # initial of review data
    end
    
    def create
        permitted = params[:reviews].permit(:potatoes, :comments, :moviegoer_id, :movie_id) # pack parameter to build
        @review = @movie.reviews.build(permitted)
        @current_user.reviews << @review #push into users review
        if @review.save
			    flash[:notice] = 'Review successfully create.'
			    redirect_to movie_path(@movie)
		    else
			    render :action => 'new'
		    end
    end
     

     def edit
		    @movie = Movie.find params[:movie_id]
		    
		    @all_reviews_moive = Review.where(movie_id: params[:movie_id])
		    @reviews = @all_reviews_moive.find_by_moviegoer_id(@current_user[:id]) # for REAL edit eiei
     end

     def update
		    @movie = Movie.find(params[:movie_id])
		    
		    permitted = params[:reviews].permit(:potatoes, :comments, :moviegoer_id, :movie_id)
		    @review = @current_user.reviews.update(permitted)
		    #@current_user.reviews << @review #push into users review
        if @review
			    flash[:notice] = 'Review successfully update.'
			    redirect_to movie_review_path(@movie)
		    else
			    render  'edit'
		    end
    end
     
    def show
        id = params[:movie_id]
        begin
            @movie = Movie.find(id)
        rescue 
            flash[:notice] = "No movie with the given ID could be found."
            redirect_to movie_path
        end
    end
end
