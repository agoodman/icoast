module TimeIndexStrategy

  def self.pre
    Image.pre.order("taken_at desc")
  end
  
  def self.post
    Image.post.enabled.order("taken_at asc")
  end
  
end
