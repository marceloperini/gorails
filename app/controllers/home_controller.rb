class HomeController < ApplicationController
  def index
    @news = Blog::Post.tagged_with('noticias').where('? >= published_at and draft = ?', DateTime.now, false)
                .includes(:user).limit(5).order(published_at: :desc)

    @jobs = Jobs::Job.all.where(status: true).order(expiration_date: :desc).limit(5)

    @events = Event.not_happened_yet(DateTime.now).order(start_at: :asc).limit(5)

@transactions = FinancialTransaction.all.order(payment_date: :asc).limit(5)
  end
end
