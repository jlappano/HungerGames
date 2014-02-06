require 'spec_helper'

describe "the reaping", :type => :feature do

  it 'lists the reaped children' do
    visit '/'
    click_link 'reap'
    expect(page).to have_content 'This years tributes are'
  end
end
