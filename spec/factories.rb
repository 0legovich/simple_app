FactoryGirl.define do
	factory :user do
		secuence(:name) {|n| "Person #{n}"}
		sequence(:email) {|n| "person_#{n}@example.ru"}
		password "lol123"
		password_confirmation "lol123"

		factory :admin do
			admin :true
		end
	end

	factory :micropost do
		content "Contentt"
		user
	end
end