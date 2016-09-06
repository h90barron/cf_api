FactoryGirl.define do
  factory :location do
    time "2016-09-03 02:04:29"
    longitude { rand(0.0..180.0) }
    latitude { rand(0.0..90.0) }
  end
end
