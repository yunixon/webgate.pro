class HomeController < ApplicationController
  layout 'portfolio', except: :index

  def index
    @projects = Project.published.rank(:position).all
    render layout: 'main'
  end

  def portfolio
    @projects = Project.published.rank(:position).page(params[:page]).per(10)
  end

  def team
    @members = Member.rank(:position).all.page(params[:page]).per(9)
    @technology_groups = TechnologyGroup.order(:position)
  end

  def sitemap
    respond_to do |format|
      format.xml { render file: 'public/sitemaps/sitemap.xml' }
      format.html { redirect_to root_url }
    end
  end

  def robots
    #@pages = Page.where(published: false)
  end

end
