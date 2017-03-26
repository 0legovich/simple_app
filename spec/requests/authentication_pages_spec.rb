require 'spec_helper'

describe "AuthenticationPages" do

	subject {page}

	describe "страница входа" do
		before { visit signin_path }

		describe "with invalid information" do
			before { click_button "Войти"}

			it {should have_title('Вход')}
			it { should have_selector('div.alert.alert-error')}

			describe "aster visiting another page" do
				before { click_link "Домашняя"}
				it {should_not have_selector('div.alert.alert-error')}
			end
		end

		describe "with valid information" do
			let(:user) {FactoryGirl.create(:user)}
			before do
				fill_in "Email", with: user.email.upcase
				fill_in "Password", with: user.password
				click_button "Войти"
			end

			it {should have_title(user.name)}
			it {should have_link('Профиль', href: user_path(user))}
			it {should have_link('Выход', href: signout_path)}
			it {should_not have_link('Вход', href: signin_path)}

			describe "followed by signout" do
				before { click_link "Выход" }
				it { should have_link('Войти')}
			end
		end
	end
end
