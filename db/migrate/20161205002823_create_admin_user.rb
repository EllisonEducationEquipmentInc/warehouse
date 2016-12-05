class CreateAdminUser < ActiveRecord::Migration
  def change
    @user = User.create! password: 'ellison123', name: 'Admin', email: 'admin@ellison.com'
    @user.role = 'admin'
    @user.confirmed_at = Time.zone.now
    @user.save!
  end
end
