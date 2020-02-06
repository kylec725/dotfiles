#!/usr/bin/python3

import requests
from bs4 import BeautifulSoup
import re
import os

page = requests.get('http://www.alagic.org/cmsc-456-cryptography-spring-2020/')
soup = BeautifulSoup(page.text, 'lxml')
tags = soup.find_all('a', href=True)

links = []
for tag in tags:
    links.append(tag['href'])

links = list(filter(lambda x: re.search(re.compile('.+\.pptx'), x), links))

for link in links:
    filename = re.search(re.compile('.+/(.+\.pptx)'), link).group(1)
    r = requests.get(link)
    if r.status_code == 200:
        with open('school/spring20/crypto/slides/' + filename, 'wb') as out:
            for bits in r.iter_content():
                out.write(bits)

os.system('libreoffice --headless --invisible --convert-to pdf --outdir ~/school/spring20/crypto/slides ~/school/spring20/crypto/slides/*pptx')
os.system('rm ~/school/spring20/crypto/slides/*.pptx')
