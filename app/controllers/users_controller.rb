class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :only_allow_admin, :only => [ :index, :update, :destroy ]  # uses Rolify gem


  def index
   @users = User.all
   @chart = create_chart
   @chart2 = create_chart2
   end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

private

  def only_allow_admin  # could move this to ApplicationController so it's available in multiple controllers
    redirect_to root_path, :alert => 'Not authorized as an administrator.' unless current_user.has_role? :admin
  end

  def create_chart
    users_by_day = User.group("DATE(created_at)").count
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string')
    data_table.new_column('number')
    total_users = 0
    users_by_day.each do |day|
      data_table.add_row([ day[0].to_s, day[1] ])
    end
    opts = { :title=> 'New Users by Day', :hAxis => { :title => 'Date'}, :vAxis => { :minValue => 0 }, :legend => {:position=>'none'} } 
    @chart = GoogleVisualr::Interactive::ColumnChart.new(data_table,opts)
  end

  def create_chart2
    users_by_day = User.group("DATE(created_at)").count
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('date')
    data_table.new_column('number')
    total_users = 0
    users_by_day.each do |day|
      total_users += day[1]
      data_table.add_row([ Date.parse(day[0].to_s),total_users ])
    end
    @chart2 = GoogleVisualr::Interactive::AnnotatedTimeLine.new(data_table)
  end


end
