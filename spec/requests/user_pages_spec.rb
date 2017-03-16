require 'spec_helper'

describe "UserPages" do
	subject {page}
	shared_examples_for "Все страницы" do
		it {should have_content(:content)}
		it {should have_title(full_title(title))}
	end

  	describe "Signup page" do
  		before {visit signup_path}
    	let(:content) {'Регистрация'}
    	let(:title) {'Регистрация'}

    	it_should_behave_like "Все страницы"
  	end
end
