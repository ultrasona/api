FactoryBot.define do
  factory :pro do
    sequence(:name) { |n| "Name#{n}" }
    sequence(:address) { |n| "Address#{n}" }
    lat { 48.874853 }
    lng { 48.874853 }
    max_kilometers { 5 }

    opening_hours  do
      [
        '{"day"=>"monday", "starts_at"=>"8:00", "ends_at"=>"17:00"}',
        '{"day"=>"thursday", "starts_at"=>"8:00", "ends_at"=>"12:00"}',
        '{"day"=>"friday", "starts_at"=>"8:00", "ends_at"=>"17:00"}'
      ]
    end

    appointments do
      [
        '{"starts_at"=>"2019-08-27T09:00:00+02:00", "ends_at"=>"2019-08-27T12:00:00+02:00"}',
        '{"starts_at"=>"2019-08-30T16:00:00+02:00", "ends_at"=>"2019-08-30T16:30:00+02:00"}'
      ]
    end
  end
end
