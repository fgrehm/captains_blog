class Comment

  include DataMapper::Resource
  include DataMapper::Timestamp

  property :id, Serial
  property :commenter_name, String, :size => 200
  property :commenter_email, String , :size => 200
  property :commenter_website, String, :size => 200
  property :text, Text
  property :created_at, DateTime

  def self.require_approvals!
    property :approved, Boolean, :default => false
  end

  belongs_to :user
  belongs_to :post

  validates_present :commenter_name, :unless => :user
  validates_present :commenter_email, :unless => :user
  
  def self.require_approvals?
    self.properties.map { |property| property.name }.include?(:approved)
  end

  def commenter_display_name
    if self.user
      self.user.first_name + " " + self.user.last_name
    else
      self.commenter_name
    end
  end
end
