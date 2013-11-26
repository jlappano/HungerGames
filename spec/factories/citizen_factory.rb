FactoryGirl.define do
  factory :citizen do
    age         17
    gender      {["f", "m"].sample}
    name         "PJ Hughes"
    district_id  {(1..12).to_a.sample}
  end
end