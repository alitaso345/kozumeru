require 'rest_client'
require 'json'
class DocomoAPI
  def initialize
    API_KEY = ENV['DOCOMO_API_KEY']
    @uri = URI('https://api.apigw.smt.docomo.ne.jp/puxImageRecognition/v1/faceDetection')
    @uri.query = 'APIKEY=' + API_KEY
  end
  def face_judgement
    response = RestClient.post(
      @uri.to_s,
      {
        :imageURL => 'http://pbs.twimg.com/media/CDSCIvdUsAAQvxL.jpg',
        :response => 'json'
    },
      :content_type => 'application/x-www-form-urlencoded'
    )
    hash = JSON.parser.new(response).parse()
    p hash["results"]["faceRecognition"]["detectionFaceNumber"]
  end
end
