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
      it 'should exist' do
        expect(@new_book).to respond_to :list_sheets
      end
      it 'should return an array of sheets' do
        expect(@new_book.list_sheets).to be_an_instance_of Array
        expect(@new_book.list_sheets.count).to be > 0
      end
    end
  end

end
