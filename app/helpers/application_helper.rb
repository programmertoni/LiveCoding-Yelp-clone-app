module ApplicationHelper

  def shorten_full_name(full_name)
    full_name_arr = full_name.split
    short_name    = []
    short_name << full_name_arr.first
    short_name << full_name_arr.last[0]
    short_name.join(' ') + '.'
  end

  def cp(path)
    'active' if current_page?(path)
  end

  def average_rating(company)
    company_reviews = Review.where(company: company)
    return 0 if company_reviews.empty?
    ((company_reviews.pluck(:stars).inject{ |sum, el| sum + el }.to_f) / company_reviews.size).round
  end

end
