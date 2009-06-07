class AddDefaultUser < ActiveRecord::Migration
  def self.up
    default_user = User.new({
      :name => 'jclingenpeel',
      :email => 'control@hollowedout.com',
      :password => 'fubar',
      :password_confirmation => 'fubar',
      :uid => 240659,
      :is_admin => true
    })
    default_user.save
  end

  def self.down
  end
end
