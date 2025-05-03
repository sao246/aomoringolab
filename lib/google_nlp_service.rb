require 'base64'
require 'json'
require 'net/https'

module GoogleNlpService
  class << self
    def get_entities(text)
      # APIのURL作成（エンティティ抽出に変更）
      api_url = "https://language.googleapis.com/v1/documents:analyzeEntities?key=#{ENV['GOOGLE_API_KEY']}"

      # APIリクエスト用のJSONパラメータ
      params = {
        document: {
          type: 'PLAIN_TEXT',
          content: text
        },
        encodingType: 'UTF8'
      }.to_json

      # Google Cloud Natural Language APIにリクエスト
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)

      # APIレスポンス出力
      response_body = JSON.parse(response.body)

      if (error = response_body['error']).present?
        raise error['message']
      else
        response_body['entities'] # ← エンティティの配列を返す
      end
    end
  end
end
