require 'rails_helper'

describe HomePageCrawler do
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
      end
    end
  end
end