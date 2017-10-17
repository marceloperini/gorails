class HomeController < ApplicationController
  def index
    @news = Blog::Post.tagged_with('noticias').where('? >= published_at and draft = ?', DateTime.now, false)
                .includes(:user).limit(5).order(published_at: :desc)
  end
end
