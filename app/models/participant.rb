class Participant < ActiveRecord::Base
  belongs_to :word_war

  validates_presence_of :uid, :word_war_id
  validates_uniqueness_of :uid, :scope => :word_war_id, :message => "That Nanowrimo ID is already part of this Word War."
  validate :valid_uid?

  attr_accessor :nano_data

  def nano_data
    nd = Nanowrimo::User.new(uid)
    nd.load
    {:uid => nd.uid.to_i, :uname => nd.uname, :user_wordcount => nd.user_wordcount.to_i}
  end

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