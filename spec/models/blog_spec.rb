require 'rails_helper'

describe Blog do
  it 'titleがあれば有効な状態であること' do
    blog = Blog.new(title: 'タイトル')
    expect(blog).to be_valid
  end

  it 'titleがなければ無効な状態であること' do
    blog = Blog.new(title: nil)
    blog.valid?
    expect(blog.errors[:title]).to include("can't be blank")
  end
end
