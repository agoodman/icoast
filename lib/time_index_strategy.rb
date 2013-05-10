module TimeIndexStrategy

  def self.pre
    Image.pre.order("taken_at desc")
  end
  
  def self.post
    Image.post.order("taken_at asc")
  end
  
end
