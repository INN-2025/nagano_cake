require 'rails_helper'

RSpec.describe Public::CustomersController, type: :controller do
  describe "GET #show" do
    it "returns a success response" do
      customer = Customer.create!(
        last_name: "山田", first_name: "太郎",
        last_name_kana: "ヤマダ", first_name_kana: "タロウ",
        postal_code: "1234567", address: "大阪市",
        telephone_number: "08000000000",
        email: "test@example.com", password: "password"
      )
      sign_in customer
      get :show, params: { id: customer.id }
      expect(response).to have_http_status(:success)
    end
  end
end