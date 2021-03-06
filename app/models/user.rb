require 'digest/sha1'

class User < ActiveRecord::Base
  validates_presence_of :name, :email, :uid
  validates_uniqueness_of :name, :email
  validates_uniqueness_of :uid, :message => "has already been taken."
  validate :valid_email?
  validate :valid_uid?

  attr_accessor :password
  attr_accessor :password_confirmation
  validates_confirmation_of :password

  validate :password_not_blank

  has_many :buddies
  has_many :word_wars
  has_many :oh_snaps
  has_many :participations, :class_name => "Participant", :primary_key => :uid, :foreign_key => :uid

  def self.authenticate(name, password)
    user = self.find_by_name(name)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end

  def after_destroy
    if User.count.zero?
      raise "Can't delete last user"
    end
  end

  def password_not_blank
    errors.add_to_base("Missing password") if hashed_password.blank?
  end

  def self.encrypted_password(password, salt)
    string_to_hash = password + "ziltoid" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def valid_email?
    TMail::Address.parse(email)
  rescue
    errors.add(:email, "Must be a valid email")
  end

  def valid_uid?
    return unless uid
    nano_data = Nanowrimo::User.new(uid)
    nano_data.load
    errors.add(:uid, "Unable to find Nanowrimo ID") if nano_data.has_error?
  end
end
