require 'httparty'

module Fieldbook
  class Book
    include HTTParty

    def initialize(book_id, username, password)
      self.class.base_uri "https://api.fieldbook.com/v1/#{book_id}"
      self.class.basic_auth username, password
    end

    def get_sheet(sheet_name, item_id = nil)

      if item_id
        self.class.get "/#{sheet_name}/#{item_id}.json"
      else
        self.class.get "/#{sheet_name}.json"
      end

    end

    def list_sheets
      self.class.get "/"
    end

  end
end
