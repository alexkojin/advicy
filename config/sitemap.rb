# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = ENV['APP_URL']

SitemapGenerator::Sitemap.create do
  Question.find_each do |q|
    add "/questions/#{q.id}/#{q.slug}", lastmod: q.updated_at
  end
end
