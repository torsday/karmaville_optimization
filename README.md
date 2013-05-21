# KarmaVille


## Times

- Initial
    - 26,948 ms
- With user_id index
    - 4,866 ms
- 


## Steps

### make user_id an index in the karma table

#### Command line
```
$ rails generate migration add_user_index_in_karma
```

#### Migration
```ruby
class AddUserIndexInKarma < ActiveRecord::Migration
  def change
    add_index :karma_points, :user_id
  end
end
```













command line
```
$ rails generate migration add_total_karma_to_users total_karma:integer
```

alter: ```app/models/user.rb```
```ruby
attr_accessible :first_name, :last_name, :email, :username, :total_karma

def calc_total_karma
  self.karma_points.sum(:value)
end
```

migration
```ruby
class AddTotalKarmaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :total_karma, :integer
    User.reset_column_information
    User.all.each do |user|
      user.update_attribute :total_karma, user.calc_total_karma
    end
  end
end
```




in ```app/models/user.rb``` change

```ruby
def self.by_karma
  joins(:karma_points).group('users.id').order('SUM(karma_points.value) DESC')
end
```

to

```ruby
def self.by_karma
  order('total_karma DESC')
end
```

