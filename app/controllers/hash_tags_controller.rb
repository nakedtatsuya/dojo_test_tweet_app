class HashTagsController < ApplicationController
  def index
    @hash_tags = HashTag.all
  end

  def trend
  end
end
