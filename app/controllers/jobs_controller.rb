class JobsController < ApplicationController

	before_action :set_feed, only: :index

	def index
		@jobs = @feed.jobs
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
