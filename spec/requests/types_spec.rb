require 'rails_helper'

RSpec.describe 'Types API' do
  # Initialize the test data
  let!(:want) { create(:want) }
  let!(:types) { create_list(:type, 20, want_id: want.id) }
  let(:want_id) { want.id }
  let(:id) { types.first.id }

  # Test suite for GET /wants/:want_id/types
  describe 'GET /wants/:want_id/types' do
    before { get "/wants/#{want_id}/types" }

    context 'when want exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all want types' do
        expect(json.size).to eq(20)
      end
    end

    context 'when want does not exist' do
      let(:want_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  # Test suite for GET /wants/:want_id/types/:id
  describe 'GET /wants/:want_id/types/:id' do
    before { get "/wants/#{want_id}/types/#{id}" }

    context 'when want type exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the type' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when want type does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Type/)
      end
    end
  end

  # Test suite for PUT /wants/:want_id/types
  describe 'POST /wants/:want_id/types' do
    let(:valid_attributes) { { name: 'Visit Narnia', done: false } }

    context 'when request attributes are valid' do
      before { post "/wants/#{want_id}/types", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/wants/#{want_id}/types", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /wants/:want_id/types/:id
  describe 'PUT /wants/:want_id/types/:id' do
    let(:valid_attributes) { { name: 'Mozart' } }

    before { put "/wants/#{want_id}/types/#{id}", params: valid_attributes }

    context 'when type exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the type' do
        updated_type = Type.find(id)
        expect(updated_type.name).to match(/Mozart/)
      end
    end

    context 'when the type does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Type/)
      end
    end
  end

  # Test suite for DELETE /wants/:id
  describe 'DELETE /wants/:id' do
    before { delete "/wants/#{want_id}/types/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end