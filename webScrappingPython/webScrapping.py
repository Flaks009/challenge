import webbrowser, sys, bs4, requests

address = ''.join(sys.argv[1:])

webbrowser.open('http://www.google.com/maps/place/' + address)
session = requests.Session()
session.trust_env = False
url = 'https://twitter.com/usefretadao'
res = session.get(url)

obj = bs4.BeautifulSoup(res.text, features="html.parser")
nome = obj.select('.ProfileHeaderCard-nameLink')
bio = obj.select('.ProfileHeaderCard-bio')

print(nome[0].getText())
print(bio[0].getText())