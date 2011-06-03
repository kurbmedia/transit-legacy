Fabricator(:post) do
  title     { Fabricate.sequence(:title) { |i| "This is post number #{i}" } }
  post_date { Time.at(0.0 + rand * (Time.now.to_f - 0.0)) }
end