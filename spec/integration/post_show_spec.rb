require 'rails_helper'
RSpec.describe 'Allpostpage#show ', type: :feature do
  before :each do
    @user = User.create(name: 'John Doe', photo: 'https://example.com/john-doe.jpg', bio: 'Web Developer',
                        posts_count: 0)
    @post1 = Post.create(author_id: @user.id, Title: 'Rails Journey', text: 'Exploring the world of Rails development.',
                         likes_count: 0, comments_count: 0)
    @post2 = Post.create(author_id: @user.id, Title: 'Hello World', text: 'Another day, another hello.',
                         likes_count: 0, comments_count: 0)
    @post3 = Post.create(author_id: @user.id, Title: 'Ruby Adventures', text: 'Discovering the beauty.',
                         likes_count: 0, comments_count: 0)
    @comment1 = Comment.create(user_id: @user.id, post_id: @post1.id, text: 'Great post!')
    @comment2 = Comment.create(user_id: @user.id, post_id: @post1.id, text: 'I learned a lot.')
    @like = Like.create(user_id: @user.id, post_id: @post1.id)

    visit user_post_path(@user.id, @post1.id)
  end

  it 'I can see the post\'s title' do
    expect(page).to have_content('Rails Journey')
  end

  it 'I can see who wrote the post' do
    expect(page).to have_content('John Doe')
  end

  it 'I can see how many comments it has' do
    expect(page).to have_content('Comments: 2')
  end

  it 'I can see how many likes it has' do
    expect(page).to have_content('Likes: 1')
  end

  it 'I can see the post body' do
    expect(page).to have_content('Exploring the world of Rails development.')
  end

  it 'I can see the username of each commentor' do
    expect(page).to have_content(@comment1.author.name)
    expect(page).to have_content(@comment2.author.name)
  end

  it 'I can see the comment each commentor left' do
    expect(page).to have_content('Great post!')
    expect(page).to have_content('I learned a lot.')
  end
end
