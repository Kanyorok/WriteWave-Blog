require 'rails_helper'

RSpec.describe Post, type: :model do
  subject(:author) { User.new(name: 'Essie', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Software Developer from Ethi.') }
  subject(:post) { Post.new(Title: 'hello world', text: 'Hello world paragraph', author_id: author.id) }
  before { author.save }
  before { post.save }
  it 'should be valid post' do
    expect(post).to be_valid
  end
  it 'should be invalid post' do
    post.Title = nil
    expect(post).to_not be_valid
  end
  it 'should be invalid post [maximum length for title is 250]' do
    post.Title = '
    Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of
    Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics,
    very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..",
    comes from a line in section 1.10.32.'
    expect(post).to_not be_valid
  end
  it 'should have post counter to 1' do
    expect(post.author.posts_count).to be(1)
  end
end
