require 'nokogiri'
require 'httparty'
require 'byebug'

#SCRAPPER FUNCTION TO SCRAPE SOFTWARE ENGINEER JOBS
def scrapper
  url = "https://ca.linkedin.com/jobs/search?keywords=Software%20Engineer&location=Windsor%2C%20Ontario%2C%20Canada&trk=guest_job_search_jobs-search-bar_search-submit&redirect=false&position=1&pageNum=0"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  jobs = Array.new
  jobCards = parsed_page.css('div.result-card__contents.job-result-card__contents') #25 job listings
  #perPage = jobCards.count
  #total = parsed_page.css("span.results-context-header__job-count").text.gsub(',','').gsub('+','').to_i #2000 jobs
  #lastPage = (total.to_f / perPage.to_f).round
  jobCards.each do |jobCard|
    job = {
      title: jobCard.css('h3').text,
      company: jobCard.css('h4').text,
      location: jobCard.css('span.job-result-card__location').text,
      description: jobCard.css('p').text
    }
      jobs << job
  end
  byebug
end
scrapper
