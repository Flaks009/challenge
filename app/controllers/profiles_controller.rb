class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  def scrapping
      @name = params[:name]
      if @name
          require 'open-uri'
          require 'shorturl'
          @doc = Nokogiri::HTML(open('https://twitter.com/' + @name))
          @name = @doc.css('.ProfileHeaderCard-nameLink').text
          @bio = @doc.css('.ProfileHeaderCard-bio').text
          @link = 'https://twitter.com/' + @name
          @link = ShortURL.shorten(@link)
          render template: 'profiles/scrapping'
      else
          render template: 'profiles/scrapping'
      end
  end

  def new
      @profile = Profile.new
  end

  def create
      @profile = Profile.new(profile_params)
      if @profile.save
          render template: 'profiles/scrapping'
      end
  end

  def index
      @profiles = Profile.all
  end


  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def show
  end


  private
    def set_profile
        @profile = Profile.find(params[:id])
    end


    def profile_params
        params.require(:profile).permit(:name, :link, :bio)
    end
end