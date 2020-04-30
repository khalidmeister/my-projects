from bs4 import BeautifulSoup
import requests

url = "https://www.kompas.com/"
r = requests.get(url)
html = r.content

soup = BeautifulSoup(html, "html.parser")
headline = soup.findAll("div", {"class":"most__list"})
for n in headline:
	print(n.h4.text)
