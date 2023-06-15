FactoryBot.define do
  factory :jwt_denylist do
    jti { 'MyString' }
    exp { '2023-06-15 13:22:00' }
  end
end
