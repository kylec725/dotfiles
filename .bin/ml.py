#!/usr/bin/python3

import requests
from bs4 import BeautifulSoup
import re

page = requests.get('http://www.cs.umd.edu/~reggia/cmsc422/reads.html')
soup = BeautifulSoup(page.text, 'lxml')
tags = soup.find_all('a', href=True)

links = []
for tag in tags:
    links.append(tag['href'])

links = list(filter(lambda x: re.search(re.compile('.+\.pdf'), x), links))
links.pop(1)

for link in links:
    filename = re.search(re.compile('.+/(.+\.pdf)'), link).group(1)
    r = requests.get(link, auth=('ML12', 'induce'))
    if r.status_code == 200:
        with open('school/spring20/ml/slides/' + filename, 'wb') as out:
            for bits in r.iter_content():
                out.write(bits)
    print(filename + " written to")
