class HomePageCrawler
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
    picture_urls = post.xpath("//div[@class='article blog-post-content']//img").map{|node| node.attributes["src"].value}.select{|url| url.match(/\.jpg/)}

    {title: title, body: body, published_at: published_at, picture_urls: picture_urls}
  end

  def self.import_posts
    blogs = Blog.all
    blogs.each do |blog|
      doc = Nokogiri::HTML(open("http://www.cafe-athome.com/blog/#{blog.account_name}"))
      begin
        get_top_post_urls(doc).each do |link|
          info = get_post_info(link)
          post = Post.create!(blog_id: blog.id, url: link, title: info[:title], body: info[:body], published_at: info[:published_at])
          info[:picture_urls].each do |url|
            Picture.create!(post_id: post.id, url: url, analyzed: false, published_at: info[:published_at])
          end
        end
      rescue => e
        p e
      end
    end
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
