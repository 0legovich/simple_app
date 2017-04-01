FactoryGirl.define do
	factory :user do
		secuence(:name) {|n| "Person #{n}"}
		sequence(:email) {|n| "person_#{n}@example.ru"}
		password "lol123"
		password_confirmation "lol123"
	end
end