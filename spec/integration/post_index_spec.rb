require 'rails_helper'
RSpec.describe 'posts#index', type: :feature do
  before :each do
    @user = User.create(name: 'John Doe', photo: 'https://example.com/john-doe.jpg', bio: 'Web Developer',
                        posts_count: 0)
    @post1 = Post.create(author_id: @user.id, Title: 'Ruby on Rails', text: 'Learn Engage and explore.',
                         likes_count: 2, comments_count: 1)
    @post2 = Post.create(author_id: @user.id, Title: 'Linters Management', text: 'Many ways to solve a problem',
                         likes_count: 0, comments_count: 0)
    @post3 = Post.create(author_id: @user.id, Title: 'Ruby Adventures', text: 'Discovering the beauty.',
                         likes_count: 1, comments_count: 2)
    @comment = Comment.create(user_id: @user.id, post_id: @post1.id, text: 'Great post!')
    visit user_posts_path(@user.id)
  end

  it 'I can see the user\'s profile picture' do
    expect(page).to have_css("img[src*='https://example.com/john-doe.jpg']")
  end

  it 'I can see the user\'s username' do
    expect(page).to have_content('John Doe')
  end

  it 'I can see the number of posts the user has written' do
    expect(page).to have_content('Number of Posts: 3')
  end

  it 'I can see a post\'s title' do
    expect(page).to have_content('Ruby on Rails')
  end

  it 'I can see some of the post\'s body' do
    expect(page).to have_content('Many ways to solve a problem')
  end

  it 'I can see the first comments on a post' do
    expect(page).to have_content('Great post!')
  end

  it 'I can see how many comments a post has' do
    expect(page).to have_content('Comments: 2')
  end

  it 'I can see how many likes a post has' do
    expect(page).to have_content('Likes: 2')
  end

  it 'I can see a section for pagination if there are more posts than fit on the view.' do
    expect(page).to have_content('Pagination')
  end

  it "When I click on a post, it redirects me to that post's show page." do
    click_on 'Ruby on Rails'
    expect(page).to have_content('Ruby on Rails')
  end
end
