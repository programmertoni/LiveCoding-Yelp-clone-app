require 'rails_helper'

describe StaticPagesController do

  describe 'GET #about_us' do

    it 'renders about-us page' do
      get :about_us
      expect(response).to render_template(:about_us)
    end

    it 'renders help page' do
      get :help
      expect(response).to render_template(:help)
    end

  end

  describe 'GET #help' do
  end

end
