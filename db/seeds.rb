# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.find_by_email("admin@roomorama.com")
if user
  user.destroy
else
  User.create(first_name: "Admin", email: "admin@roomorama.com", 
          password: "1234qwer", password_confirmation: "1234qwer", is_admin: true)
end
