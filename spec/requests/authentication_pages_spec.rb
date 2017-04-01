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
				fill_in "Пароль", with: user.password
				click_button "Войти"
			end

			it {should have_title(user.name)}
			it {should have_link('Профиль', href: user_path(user))}
			it {should have_link('Настройки', href: edit_user_path(user))}
			it {should have_link('Выход', href: signout_path)}
			it {should_not have_link('Вход', href: signin_path)}

			describe "followed by signout" do
				before { click_link "Выход" }
				it { should have_link('Войти')}
			end
		end

	describe "Авторизация" do

		describe "для не зарегистрироанных пользователей" do
			let(:user) {FactoryGirl.create(:user)}

			describe "когда попытка посетить защищенную страницу" do
				before do
					visit edit_user_path(user)
					fill_in "Email", with: user.email
					fill_in "Password", with: user.password
					click_button "Войти"
				end
			end

			describe "после входа" do
				it "дожна отрендериться защищенная страница" do
					expect(page).to have_title('Редактирование пользователя')
				end
			end

			describe "в контроллере User" do

				describe "посещение редактируемой страницы" do
					before {visit edit_user_path(user)}
					it {should have_title('Вход')}
				end

				describe "сабмит обновления информации" do
					before {patch user_path(user)}
					specify {expect(response).to redirect_to(signin_path)}
				end
			end				
		end

		describe "не правильный пользователь" do
			let(:user) {FactoryGirl.create(:user)}
			let(:wrong_user) {FactoryGirl.create(:user, email: "wrong@example.com")}
			before {sign_in user, no_capybara: true}

			describe "сабмит GET запроса для User#edit действия" do
				before {get edit_user_path(wrong_user)}
				specify {expect(response.body).not_to match(full_title('Редактирование пользователя'))}
				specify {expect(response).to redirect_to(root_url)}
			end

			describe "сабмит PATH зпроса для User#update действия" do
				before {path user_path(wrong_user)}
				specify {expect(response).to redirect_to(root_url)}
			end
		end
	end
end
