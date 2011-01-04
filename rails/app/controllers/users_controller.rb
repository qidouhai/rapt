class UsersController < ApplicationController
  before_filter authenticate_user!
  respond_to :html, :json
  
  def show
    @user = User.find_by_username(params[:username])
    respond_with(@user, {:include => {:levels => {:methods => [:html_title], :except => [:data]}}})
  end
  
  def levels
    @levels = User.find_by_username(params[:username]).levels
    respond_with(@levels, :exclude => [:data], :methods => [:html_title] )
  end
  
  # show the editor
  def edit_level
    @level = current_user.levels.select { |l| l.html_title == params[:levelname]}.first
    respond_with(@level, :methods => [:html_title])
  end
  
  # update the level
  def upate_level
    @level = current_user.levels.select { |l| l.html_title == params[:levelname]}.first
    @level.update_attributes(params[:level])
    respond_width(@level, :methods => [:html_title])
  end
  
end
