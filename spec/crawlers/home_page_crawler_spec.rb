require 'rails_helper'

describe HomePageCrawler do
<<<<<<< HEAD
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
=======
  describe '#blog_detail' do
    context 'めるちゃんのURLの時' do
      it '正確にスクレイピングできていること' do
        url = "http://www.cafe-athome.com/blog/meru/"
        expect(HomePageCrawler.blog_detail(url)).to eq({title: "チョコレイトめるこ", account_name: "meru"})
      end
    end
  end

  describe '#get_maid_lists' do
    context '実行したとき' do
      it '返り値の型がArrayであること' do
        expect(HomePageCrawler.get_maid_lists.class) == Array
>>>>>>> master
      end
    end
  end

<<<<<<< HEAD
  describe '#get_location' do
    context '"5/1【本店6階】15:00～22:00の"のとき' do
      it 'sixth_floor であること' do
        crawler = HomePageCrawler.new
        text = "5/1【本店6階】15:00～22:00の"
        expect(crawler.get_location(text)).to eq("本店6階")
=======
  describe '#get_post_info' do
    context 'めるちゃんのURLのとき' do
      it '正しくスクレイピングできている' do
        url = 'http://www.cafe-athome.com/blog/meru/2015/04/25/3373'
        info = HomePageCrawler.get_post_info(url)
        expect(info[:title]).to eq('今日のめるるんは')
        expect(info[:body]).to eq("いつもとすこしだけちがうよー！ぺたりん♡6階にてお待ちしてます！my")
        expect(info[:published_at]).to eq(Date.new(2015, 04, 25))
        expect(info[:picture_urls]).to eq(["http://www.cafe-athome.com/blog/meru/files/2015/04/image1_25-480x360.jpg"])
>>>>>>> master
      end
    end
  end
end
