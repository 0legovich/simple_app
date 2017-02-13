require 'spec_helper'

describe "StaticPages" do
  subject {page}
	let (:titule) { "Страница" }

  describe "Home page" do
    before {visit root_path}
    it {should have_content('Sample App')}
    it {should have_title("#{titule}")}
  end

  describe "Help page" do
    before {visit help_path}
  	it {should have_content('Помощь')}
  	it {have_title("#{titule} Помощь")}
  end

  describe "Страница 'О нас'" do
    before {visit about_path}
  	it {have_content('О нас')}
  	it {have_title("#{titule} О нас")}
  end
  describe "Страница 'Контакты'" do
    before {visit contact_path}
  	it {have_content ('Контакты')}
  	it {have_title("#{titule} Контакты")}
  end
end
