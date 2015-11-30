require 'httparty'

module Fieldbook
  class Book
    include HTTParty

    def initialize(book_id, username, password)
      self.class.base_uri "https://api.fieldbook.com/v1/#{book_id}"
      self.class.basic_auth username, password
    end

    def get_sheet(sheet_name, record_id = nil)

      if record_id
        self.class.get "/#{sheet_name}/#{record_id}.json"
      else
        self.class.get "/#{sheet_name}.json"
      end

    end

    def list_sheets
      self.class.get "/"
    end

    def delete_record(sheet_name, record_id)
      self.class.delete "/#{sheet_name}/#{record_id}.json"
    end

    def create_record(sheet_name, properties)
      data = {
        body: properties.to_json,
        headers: {
          "Content-Type" => "application/json"
        }
      }
      self.class.post "/#{sheet_name}.json", data
    end
  end
end
