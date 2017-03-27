require 'rails_helper'

RSpec.describe 'Usuarios API', type: :request do
  # initialize test data 
  let!(:usuarios) { create_list(:usuario, 10) }
  let(:usuario_id) { usuarios.first.id }

  describe 'GET /usuarios' do
    # make HTTP get request before each example
    before { get '/usuarios' }

    it 'returns usuarios' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /usuarios/:id
  describe 'GET /usuarios/:id' do
    before { get "/usuarios/#{usuario_id}" }

    context 'when the record exists' do
      it 'returns the usuario' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(usuario_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:usuario_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Usuario/)
      end
    end
  end

  # Test suite for POST /usuarios
  describe 'POST /usuarios' do
    # valid payload
    let(:valid_attributes) { { usuario: 'user123', nombre: 'JaIme' } }

    context 'when the request is valid' do
      before { post '/usuarios', params: valid_attributes }

      it 'creates a usuario' do
        expect(json['usuario']).to eq('user123')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/usuarios', params: { usuario: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Nombre can't be blank/)
      end
    end
  end

  # Test suite for PUT /usuarios/:id
  describe 'PUT /usuarios/:id' do
    let(:valid_attributes) { { usuario: 'jaime1234' } }

    context 'when the record exists' do
      before { put "/usuarios/#{usuario_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /usuarios/:id
  describe 'DELETE /usuarios/:id' do
    before { delete "/usuarios/#{usuario_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end 
  end
end