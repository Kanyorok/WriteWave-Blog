require 'rails_helper'
RSpec.describe 'userpage#index', type: :feature do
  before do
    @users = [
      User.create(name: 'Devendra', photo: 'dev.jpg', bio: 'Fullstack Engineer', posts_count: 0),
      User.create(name: 'John', photo: 'John.png', bio: 'Web Developer', posts_count: 0),
      User.create(name: 'James K.', photo: 'James.gif', bio: 'Kindergaten Teacher', posts_count: 0)
    ]

    @posts = [
      @post1 = Post.create(author_id: @user, Title: 'Developer Post One', text: 'This is Post One'),
      @post2 = Post.create(author_id: @user, Title: 'Teacher Post Two', text: 'This is User Post Two'),
      @post3 = Post.create(author_id: @user, Title: 'Admin Post Three', text: 'This is User Post Three')

    ]
    visit users_path
  end
  describe '#index page' do
    it 'can view the usernames of all other users.' do
      expect(page).to have_content(@users[0].name)
    end
    it 'can view a profile picture for a given user.' do
      @users.each do |user|
        expect(page).to have_css("img[src='#{user.photo}']")
      end
    end
    it 'can check the amount of posts a user has written.' do
      @users.each do |user|
        expect(page).to have_content(user.posts_count.to_s)
      end
    end
    it 'redirects me to that posts show page when I click on a post' do
      page.all('div.col-lg-12.border.border-dark').each_with_index do |el, _i|
        within(el) { expect(page).to have_current_path(user_post_path(post.author, post)) }
      end
    end
  end
end
