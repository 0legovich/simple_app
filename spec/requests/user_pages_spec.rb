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
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end
