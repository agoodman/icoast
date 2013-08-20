module PositionNormalStrategy

  # calculates normal vector based on previous and next positions
  # assumes post and enabled
  # returns a two-element array: [x,y]
  # returns nil if unable to determine normal
  def self.normal_for(image)
    count = Image.post.enabled.count
    prev_image = Image.post.enabled.where(position: (image.position-1) % count).first rescue nil
    next_image = Image.post.enabled.where(position: (image.position+1) % count).first rescue nil
    if prev_image && next_image
      dlat = next_image.latitude - prev_image.latitude
      dlng = next_image.longitude - prev_image.longitude
      nx = 1
      ny = -dlat/dlng
      nmag = nx*nx+ny*ny
      nx /= nmag
      ny /= nmag
      return [ nx, ny ]
    else
      return nil
    end
  end
  
end
