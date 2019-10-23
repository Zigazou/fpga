#!/usr/bin/env python3
from csv import DictReader
from bs4 import BeautifulSoup

soup = BeautifulSoup('', "html5lib")
references = soup.new_tag("ul")
soup.append(references)
with open('bibliographie.csv', newline='') as csvfile:
    bibliographie = DictReader(csvfile, delimiter=',', quotechar='"')

    for reference in bibliographie:
        author = soup.new_tag("span")
        author.attrs['style'] =  "font-family: 'IBM Plex Sans Condensed Medium';"
        if reference['Author'] != "":
            author.append(reference['Author'])
        else:
            author.append(reference['Editor'])

        editor = soup.new_tag("span")
        editor.append(reference['Editor'])

        year = soup.new_tag("span")
        year.attrs['class'] = "Année"
        year.append(reference['Year'])

        title = soup.new_tag("a")
        title.attrs['href'] = reference['URL']
        title.append(reference['Title'])

        element = soup.new_tag("li")
        element.attrs['class'] = "Liste%20bibliographie"
        element.append(author)
        element.append(soup.new_tag("br"))
        element.append(title)
        element.append(soup.new_tag("br"))

        if reference['Author'] != "" and reference['Editor'] != "":
            element.append(editor)
            element.append(soup.new_tag("br"))

        element.append(year)
        references.append(element)

with open("bibliographie.html", "w") as file:
    file.write(str(soup))
