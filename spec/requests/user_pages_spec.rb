require 'spec_helper'

describe "UserPages" do

	subject {page}

  describe "профиль пользователя" do
    let(:user) {FactoryGirl.create(:user)}
    before {visit user_path(user)}

    it {should have_content(user.name)}
    it {should have_title(user.name)}
  end

	shared_examples_for "Все страницы" do
		it {should have_content(:content)}
		it {should have_title(full_title(title))}
	end

  describe "Signup page" do
  	before {visit signup_path}
    let(:submit) {"Создать аккаунт"}

    describe "не валидная информация" do
      it "не должен создаться юзер" do
        expect {click_button submit}.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Имя",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Пароль",     with: "foobar"
        fill_in "Подтверждение пароля", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before {click_button submit}
        let(:user) {User.find_by(email: "romq1@mail.ru")}

        it { should have_link('Выход') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: "Добро пожаловать!")}
      end
    end
  end

  describe "Редактирование" do
    let(:user) {FactoryGirl.create(:user)}
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "страница" do
      it {should have_content("Редактирование профиля")}
      it {should have_title("Редактирование профиля")}
      it {should have_link('Изменить', href: 'http://gravatar.com/emails')}
    end

    describe "не валидная информация" do
      before { click_button "Сохранить изменения" }

      it { should have_content('error')}
    end

    describe "валидная информация" do
      let(:new_name) {"New Name"}
      let(:new_email) {"new@example.com"}
      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Пароль", with: user.password
        fill_in "Подтверждение пароля", with: user.password
        click_button "Сохранить изменения"
      end

      it {should have_title(new_name)}
      it {should have_selector('div.alert.alert-access')}
      it {should have_link('Выход', href: signout_path)}
      specify {expect(user,reload.name).to eq new_name}
      specify {expect(user.reload.email).to eq new_email}
    end
  end
end
