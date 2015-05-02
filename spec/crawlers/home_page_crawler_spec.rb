require 'rails_helper'

describe HomePageCrawler do
  describe '#service_time'do
    context '"5/1【本店6階】15:00～22:00の"のとき' do
      crawler = HomePageCrawler.new
      text = "5/1【本店6階】15:00～22:00の"

      service_time = crawler.service_time(text)

      it '開始時間が05-01 15:00:00 であること' do
        expect(service_time[:start]).to eq(Time.new(DateTime.now.year, 5, 1, 15, 00))
      end

      it '終了時間が05-01 22:00:00 であること' do
        expect(service_time[:end]).to eq(Time.new(DateTime.now.year, 5, 1, 22, 00))
      end
    end
  end

  describe '#get_location' do
    context '"5/1【本店6階】15:00～22:00の"のとき' do
      it 'sixth_floor であること' do
        crawler = HomePageCrawler.new
        text = "5/1【本店6階】15:00～22:00の"
        expect(crawler.get_location(text)).to eq("本店6階")
      end
    end
  end
end
