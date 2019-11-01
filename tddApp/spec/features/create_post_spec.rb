require 'rails_helper.rb'

feature 'Create Posts' do
    scenario 'can create job' do
        #visit root route
        visit '/'
        #create post link
        click_link 'Create Post'
        fill_in "post_title",	with: "The Post Master"
        fill_in "post_caption",	with: "The caption"
        click_button 'Create Post'
        expect(page).to have_content('The Post Master')
        expect(page).to have_content('The caption')    
    end
end