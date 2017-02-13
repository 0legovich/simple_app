require 'spec_helper'

describe "StaticPages" do
	let (:titule) { "Страница" }
  describe "Home page" do
    it "should have the content 'Simple App'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end
    it "Проверяем динамический заголовок Домашняя" do
  		visit '/static_pages/home'
  		expect(page).to have_title("#{titule}")
  	end 
  end

  describe "Help page" do
  	it "должно быть слово 'Помощь'" do
  		visit '/static_pages/help'
  		expect(page).to have_content('Помощь')
  	end
  	it "Проверяем динамический заголовок Помощь" do
  		visit '/static_pages/help'
  		expect(page).to have_title("#{titule} Помощь")
  	end 
  end

  describe "Страница 'О нас'" do
  	it "Проверяем страницу на слово 'О нас'" do
  	visit '/static_pages/about'
  	expect(page).to have_content('О нас')
  	end
  	it "Проверяем динамический заголовок О нас" do
  		visit '/static_pages/about'
  		expect(page).to have_title("#{titule} О нас")
  	end 
  end
  describe "Страница 'Контакты'" do
  	it "Есть ли страница 'Контакты'" do
  		visit '/static_pages/contact'
  		expect(page).to have_content ('Контакты')
  	end
  	it "Проверяем динамический заголовок 'Контакты'" do
  		visit '/static_pages/contact'
  		expect(page).to have_title("#{titule} Контакты")
  	end
  end
end
