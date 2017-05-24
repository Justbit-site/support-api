require 'rails_helper'

RSpec.describe 'wants API', type: :request do
  # initialize test data 
  let!(:want) { create_list(:want, 10) }
  let(:want_id) { wants.first.id }

  # Test suite for GET /wants
  describe 'GET /wants' do
    # make HTTP get request before each example
    before { get '/wants' }

    it 'returns wants' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /wants/:id
  describe 'GET /wants/:id' do
    before { get "/wants/#{want_id}" }

    context 'when the record exists' do
      it 'returns the want' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(want_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:want_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Want/)
      end
    end
  end

  # Test suite for POST /wants
  describe 'POST /wants' do
    # valid payload
    let(:valid_attributes) { { title: 'Learn Elm', created_by: '1' } }

    context 'when the request is valid' do
      before { post '/wants', params: valid_attributes }

      it 'creates a want' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/wants', params: { title: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  # Test suite for PUT /wants/:id
  describe 'PUT /wants/:id' do
    let(:valid_attributes) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/wants/#{want_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /wants/:id
  describe 'DELETE /wants/:id' do
    before { delete "/wants/#{want_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end