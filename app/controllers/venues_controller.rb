class VenuesController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, except: [:new, :create, :index]
  
  def  new
    @venue = Venue.new
    @venuecategories = Venuecategory.all
  end

  def create
    @venue = current_user.venues.build(params[:venue])
    if @venue.save
      flash[:success] = "Your new venue has been added!"
      redirect_to venues_path
    else
      @venuecategories = Venuecategory.all
      render 'new'
    end
  end

  def update
    @venue = current_user.venues.find_by_munged_name(params[:id]) 
    @venue.assign_attributes(params[:venue])
    if @venue.valid?
      @venue.save
      flash[:success] = "The venue has been updated!"
      redirect_to venue_path(@venue)
    else
      @venuecategories = Venuecategory.all
      render 'show'
    end
  end

  def show
    @venue = current_user.venues.find_by_munged_name(params[:id])
    @venuecategories = Venuecategory.all
  end

  def index
    @venue = Venue.new
    @venues = current_user.venues.all
    @venuecategories = Venuecategory.all
  end

  def destroy
    @id = params[:id]
    if @id == 1
      flash[:error] = "You cannot delete this venue! This is the default venue. Feel free to change its name and venue category."
    else
      @venue = current_user.venues.find_by_munged_name(params[:id])
      @activities = @venue.activities.all
      if @activities.any?
        @activities.each do |activity|
          activity.update_attributes(:venue_id => current_user.venues.all.collect(&:id).min())
        end
      end
      @venue.destroy
      redirect_to venues_path
    end
  end

  private

    def correct_user
      munged_name = params[:id]
      @venue = current_user.venues.find_by_munged_name(params[:id])
      if @venue.nil?
        flash[:error] = "Sorry that venue does not belong to you!"
        redirect_to venues_path
      end
    end

end
