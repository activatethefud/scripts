from urllib.request import urlopen
from bs4 import BeautifulSoup

html=urlopen("http://poincare.matf.bg.ac.rs/~nina/UOARH1.html")

bsObj=BeautifulSoup(html,"lxml")

for item in bsObj.find("div",{"id":"content"}).find("ol").findAll("a"):
	reverse=item['href'][::-1]
	link=item['href']
	if reverse[0:4:] != "fdp.":
		link=link+".pdf"
	print(link)
