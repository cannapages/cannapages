class ActivityFeed
  include Mongoid::Document
  include Mongoid::Timestamps
  field :img_url, type: String
  field :content, type: String
  
  before_save :trim_excess
  
  def trim_excess
    num = ActivityFeed.count
    
    if num > 100
      ActivityFeed.last.delete
    end
  end
end
