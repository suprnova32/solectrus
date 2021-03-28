describe 'Pages' do
  describe 'GET /about' do
    it 'is successful' do
      get '/about'
      expect(response).to be_successful
    end
  end

  describe 'GET /unknown-page' do
    it 'raises error' do
      expect do
        get '/unknown-page'
      end.to raise_error(ActionController::RoutingError)
    end
  end
end
