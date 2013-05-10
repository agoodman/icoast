task :update_positions => :environment do
  require 'time_index_strategy'
  Image.update_positions(TimeIndexStrategy)
end
