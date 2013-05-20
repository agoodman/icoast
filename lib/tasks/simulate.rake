require 'faker'

task :simulate => :environment do

  100.times {
    # create random user
    user = User.create(email: Faker::Internet.email, password: "password")
    
    # organically discover post images
    post_count = Image.post.count
    tag_count = Tag.count
    tags = Tag.all
    (rand(100)+1).times {
      post = Image.post.where(position: rand(post_count)).first rescue nil
      if post
        # select a random number of tags
        random_tags = tags.shuffle.take(rand(4)+1)
        for tag in random_tags
          post.annotations.create(user_id: user.id, tag_id: tag.id)
        end
        
        # select the nearest pre image and assign a match
        nearest_pre = Image.pre.nearby(post.latitude, post.longitude, 0.001).first rescue nil
        if nearest_pre
          Match.create(user_id: user.id, pre_image_id: nearest_pre.id, post_image_id: post.id)
        end
      end
    }
    putc '.'
  }
  puts ''
  
end
