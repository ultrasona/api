class ProsController < ApplicationController
  def search
    @pros        = Pro.new
    @prestations = Prestation.all

    render :search
  end

  def find
    @pros   = ::FindAvailablePros.new(params['references'], params['address'], params['date'], params['time']).call
    @result = []

    @pros.each do |pro|
      @result.push(pro.name)
    end

    @result
  end
end
