class MaidsController < ApplicationController
  def index
    @maids = Maid.all
  end
end
