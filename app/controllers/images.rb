require 'net/http'
require 'json'

get '/images' do
  erb :"images"
end

post '/images' do
    uri = URI('https://api.cognitive.microsoft.com/bing/v5.0/images/search')
    uri.query = URI.encode_www_form({
      q: 'chorus frog'
    })
    p uri

    request = Net::HTTP::Post.new(uri.request_uri)
    # Request headers
    request['Content-Type'] = 'multipart/form-data'
    # Request headers
    request['Ocp-Apim-Subscription-Key'] = 'f408ebd8870949908e305530fb4b68cf'
    # Request body
    request.body = "{body}"

    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(request)
    end

    ruby_hash_with_our_data = JSON.parse(response.body)
    @content = ruby_hash_with_our_data['value'].sample['thumbnailUrl']
  # return @content
  erb :"images"
end




