class VolumesController < ApplicationController
	before_filter :require_admin, except: [:index, :show]

	def admin_index
		@volumes = Volume.all.to_a
		render layout: "admin_backend"
	end
end
