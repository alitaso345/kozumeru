class HomePageCrawler
  def initialize
  end

  def self.get_maid_lists
    maids_list = []
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
        info[:blog_url] = get_blog_url(doc)
        maids_list << info
      end
    end 

    maids_list
  end

  #retrun Hash
  #title, account_name
  def self.blog_detail(url)
    doc = Nokogiri::HTML(open(url))
    title = doc.xpath("//*[@id='blog-header-title']/a").text
    account_name = url.gsub(/^http:\/\/www.cafe-athome.com\/blog\//, "").gsub(/\/$/, "")

    {title: title, account_name: account_name}
  end

  #arguments url<String>
  #return <Hash>
  #title<String>, body<String>, published_at<DateTime>, pictures<Array[String]>
  def self.get_post_info(url)
    post = Nokogiri::HTML(open(url))
    title = post.xpath("//*[@id='main']/div[5]/div[@class='box-inner']").first.xpath("//h2//a").text
    body = post.xpath("//div[@class='article blog-post-content']").children.text.gsub(/[\r\n\s]/, "")
    published_at = Date.parse(post.xpath("//div[@class='article-date']").text.gsub(/\./, "-").match(/^.{,10}/).to_s)
    picture_urls = post.xpath("//div[@class='article blog-post-content']//img").map{|node| node.attributes["src"].value}.select{|url| !url.match(/\.gif/)}

    {title: title, body: body, published_at: published_at, picture_urls: picture_urls}
  end

  def self.import_posts
    blogs = Blog.all
    blogs.each do |blog|
      doc = Nokogiri::HTML(open("http://www.cafe-athome.com/blog/#{blog.account_name}"))
      get_top_post_urls(doc).each do |link|
        info = get_post_info(link)
        post = Post.create(blog_id: blog.id, url: link, title: info[:title], body: info[:body], published_at: info[:published_at])
        info[:picture_urls].each do |url|
          Picture.create!(post_id: post.id, url: url, analyzed: false, published_at: info[:published_at])
        end
      end
    end
  end

  #スクレイピングしてきた情報を保存する
  def premium_maid
    scraping_premium.each do |info|
      maid = Maid.find_by(name: info[:name])
      ServingDay.create!(maid_id: maid.id, date: info[:date], start_time: info[:start_time], end_time: info[:end_time], location: info[:location])
    end
  end

  #return Array[Hash]
  #Hash:name<String>, date<Date>, start_time<Time>, end_time<Time>, location<String>
  def scraping_premium
    doc = Nokogiri::HTML(open("http://www.cafe-athome.com/"))
    list = []

    begin
      doc.xpath("//div[@class='top-service-info-box']").each_with_index do |box, i|
        info = {}
        info[:name] = box.xpath("//div[@class='maid-name']")[i].text

        text = box.xpath("//div[@class='service-time']")[i].text.strip

        next if text.blank?

        time = service_time(text)

        info[:date] = Date.new(Time.now.year, Time.now.month, Time.now.day)
        info[:start_time ] = time[:start]
        info[:end_time ] = time[:end]
        info[:location ] = get_location(text)

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

  private
  def self.get_blog_url(doc)
    link = doc.xpath("//*[@id='maid-properties']/dl[2]/dd/a").first
    link ? link.attributes["href"].value : nil
  end

  def self.get_top_post_urls(doc)
    doc.xpath("//ol[@class='sidebar-recent-posts']//a").map{|node| node.attributes["href"].value}
  end
end
