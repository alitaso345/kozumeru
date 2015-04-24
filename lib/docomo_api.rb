require 'rest_client'
require 'json'
class DocomoAPI
  def initialize
    API_KEY = ENV['DOCOMO_API_KEY']
    @uri = URI('https://api.apigw.smt.docomo.ne.jp/puxImageRecognition/v1/faceDetection')
    @uri.query = 'APIKEY=' + API_KEY
  end

#渡された画像URLに顔が写っているかどうかを判定
  def face_judgement(picture_url)
    response = RestClient.post(
      @uri.to_s,
      {
        :imageURL => picture_url,
        :response => 'json'
    },
      :content_type => 'application/x-www-form-urlencoded'
    )
    hash = JSON.parser.new(response).parse()
    @kind=1 if hash["results"]["faceRecognition"]["detectionFaceNumber"]
  end
end
