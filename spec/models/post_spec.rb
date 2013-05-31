require "spec_helper"

describe CommentsController do

describe Post do
  context "with 2 or more comments" do
    it "orders them in reverse chronologically" do
      post = Post.create!(:name=>"testing",:title=>"Idexcel tech")
      comment1 = post.comments.create!(:body => "first comment")
      comment2 = post.comments.create!(:body => "second comment")           
      post.comments.should eq([comment1, comment2])
    end
  end
end
  
describe "POST 'create'" do
    before(:each) do
      @user = FactoryGirl.create(:user)      
      @post = FactoryGirl.build(:post)
      @post.user_id = @user.id
      @post.save      
      @comment_attributes = FactoryGirl.attributes_for(:comment)
      @idea_attributes = FactoryGirl.attributes_for(:idea)      
    end

    it "should create a new idea" do
      @user.ideas.create!(@idea_attributes) 	
    end

    it "should create a new comment" do      
      @post.comments.create!(@comment_attributes)      
    end    

  end

end
 