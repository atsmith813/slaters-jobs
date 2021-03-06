class JobsController < ApplicationController

	before_action :set_feed, only: :index
	before_action :load_order

	def index
		# Each case represents the sort types available to the user
		case load_order
		when 'job title'
			@jobs = @feed.jobs.order(title: :asc).paginate(page: params[:page], per_page: 10)
		when 'published date'
			@jobs = @feed.jobs.order(published: :desc).paginate(page: params[:page], per_page: 10)
		when 'department'
			@jobs = @feed.jobs.order(author: :asc).paginate(page: params[:page], per_page: 10)
		else
			@jobs = @feed.jobs.paginate(page: params[:page], per_page: 10)
		end

		if params[:author].present?
			@jobs = @jobs.where author: params[:author]
		end

		@visited_jobs = cookies[:visited_jobs].blank? ? "[]" : cookies[:visited_jobs]
		@visited_jobs = JSON.parse @visited_jobs
	end

	def show
		visited_jobs = cookies[:visited_jobs].blank? ? "[]" : cookies[:visited_jobs]
		visited_jobs = JSON.parse(visited_jobs)
		@job = Job.find(params[:id])
		unless visited_jobs.include? @job.id.to_s
			visited_jobs << @job.id
			cookies[:visited_jobs] = visited_jobs.to_json
		end
	end

	private
	def set_feed
		# Hard coding the feed for OSU Jobs. When adding more feeds, replace 1 with params[:id]
		@feed = Feed.find(1)
	end

	# This is pulling in the user's selection for sort type
	def load_order
		params[:order_param] ||= session[:order_param]
		session[:order_param] = params[:order_param]
	end
end
