FactoryGirl.define do
  factory :user do |u|
    u.email "foo@example.com"
    u.name "George"
    u.canpost true
    u.uid "test"
    u.provider "test"
    u.admin true
  end
end