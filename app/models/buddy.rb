class Buddy < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id, :uid
  validates_uniqueness_of :uid, :scope => :user_id
  validate :valid_uid?

  private

  def valid_uid?
    return unless uid
    unless User.find_by_uid(uid)
      nano_data = Nanowrimo::User.new uid
      nano_data.load
      errors.add(:uid, "Unable to find Nanowrimo ID") if nano_data.has_error?
    end
  end
end
