class HomeController < ApplicationController

  def show
    @locations = Location.all
    @json = @locations.to_gmaps4rails
  end
end
