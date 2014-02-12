#!/usr/bin/env ruby
# encoding: utf-8
require 'nokogiri'
classement = Hash.new
for i in 1..10 
	page_nb = i
	html=html=`curl 'http://www.biilink.com/widget' -H 'Cookie: PHPSESSID=5gjk43fbtuls4lfmgj488f9pu1; __utma=187990587.861801110.1392135428.1392160129.1392200225.3; __utmb=187990587.1.10.1392200225; __utmc=187990587; __utmz=187990587.1392135428.1.1.utmcsr=google|utmccn=(organic)|utmcmd=organic|utmctr=(not%20provided)' -H 'Origin: http://www.biilink.com' -H 'Accept-Encoding: gzip,deflate,sdch' -H 'Host: www.biilink.com' -H 'Accept-Language: en-US,en;q=0.8' -H 'User-Agent: Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/31.0.1650.63 Chrome/31.0.1650.63 Safari/537.36' -H 'Content-type: application/x-www-form-urlencoded; charset=UTF-8' -H 'Accept: text/html, application/xml, text/xml, */*' -H 'Referer: http://www.biilink.com/pages/projets' -H 'X-Requested-With: XMLHttpRequest' -H 'Connection: keep-alive' --data 'title=&titleCount=true&is_store=0&postedby=1&showfeaturedLable=1&showsponsoredLable=1&showoptions[0]=viewCount&showoptions[1]=likeCount&detactLocation=0&defaultlocationmiles=1000&category_id=70&itemWidth=230&withoutStretch=0&itemCount=24&show_buttons[0]=comment&show_buttons[1]=like&show_buttons[2]=facebook&show_buttons[3]=twitter&truncationDescription=100&commentSection=1&nomobile=0&name=sitepage.pinboard-browse&noOfTimes=19&controller=pages&action=projets&module=core&rewrite=1&content_id=2807&contentpage=#{page_nb}&format=html&subject=&is_ajax_load=true' --compressed`

doc = Nokogiri::HTML(html)
 
mes_items = doc.css('div.seaocore_board_list_cont')
mes_trucs_interessants = mes_items.map do |item|
	project_name = item.children.css('div.seaocore_title').children.text.strip
	like = item.children.css('div.seaocore_stats.seaocore_txt_light').children.text.strip
	nb_like= like[like.rindex('s')+1,like.length].lstrip.gsub(/[^\d]/, '').to_i

	classement[project_name]= nb_like

	end	

end

classement2 = Hash[classement.sort_by{|k, v| v}.reverse]
n=1
classement2.each do|project_name,nb_like|
	n = n + 1
	break if n == 30
	inTop = true if project_name == "I wheel share"
	puts "#{project_name}: #{nb_like}"
end

puts "Come on Audrey, t'es au top !!!" if inTop = true