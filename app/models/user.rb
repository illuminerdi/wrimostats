class User < ActiveRecord::Base
  include EmailColumn
  validates_presence_of :name, :email, :uid
  validates_uniqueness_of :name, :email
  email_column :email
end
