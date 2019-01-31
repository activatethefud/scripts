#http://poincare.matf.bg.ac.rs/~biljana/
#http://www.prog1-i-smer.matf.bg.ac.rs/
#http://www.matf.bg.ac.rs/p/ilija-vrecica/sve-vesti/
#http://poincare.matf.bg.ac.rs/~tanjas/

from urllib.request import urlopen
from bs4 import BeautifulSoup

html=urlopen("http://www.prog1-i-smer.matf.bg.ac.rs/obavestenja.html")

bsObj=BeautifulSoup(html,"lxml")

for obavestenje in bsObj.findAll("div",{"class":"alert alert-success"}):
	print(obavestenje.a['href'])
	print(obavestenje.getText())

