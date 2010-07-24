module Redistat
  class Summary
    include Database
    extend Database
    
    DEPTHS = [:year, :month, :day, :hour, :min, :sec, :usec]
    
    def self.update_all(key, stats = {}, depth_limit = nil)
      stats ||= {}
      depth_limit ||= key.depth
      return nil if stats.size == 0
      DEPTHS.each do |depth|
        update(key, stats, depth)
        break if depth == depth_limit
      end
    end
    
    private
    
    def self.update(key, stats, depth)
      stats.each do |field, value|
        db.hincrby key.to_s(depth), field, value
      end
    end
    
  end
end