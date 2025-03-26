class ProsController < ApplicationController
  def search
    @pros = Pro.new
    @prestations = Prestation.all
    render :search
  end
end
