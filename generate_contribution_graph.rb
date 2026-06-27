
require 'nokogiri'
require 'open-uri'


username = ENV['GITHUB_USERNAME'] || 'Maham-Fatima'
url = "https://github.com/#{username}"

document = Nokogiri::HTML(URI.open(url))
<<<<<<< HEAD
contrib_boxes = document.css('svg.js-calendar-graph-svg')[0]
=======
contrib_boxes = document.at_css('div.js-yearly-contributions svg')
>>>>>>> 876590fa6b2677844297c3d4b0fc2870cff6daa2
contrib_boxes['xmlns'] = "http://www.w3.org/2000/svg"

width = (ENV['WIDTH'] || (54*13-2)).to_i
height = (ENV['HEIGHT'] || 89).to_i


contrib_boxes.css('text').remove

contrib_boxes['width'] = (width + 11).to_s + 'px'
contrib_boxes['height'] = (height + 11).to_s + 'px'
contrib_boxes.at_css('>g')['transform'] = 'translate(0, 0)'

day_boxes = contrib_boxes.css('g>g')
day_boxes.each_with_index do |box, m|
  box['transform'] = "translate(#{m*((width-53*2)/54+2)}, 0)"
  box.css('rect.day').each_with_index do |col, n|
    col['height'] = ((height-12)/7).to_s
    col['width']  = ((width-53*2)/54).to_s
    col['y']      = col['y'].to_i - (11 - ((height-12)/7)) * col['y'].to_i / 13
  end
end


puts contrib_boxes.to_html
