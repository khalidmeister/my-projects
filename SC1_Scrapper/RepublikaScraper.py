from bs4 import BeautifulSoup
import requests

url = "https://www.republika.co.id/"
r = requests.get(url)

c = r.content
soup = BeautifulSoup(c, "html.parser")
newsList = soup.findAll("div",{"class":"populer_set_left_right"})
for n in newsList:
	print(n.h1.text)
