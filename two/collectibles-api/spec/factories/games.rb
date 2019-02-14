FactoryBot.define do
  factory :game do
    title { 'Legend Of Zelda: Ocarina of Time' }
    pg { 'E' }
    rating { 5 }
    user_id { nil }
  end
end