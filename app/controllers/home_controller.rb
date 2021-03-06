class HomeController < ApplicationController
  respond_to :js, :html

  def index
    @paginated_issues = Issue.where('status != 5 and status != 3').order('created_at DESC').paginate(:page => params[:page], per_page: 4)
  end
end
