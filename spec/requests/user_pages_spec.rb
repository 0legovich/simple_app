require 'spec_helper'

describe "UserPages" do
	subject {page}

  describe "Signup page" do
  	before {get "users/new"}
    it {should have_content('Регистрация')}
    it {should have_title(full_title("Регистрация"))}  
  end
end
