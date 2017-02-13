require 'spec_helper'

describe "StaticPages" do
  subject {page}
	let (:titule) { "Страница" }
  shared_examples_for "проверяем все страницы" do
    it {should have_selector('h1',  text: heading)}
    it {click_link(link)}
    it {should have_title(full_title(page_title))}
  end

  describe "Home page" do
    before {visit root_path}
    let(:heading) {'Sample App'}
    let(:link) {"Домашняя"}
    let(:page_title) {'Домашняя'}

    it_should_behave_like "проверяем все страницы"
  end

  describe "Help page" do
    before {visit help_path}
  	let(:heading) {'Помощь'}
    let(:link) {"Домашняя"}
    let(:page_title) {'Помощь'}

    it_should_behave_like "проверяем все страницы"
  end

  describe "Страница 'О нас'" do
    before {visit about_path}
  	let(:heading) {'О нас'}
    let(:link) {"Домашняя"}
    let(:page_title) {'О нас'}

    it_should_behave_like "проверяем все страницы"
  end
  describe "Страница 'Контакты'" do
    before {visit contact_path}
  	let(:heading) {'Контакты'}
    let(:link) {"Домашняя"}
    let(:page_title) {'Контакты'}

    it_should_behave_like "проверяем все страницы"
  end

end
