require 'spec_helper'

describe User do
  before {@user = User.new(name: "Exapmle User", email: "user@ex.com", password: "lol123", password_confirmation: "lol123")}

  subject {@user}

  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:password_digest)}
  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}
  it {should respond_to(:authenticate)}

  it {should be_valid}

  describe "when name is not present" do
  	before {@user.name = " "}
  	it {should_not be_valid}
  end

  describe "когда имя слишком длинное" do
  	before {@user.name = "a"*51}
  	it {should_not be_valid}
  end

  describe "when email is present" do
  	before {@user.email = " "}
  	it {should_not be_valid}
  end

  describe "когда формат email неверный" do
  	it "should be_valid" do
  		address = %w[user@foo.COM A_US-ER@f.b.org first.list@foo.jp a+b@baz.com]
  		address.each do |valid_adress|
  			@user.email = valid_adress
  			expect(@user).to be_valid
  		end
  	end
  end

  describe "когда email адреса уникальны" do
  	before do
  		user_with_same_email = @user.dup
  		user_with_same_email.email = @user.email.upcase
  		user_with_same_email.save
  	end

  	it {should_not be_valid}
  end

  describe "проверка что пароль не пустой" do
    before {@user.password = @user.password_confirmation = " "}
    it {should_not be_valid}
  end

  describe "совпадение паролей" do
    before {@user.password_confirmation = "mismatch"}
    it {should_not be_valid}
  end

  describe "возвращение значения метода аутентификации" do
    before {@user.save}
    let(:found_user) {User.find_by(email: @user.email)}

    describe "валидный пароль" do
      it {should eq found_user.authenticate(@user.password)}
    end

    describe "невалидный пароль" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_falsey }
    end
  end

  describe "длина пароля больше 6" do
    before{@user.password = @user.password_confirmation = "a"*5}
    it {should be_invalid}
  end

  describe "пароль из символов нижнего регистра" do
    let(:mix_email) {"Lol@r.Ru"}

    it "должен сохранить с символами нижнего регистра" do
      @user.email = mix_email
      @user.save
      expect(@user.reload.email).to eq mix_email.downcase
    end
  end
end
