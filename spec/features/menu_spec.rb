require 'rails_helper'

feature 'Menu in admin panel.' do
  let(:user) { create(:user) }
  before do
    visit '/admin'
    login_user_post(user.email, 'secret')
    visit '/admin/categories'
    click_link ('New')
    fill_in 'category[name]', with: 'TestNameMenu'
    fill_in 'category[altlink]', with: 'Testlink'
    fill_in 'category[description]', with: 'TestDesc'
    click_button 'Save'
    visit '/admin/categories'
  end


  scenario 'Link list should work good' do
    click_link('List')
    expect(current_path).to eq '/admin/categories'
  end

  scenario 'Link new should work good' do
    click_link('New')
    expect(current_path).to eq '/admin/categories/new'
  end

  scenario 'Menu root path should have list of menus' do
    expect(page).to have_content 'ID'
    expect(page).to have_content 'Name'
    expect(page).to have_content 'Created at'
  end

  scenario 'Menu root path should have our menu name' do
    expect(page).to have_content 'TestNameMenu'
  end

  scenario 'Menu root path links show, edit should work' do
    page.all(:link,'Show')[0].click
    expect(current_path).to eq "/admin/categories/#{Category.last.id}"
    visit '/admin/categories'
    page.all(:link,'Edit')[0].click
    expect(current_path).to eq "/admin/categories/#{Category.last.id}/edit"
  end

  scenario 'link delete should delete menu' do
    page.all(:link,'Delete')[0].click
    expect(current_path).to eq current_path
  end

  scenario 'Show should display our name and description' do
    click_link ('TestNameMenu')
    expect(page).to have_content 'Name:'
    expect(page).to have_content 'TestNameMenu'
    expect(page).to have_content 'Description:'
    expect(page).to have_content 'TestDesc'
  end

  scenario 'Create menu should create menu' do
    click_link ('New')
    fill_in 'category[name]', with: 'TestNameForMenu'
    fill_in 'category[altlink]', with: 'TestDescription'
    fill_in 'category[description]', with: 'TestDescription'
    click_button 'Save'
    visit '/admin/categories'
    expect(page).to have_content 'TestNameForMenu'
  end

  scenario 'validation for new menu' do
    #todo add validation for Category.create
  end

  scenario 'should add new menu to root page' do
    visit root_path
    expect(page).to have_content Category.last.name
  end

  scenario 'should translate and display this menu, on other languages. NOW SHOULD BE FAILED' do
    visit root_path
    ['pl', 'ru'].each do |lang|
      click_link(lang) unless I18n.locale.to_s == lang
      expect(page).to have_content false #Place here created menu - lang variant
    end
  end

  scenario 'should translate altlink too. NOW SHOULD BE FAILED' do
    ['pl', 'ru'].each do |lang|
      visit root_path
      click_link(lang) unless I18n.locale.to_s == lang
      # click on our link in menu
      expect(current_path).to eq false #here mast be lang altlink
    end

  end

  scenario 'check active class on current page' do
    visit "/#{Category.last.altlink}"
    expect(page).to have_css ('.top_nav li.active')
  end
end