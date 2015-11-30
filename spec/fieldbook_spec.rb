require 'spec_helper'

describe Fieldbook do

  it 'has a version number as a string representation and exists' do
    expect(Fieldbook::VERSION).not_to be nil
    expect(Fieldbook::VERSION).to be_an_instance_of String
  end

  describe Fieldbook::Book do

    before :each do
      @new_book = Fieldbook::Book.new(ENV['FIELDBOOK_ID'], ENV['FIELDBOOK_USER'], ENV['FIELDBOOK_PASS'])
    end

    it 'exists' do
      expect(@new_book).not_to be nil
    end

    it 'should have a method named get_sheet' do
      expect(@new_book).to respond_to :get_sheet
    end

    it 'should have a method named list_sheets' do
      expect(@new_book).to respond_to :list_sheets
    end

    it 'should have a method named delete_record' do
      expect(@new_book).to respond_to :delete_record
    end

    describe "#get_sheet" do
      it 'should return array' do
        expect(@new_book.get_sheet('sessions')).to be_an_instance_of Array
      end
      it 'should not be an empty array' do
        expect(@new_book.get_sheet('sessions').count).to be > 0
      end
      it 'should return a subset hash object from the sheet as specified by the second argument' do
        expect(@new_book.get_sheet('sessions', 1)).to be_an_instance_of Hash
      end
    end
    describe "#list_sheets" do
      it 'should return an array of sheets' do
        expect(@new_book.list_sheets).to be_an_instance_of Array
        expect(@new_book.list_sheets.count).to be > 0
      end
    end
    describe "#delete_record" do
      it "should delete a record using it's record id from the specified sheet" do
        expect(@new_book.delete_record('attendees', 11).code).to eq 204
      end
    end
    describe "#create_record" do
      it "should create a new record using a sheet name and record id" do

        properties = {
            name: "Larry Blair",
            company: "Comcast",
            email: "larry.blair@comcast.com",
            paid: "yes"
          }

        expect(@new_book.create_record('attendees', properties).code).to eq 201
      end
    end
  end

end
