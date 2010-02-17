class Tag
  
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :size => 50

  has n, :taggings

end