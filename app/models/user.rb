class User < ActiveRecord::Base
  validates_presence_of :name, :email, :uid
  validates_uniqueness_of :name, :email
  validate :valid_email?
  
  def valid_email?
    TMail::Address.parse(email)
  rescue
    errors.add_to_base("Must be a valid email")
  end
end
