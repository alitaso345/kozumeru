class HomePageCrawler
  def initialize
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
          maids_list << info
        end
      end 
      maids_list
    rescue => e
      p e
    end
  end

  def premium_maid
    doc = Nokogiri::HTML(open("http://www.cafe-athome.com/"))
    #情報をWebページからスクレイピング
    premium_maid_list = scraping_premium(doc)

    #取ってきた情報を保存する
    #premium_maid_list.each do |info|
    #  maid = Maid.find_by(name: info[:name])
    #  ServingDays.create(maid_id: maid.id, date: info[:date], start_time: info[:start_time], end_time: info[:end_time], location: info[:location])
    #end
  end

  #return Array[Hash]
  #Hash:name<String>, date<Date>, start_time<Time>, end_time<Time>, location<String>
  def scraping_premium(doc)
    list = []
    begin
      doc.xpath("//div[@class='top-service-info-box']").each_with_index do |box, i|
        info = {}
        info[:name] = box.xpath("//div[@class='maid-name']")[i].text

        service_time_text = box.xpath("//div[@class='service-time']")[i].text.strip
        info[:date] = Date.now
        info[:start_time ] = get_start_time(service_time_text)
        info[:end_time ] = get_end_time(service_time_text)
        info[:location ] = get_location(service_time_text)

        list << info
      end
    rescue => e
      p e
    end
    p list
  end

  def service_time(text)
    text.match(/\//)
    month = $`

    $'.match(/【/)
    day = $`

    $'.match(/】/)
    $'.match(/～/)

    start_time = Time.new(DateTime.now.year, month, day, $`)
    end_time = Time.new(DateTime.now.year, month, day, $')

    {start: start_time, end: end_time}
  end

  def get_location(text)
    text.match(/\//)
    $'.match(/【/)
    $'.match(/】/)
    $`
  end
end
