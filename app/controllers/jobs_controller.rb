class JobsController < ApplicationController

	before_action :set_feed, only: :index


	def index
		order_param = params[:order_param]
		case order_param
		when 'job title'
			@jobs = @feed.jobs.order(title: :asc).paginate(page: params[:page], per_page: 10)
		when 'published date'
			@jobs = @feed.jobs.order(published: :desc).paginate(page: params[:page], per_page: 10)
		when 'department'
			@jobs = @feed.jobs.order(author: :asc).paginate(page: params[:page], per_page: 10)
		else
			@jobs = @feed.jobs.paginate(page: params[:page], per_page: 10)
		end
	end

	def show
		@job = Job.find(params[:id])
	end

	private
	def set_feed
		#hard coding the feed for OSU Jobs. When adding more feeds, replace one with params[:id]
		@feed = Feed.find(1)
	end

end
