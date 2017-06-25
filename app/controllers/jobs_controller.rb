class JobsController < ApplicationController

	before_action :set_feed, only: :index
	#before_action :set_order
	before_action :load_order

	def index
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
	end

	def show
		@job = Job.find(params[:id])
	end

	private
	def set_feed
		#hard coding the feed for OSU Jobs. When adding more feeds, replace one with params[:id]
		@feed = Feed.find(1)
	end

	#def set_order
		#order_param = params[:order_param]
	#end

	def load_order
		params[:order_param] ||= session[:order_param]
		session[:order_param] = params[:order_param]
		if params[:order_param]
			order_param = params[:order_param]
		end
	end
end
