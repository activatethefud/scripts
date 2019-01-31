import re
from urllib.request import urlopen
from bs4 import BeautifulSoup

html=urlopen("http://www.prog1-i-smer.matf.bg.ac.rs/vezbe.html")

bsObj=BeautifulSoup(html,"lxml")

casovi=bsObj.findAll("div",{"class":"panel-body"})

for cas in casovi:
	linkovi=cas.findAll("a",{"href":re.compile(r'.pdf')})
	for link in linkovi:
		if link['href'][0:4:] != "http":
			print("http://www.prog1-i-smer.matf.bg.ac.rs/" + link['href'])
		else:
			print(link['href'])
	print()
