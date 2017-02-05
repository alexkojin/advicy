
SitemapGenerator::Sitemap.default_host = ENV['APP_URL']
SitemapGenerator::Sitemap.sitemaps_host = "http://s3.amazonaws.com/sitemap-generator/"
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new

SitemapGenerator::Sitemap.create do
  Question.find_each do |q|
    add "/questions/#{q.id}/#{q.slug}", lastmod: q.updated_at
  end
end
