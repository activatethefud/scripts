import re
from urllib.request import urlopen
from bs4 import BeautifulSoup

html=urlopen("http://www.matf.bg.ac.rs/p/ilija-vrecica/sve-vesti/")

bsObj=BeautifulSoup(html,"lxml")

vesti=bsObj.find("div",{"class":"content"}).findAll("div",{"class":"content"})

linkovi=bsObj.find("div",{"class":"content"}).findAll("a",{"class":"f-right"})


n=len(vesti)
i=0

while i<n:
	print(vesti[i].getText())
	print(linkovi[i]['href'])
	i+=1

