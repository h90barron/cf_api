FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password "12345678"
    password_confirmation "12345678"
    radius 25
    latitude {Faker::Address.latitude}
    longitude {Faker::Address.longitude}
    #latitude { rand(0.0..180.00) }
    #longitude { rand(0.0..90.0) }
    location_time Time.now
  end
end
