class ApplicationController < ActionController::Base
  before_action :set_current_user
  protected # prevents method from being invoked by a route
  def set_current_user
    # we exploit the fact that the below query may return nil
    @current_user ||= Moviegoer.find_by(id: session[:user_id])
    begin
    @moviegoer_reviews = @current_user.reviews.find_by(movie_id: params[:movie_id])
    rescue
    end
    #@moviegoer_movie = Review.find_by(moviegoer_id: session[:user_id])
    #@man ||= @movie.reviews.find_by(moviegoer_id: session[:user_id])
    # redirect_to login_path and return unless @current_user
  end
  require 'themoviedb'
  def set_config
    @configuration = Tmdb::Configuration.new
  end

end
