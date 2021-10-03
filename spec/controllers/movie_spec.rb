require 'rails_helper.rb'

describe Movie, :type => :request do
  fixtures :movies
  it 'includes rating and year in full name' do
    movie = movies(:milk_movie)
    expect("#{movie.title} (#{movie.rating})") == 'Milk (R)'
  end
end