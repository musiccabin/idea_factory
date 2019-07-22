require 'rails_helper'

RSpec.describe IdeasController, type: :controller do

  describe "GET #new" do
    context 'no user signed in' do
      it 'redirects to sign in page' do
        get :new
        expect(response).to redirect_to new_session_path
      end

      it 'has a flash alert' do
        get :new
        expect(flash[:alert]).to be
      end
    end

    context 'user signed in' do
      def sign_user_in
        @user = FactoryBot.create(:user)
        session[:user_id] = @user.id
      end

      it "creates a new instance of Idea" do
        sign_user_in
        get :new
        expect(assigns(:idea)).to be_a_new Idea
      end

      it 'renders new view' do
        sign_user_in
        session[:user_id] = User.first.id
        get :new
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #create" do
    context 'user signed in' do
      context 'validation succeeds' do
        def valid_request
          @user = FactoryBot.create(:user)
          session[:user_id] = @user.id
          post(:create, params: {idea: {title:'title',description:'description',user:@user}})
        end

        it 'saves the created Idea to db' do
          count_before = Idea.count
          valid_request
          count_after = Idea.count
          expect(count_before).to eq(count_after - 1)
        end
  
        it 'redirects to idea show page' do
          valid_request
          expect(response).to redirect_to idea_path(Idea.last)
        end
      end

      context 'validation fails' do
        def invalid_request
          @user = FactoryBot.create(:user)
          session[:user_id] = @user.id
          post(:create, params: {idea: {description:'description'}})
        end
        it 'renders new view' do
          invalid_request
          expect(response).to render_template :new
        end

        it 'did not save anything to db' do
          count_before = Idea.count
          invalid_request
          count_after = Idea.count
          expect(count_before).to eq(count_after)
        end
      end
    end

    context 'no user signed in' do
      it 'redirects to sign in page' do
        post(:create, params: {idea: {description:'description'}})
        expect(response).to redirect_to new_session_path
      end

      it 'has a flash alert' do
        post(:create, params: {idea: {description:'description'}})
        expect(flash[:alert]).to be
      end
    end
  end
end
