# This updates the tables by scraping the URLs included in Feeds to populate postings into Jobs
namespace :sync do
	task feeds: [:environment] do
		Feed.all.each do |feed|
			content = Feedjira::Feed.fetch_and_parse feed.url
			content.entries.each do |job|
				local_job = feed.jobs.where(title: job.title).first_or_initialize
				local_job.update_attributes(content: job.content, author: job.author, url: job.url, published: job.published)
				p "Synced job - #{job.title}"
			end
			p "Synced Feed - #{feed.name}"
		end
	end	
end