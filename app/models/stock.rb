class Stock < ApplicationRecord
	has_many :user_stocks
	has_many :users, through: :user_stocks

	validates :name, :ticker, presence: true
	validates :ticker, uniqueness: { case_sensitive: false }
	
	def self.price_look(ticker_symbol)
		client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.dig(:api_key),
 										secret_token: Rails.application.credentials.dig(:secret_key),
										endpoint: 'https://sandbox.iexapis.com/v1')
		begin
			new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, 
			last_price: client.price(ticker_symbol))
		rescue => exception
			return nil
		end
	end

	def self.find_existing(ticker_symbol)
		where(ticker: ticker_symbol).first
	end
end
