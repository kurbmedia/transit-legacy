Transit::Admin.register(:post) do |conf|
  conf.columns :title, timestamp: { as: 'Post Date', proc: lambda{ |post| post.timestamp }}
end