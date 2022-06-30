#!/usr/bin/env python3
# Dependências:
# pip3 install beautifulsoup4

# fonte: https://realpython.com/python-web-scraping-practical-introduction/

from bs4 import BeautifulSoup
from urllib.request import urlopen
import logging

logging.basicConfig(filename='obter_link_jar_eSUS.log',
                    format='%(asctime)s:%(levelname)s:%(message)s',
                    level=logging.DEBUG)

url = 'https://sisaps.saude.gov.br/esus/'
page = urlopen(url)
status = page.status

if status == 200:
    logging.info(f'Conectou em {url} - status OK[{status}]')
else:
    logging.error(f'Ocorreu um ERRO[{status}] ao tentar acessar {url}')

    # se não foi possível conectar em site do e-SUS,
    # retorna uma exceção com o código de erro
    raise ConnectionError(f'Ocorreu algum erro[{status}] \
ao tentar conectar em site do e-SUS AB(https://sisaps.saude.gov.br/esus/)')

html = page.read().decode('utf-8')
soup = BeautifulSoup(html, 'html.parser')

# extraido a <section> com o id "download-sistema"
section_download_sistema = soup.findAll('section', id='download-sistema')
# extraido os links <a> de <section>
a_links = section_download_sistema[0].findAll('a')

# localizar o link do JAR do Linux e atribuir a uma variável 
link_download_eSUS_linux = ""
for link in a_links:
	if 'https://arquivos.esusab.ufsc.br/PEC/' in link.attrs['href']:
		if 'Linux' in link.attrs['href']:
			link_download_eSUS_linux = link.attrs['href']

logging.info(f'Obtido link: {link_download_eSUS_linux}')
print(link_download_eSUS_linux)
