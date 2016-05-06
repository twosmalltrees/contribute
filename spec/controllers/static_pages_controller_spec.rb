require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe 'GET #home'  do

    it 'responds successfully with status code 200' do
      get :home
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the home template' do
      get :home
      expect(response).to render_template(:home)
    end

  end
end
