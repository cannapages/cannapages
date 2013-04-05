class CadetsController < ApplicationController
  def home
		@pipe_graves = PipeGrave.all.to_a
  end
end
