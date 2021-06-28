#!/usr/bin/python3
import sys 
import json 
import re

with open('movies.json', 'r', encoding='utf8') as file:
    data = json.load(file)

out = open('individuals.ttl', 'w+')

def normalize_string(data):
  for c in [' ','\s', '\t', '\\', '/', '&', '[', ']', '(', ')', '.', '…', '\'', ',', '?', '!', ':', ';', '\"', '"', '\n', '-', '|', '\|', '$', '\$', '~', '\-', '–', '’', '\’', '*', '+', '%', '\%']:
    data = data.replace(c, '')
    data = re.sub('[^A-Za-z0-9]+', '', data)
  return data.replace(' ', '_').lower()

def normalize_string_name(data):
  for c in ['"', '\"']:
    data = data.replace(c, '')
  return data

def gera_ttl(movies):
    for movie in movies:
        title = movie.get('title')
        id_title = normalize_string(title)
        for cast in movie.get('cast'):
            id_cast = normalize_string(cast)
            out.write(f'''
###  http://www.semanticweb.org/puyol/ontologies/movies#ator_{id_cast}
:ator_{id_cast} rdf:type owl:NamedIndividual ,
                            :Ator ;
                   :eAtor :movie_{id_title} ;
                   :nome "{normalize_string_name(cast)}" .
            ''')

        for genre in movie.get('genres'):
            id_genre = normalize_string(genre)
            out.write(f'''
###  http://www.semanticweb.org/puyol/ontologies/movies#genre_{id_genre}
:genre_{id_genre} rdf:type owl:NamedIndividual ,
                       :Género ;
              :eGenero :movie_{id_title} ;
              :nome "{normalize_string_name(genre)}" .
            ''')
        out.write(f'''
###  http://www.semanticweb.org/puyol/ontologies/movies#movie_{id_title}
:movie_{id_title} rdf:type owl:NamedIndividual ,
                             :Filme ;
                    :title "{normalize_string_name(title)}" ;
                    :year "{movie.get('year')}"^^xsd:int .

        ''')

def main():
    gera_ttl(data)
    out.write('\n')
    out.close()

main()