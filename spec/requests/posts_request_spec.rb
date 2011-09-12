require 'spec_helper'

describe 'Post request' do
  it 'lists published' do
    Post.delete_all
    Factory(:post, :title => 'Blast from the Past', :published_at => 2.days.ago)
    Factory(:post, :title => 'Back to the Future', :published_at => 2.days.from_now)
    visit blog_path
    page.should have_content('Blast from the Past')
    page.should_not have_content('Back to the Future')
  end
  
  it 'provides ATOM feed of posts' do
    Post.delete_all
    Factory(:post, :title => 'Blast from the Past', :published_at => 2.days.ago)
    visit blog_path(:format => :atom)
    page.should have_content('Blast from the Past')
  end
  
  it 'filters by tag' do
    Factory(:post, :title => 'Blast from the Past', :tags => [Factory.build(:tag, :name => 'oldtimes')])
    Factory(:post, :title => 'Back to the Future')
    visit blog_path
    click_on 'oldtimes'
    page.should have_content('Blast from the Past')
    page.should_not have_content('Back to the Future')
  end
  
  it 'redirects /posts to /blog' do
    visit '/posts'
    page.current_url.should eq(blog_url)
  end
  
  it 'is homepageable' do
    Factory(:post, :title => 'Awesome post')
    Factory(:post, :title => 'Silly post', :homepageable => false)
    visit root_path
    page.should have_content('Awesome post')
    page.should_not have_content('Silly post')
  end
end
