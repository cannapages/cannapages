class CritiquesController < ApplicationController
  def index
    
  end
  
  def create
  end
  
  def update
  end

  def show
    @strain_test = StrainTest.first
    @strain = @strain_test.strain
  end

  def new
  end

  def edit
  end
  
  def destroy
  end
end
