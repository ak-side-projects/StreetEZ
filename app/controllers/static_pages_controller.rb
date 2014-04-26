class StaticPagesController < ApplicationController
  
  def about
    render :about
  end
  
  def help
    render :help
  end
  
end
