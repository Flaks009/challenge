# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show destroy]
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
    render template: 'profiles/scrapping' if @profile.save
  end

  def index
    @profiles = if params[:term]
                  Profile.where('name ILIKE ?', "%#{params[:term]}%").or(Profile.where('bio ILIKE ?', "%#{params[:term]}%"))
                else
                  @profiles = Profile.all
    end
  end

  def destroy
    respond_to do |format|
      @profile.destroy
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:name, :link, :bio, :term)
  end
end
