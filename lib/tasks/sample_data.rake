namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.new(name: "Example User", email: "example@railstutorial.org")
    admin.password = "foobar"
    admin.password_confirmation = "foobar"
    admin.admin = true
    admin.save!
#    User.create!(name: "Example User",
#                 email: "example@railstutorial.org",
#                 password: "foobar",
#                 password_confirmation: "foobar")
#    @user = User.new(name: "Example User", email: "example@railstutorial.org")
#    @user.password = "foobar"
#    @user.password_confirmation = "foobar"
#    @user.save!
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
#      User.create!(name: name,
#                   email: email,
#                   password: password,
#                   password_confirmation: password)
      @user = User.new(name: name, email: email)
      @user.password = password
      @user.password_confirmation = password
      @user.save!
    end
  end
end