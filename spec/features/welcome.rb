require 'spec_helper'

describe 'welcome page', js: true do 
  it 'welcomes the user' do 
    visit '/'
    expect(page).to have_content 'Welcome to the Hunger Games'
  end

  it 'has a reaping button' do
    visit '/'
    expect(page).to have_button 'reap'
  end

end