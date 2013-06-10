require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  context "when not signed in" do
    setup do
      @user = FactoryGirl.create(:user)
      sign_out
    end
    
    context "on post create" do
      setup { post :create, comment: FactoryGirl.attributes_for(:comment) }
      
      should respond_with :unauthorized
    end

    context "on put update" do
      setup do
        @image = Image.create
        @comment = @image.comments.create(user_id: @user.id, body: 'body')
        put :update, id: @comment.id, comment: FactoryGirl.attributes_for(:comment)
      end
      
      should respond_with :unauthorized
    end
  end

  context "when signed in" do
    setup do
      @user = FactoryGirl.create(:user)
      sign_in_as @user
    end
    
    context "on post create" do
      setup { post :create, comment: FactoryGirl.attributes_for(:comment) }
      
      should respond_with :created
    end

    context "on put update" do
      setup do
        @image = Image.create
        @comment = @image.comments.create(user_id: @user.id, body: 'body')
        put :update, id: @comment.id, comment: FactoryGirl.attributes_for(:comment)
      end
      
      should respond_with :success
    end
  end

end
