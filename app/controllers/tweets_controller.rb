class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all(pramas[:maid_id])
  end
end
