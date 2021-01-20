require "pry"
require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper

  def get_page
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
    #binding.pry
  end

  def get_courses
    self.get_page.css(".post")
  end

  def make_courses
    self.get_courses.collect do |element|
      course = Course.new
      binding.pry
      course.title = element.css("h2").text
      course.schedule = element.css(".date").text
      course.description = element.css("p").text
    end
  end

  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

end
Scraper.new.get_page
#doc.css(".post").first.css("h2").text
#doc.css(".post").first.css("h2").attributes
#doc.css(".post").first.css(".date")
#doc.css(".post").first.css(".date").text
#oc.css(".post").first.css("p")
#doc.css(".post").first.css("p").text
