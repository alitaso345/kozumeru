class HomePageCrawler

  #retrun Hash
  #title, account_name
  def self.blog_detail(url)
    doc = Nokogiri::HTML(open(url))
    title = doc.xpath("//*[@id='blog-header-title']/a").text
    account_name = url.slice("http://www.cafe-athome.com/blog/")

    {title: title, account_name: account_name}
  end

  def self.get_maid_lists
    maids_list = []
    begin
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
          info[:number] = page.url.to_s.match(/\d{2,}/).to_s
          info[:name] = doc.xpath("//div[@id='maid-name']").text
          doc.xpath("//*[@id='maid-properties']/dl[3]/dd/a").each do |node|
            info[:screen_name] = node.attributes["href"].text.to_s.gsub(/https:\/\/twitter.com\//, "")
          end
          info[:floor] = doc.xpath("//*[@id='maid-properties']/dl[1]/dd/a[1]").text
          info[:blog_url] = doc.xpath("//*[@id='maid-properties']/dl[2]/dd/a").first.attributes["href"].value
          maids_list << info
        end
      end 
      maids_list
    rescue => e
      p e
    end
  end
end
