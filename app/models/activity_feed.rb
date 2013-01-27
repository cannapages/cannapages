class ActivityFeed
  include Mongoid::Document
  include Mongoid::Timestamps
  field :img_url, type: String
  field :content, type: String
  
  before_save :trim_excess
  
  def trim_excess
    number_of_activities  = ActivityFeed.count
    
    if number_of_activities > 100
      ActivityFeed.all.to_a[100..(number_of_activities-1)].each do |activity|
				activity.destroy
			end
    end
  end
end
