FactoryBot.define do
  factory :user do
    email {"sample@sample.com"}
    password {"password"}
    password_confirmation {"password"}
  end
end
