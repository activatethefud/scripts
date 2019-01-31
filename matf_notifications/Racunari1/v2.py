#http://poincare.matf.bg.ac.rs/~biljana/
#http://www.prog1-i-smer.matf.bg.ac.rs/
#http://www.matf.bg.ac.rs/p/ilija-vrecica/sve-vesti/
#http://poincare.matf.bg.ac.rs/~tanjas/

from urllib.request import urlopen
from bs4 import BeautifulSoup

html=urlopen("http://poincare.matf.bg.ac.rs/~biljana/vesti.html")
bsObj=BeautifulSoup(html,"lxml")

obavestenja=bsObj.findAll("div",{"class":"right"})
for obavestenje in obavestenja:
	print(obavestenje.getText())
	print(obavestenje.a)




