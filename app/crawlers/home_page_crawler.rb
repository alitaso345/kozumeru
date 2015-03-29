class HomePageCrawler
  def initialize
    @maids_list = []
    @console = Logger.new(STDOUT)
  end

  #return Array<Hash>
  def get_maid_lists
    begin
      @console.info("Start crawl @homecafe")
      #クロールの起点となるURLを指定
      urls = [
        'http://www.cafe-athome.com/maids/free/',
        'http://www.cafe-athome.com/maids/honten7f/',
        'http://www.cafe-athome.com/maids/honte16f/',
        'http://www.cafe-athome.com/maids/honten4f/',
        'http://www.cafe-athome.com/maids/donki/',
        'http://www.cafe-athome.com/maids/new/'
      ]

      Anemone.crawl(urls, :depth_limit  => 1, :skip_query_strings => true) do |anemone|
        #巡回先の絞り込み
        anemone.focus_crawl do |page|
          page.links.keep_if{ |link|
            link.to_s.match(/http:\/\/www.cafe-athome.com\/maids/)
          }
        end

        #取得したページに対する処理
        anemone.on_pages_like(/maids\/\d{1,}/) do |page|
          doc = Nokogiri::HTML.parse(page.body)

          info = Hash.new
          info[:maid_number] = page.url.to_s.match(/\d{2,}/).to_s
          info[:name] = doc.xpath("//div[@id='maid-name']").text
          doc.xpath("//*[@id='maid-properties']/dl[3]/dd/a").each do |node|
            info[:username] = node.attributes["href"].text.to_s.gsub(/https:\/\/twitter.com\//, "")
          end
          info[:floor] = doc.xpath("//*[@id='maid-properties']/dl[1]/dd/a[1]").text
          @maids_list << info
        end
      end 
      @console.info("Finish crawl")
      @maids_list
    rescue => e
      p e
    end
  end

  private
  def print_maid_info
    @maids_list.each do |maid|
      puts maid
    end
  end
end
