class ProsController < ApplicationController
  def search
    @pros        = Pro.new
    @prestations = Prestation.all

    render :search
  end

  def find
    @pros   = Pro.find_pros(params['references'], params['address'])
    @result = []

    @pros.each do |pro|
      @result.push(pro.name)
    end

    @result
  end
end
