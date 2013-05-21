class AddTotalKarmaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :total_karma, :integer
    User.reset_column_information
    User.all.each do |user|
      user.update_attribute :total_karma, user.calc_total_karma
    end
  end
end
