require 'rails_helper'

describe HomePageCrawler do
  describe '#get_start_time' do
    context '2015年の"5/1【本店6階】15:00～22:00の"のとき' do
      it '2015-05-01 15:00:00 であること' do
        crawler = HomePageCrawler.new
        text = "5/1【本店6階】15:00～22:00の"

        expect(crawler.get_start_time(text)).to eq(Time.new(2015, 5, 1, 15, 00))
      end
    end
  end

  describe '#get_end_time' do
    context '2015年の"5/1【本店6階】15:00～22:00の"のとき' do
      it '2015-05-01 22:00:00 であること' do
        crawler = HomePageCrawler.new
        text = "5/1【本店6階】15:00～22:00の"
        expect(crawler.get_end_time(text)).to eq(Time.new(2015, 5, 1, 22, 00))
      end
    end
  end

  describe '#get_location' do
    context '2015年の"5/1【本店6階】15:00～22:00の"のとき' do
      it 'sixth_floor であること' do
        crawler = HomePageCrawler.new
        text = "5/1【本店6階】15:00～22:00の"
        expect(crawler.get_location(text)).to eq("sixth_floor")
      end
    end
  end
end
