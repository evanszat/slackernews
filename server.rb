require 'sinatra'
require 'csv'
require 'pry'

def import_csv
  articles = []

  CSV.foreach('public/articles.csv', headers: true, header_converters: :symbol) do |row|
    articles << row.to_hash
  end
  return articles
end

get '/' do
  @articles = import_csv
  erb :articles
end

get '/morenews' do
  @articles = import_csv
  erb :morenews
end

post '/morenews' do

  title = params['title']
  description = params['description']
  url = params['url']

  File.open('public/articles.csv', 'a') do |article|
    article.puts("#{description},#{url},#{title}")
  end

  redirect '/'
end
