from urllib.request import urlopen
from bs4 import BeautifulSoup

html=urlopen("https://www.danubeogradu.rs/rubrike/izlasci/")

bsObj=BeautifulSoup(html,"lxml")

naslovi=bsObj.findAll("h2",{"class":"post-box-title"})
opisi=bsObj.findAll("div",{"class":"entry"})

brojnaslova=len(naslovi)

i=0

while i<brojnaslova:
	print(naslovi[i].getText())
	print(opisi[i].getText())
	print(opisi[i].a['href'])
	i+=1


