require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create name: 'KFC'}

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    click_link 'KFC'

    expect(page).to have_content('so so')
  end

context 'Users can only edit/delete their own reviews' do
  before do
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'Mamas'
    click_button 'Create Restaurant'
  end

  scenario 'user can only edit their own review' do


    click_link('Sign out')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
    click_link('Mamas')
    click_link('Edit Mamas')
    expect(page).to_not have_content("error")
  end

  scenario 'user can only delete their own review' do
    click_link('Sign out')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
    click_link('Delete Mamas')
    expect(page).to_not have_content("error")
  end

end
end
