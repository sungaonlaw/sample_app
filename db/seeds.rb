User.create!(name:  "Helen Eshleman",
             email: "sungaonlaw@hotmail.com",
             password:              "Test1234",
             password_confirmation: "Test1234",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end