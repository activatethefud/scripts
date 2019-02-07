# <td class="coll-1 name">
import re
import requests as req
from bs4 import BeautifulSoup


#Get Request object from link
#User-Agent as Mozilla to prevent Error 403: Forbidden
html=req.get('https://1337x.to/search/vikings/1/',headers={"User-Agent":"Mozilla/5.0"})

#Make BeautifulSoup object
bsObj=BeautifulSoup(html.content,"lxml")

#Find all torrents in the html
torrents=bsObj.findAll("td",{"class":"coll-1 name"})

latest="S00E00"
current=0

#Find the latest episode
for torrent in torrents:
	string=torrent.find("a").find_next_sibling("a")['href']
	found=re.search("S\d\dE\d\d",string)
	if found is not None:
		current=found.group(0)
		if(current>latest):
			latest=current

#Check latest with archived
#Write latest to archive
file=open("latest.txt","r")
if(latest>file.readline()):
	file.close()
	file=open("latest.txt","w")
	file.write(latest)
	print("0")
else:
	print("1")

file.close()
