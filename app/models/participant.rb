class Participant < ActiveRecord::Base
  attr_accessible :campaign_id, :user_id
end
