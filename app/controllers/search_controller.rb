class SearchController < ApplicationController

  def show
    @stores = Store.find_by_zip(params[:zip], 25)
    byebug
    @stores
  end

end
