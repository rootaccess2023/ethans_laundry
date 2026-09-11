class PagesController < ApplicationController
  def home
    @query = params[:name].to_s.strip
    @results = @query.present? ? Customer.where("name ILIKE ?", "%#{@query}%").order(:name).limit(20) : []
  end
end
