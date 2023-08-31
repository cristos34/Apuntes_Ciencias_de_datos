# -*- coding: utf-8 -*-
"""Te damos la bienvenida a Colaboratory

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/notebooks/intro.ipynb
"""

import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt 
import scipy
from sklearn.metrics.pairwise import cosine_similarity
from sklearn.utils.extmath import randomized_svd
from sklearn.feature_extraction.text import  TfidfVectorizer
import pickle

platforms = pd.read_csv('DataPlataformas.csv',sep=";")

platforms.head(2)



MachinePeli = platforms[['id', 'title',"userId",'scored']] 
#user_item.reset_index(drop=True)
MachinePeli = MachinePeli

MachinePeli

#MachinePeli.to_csv('user_item.csv', index=False)

# Vectorizador TfidfVectorizer con parámetros de reduccion procesamiento
vectorizer = TfidfVectorizer(min_df=10, max_df=0.5, ngram_range=(1,2))

# Ajustar y transformar el texto de la columna "descripcion" del DataFrame
X = vectorizer.fit_transform(MachinePeli['title'])

# Calcular la matriz de similitud de coseno con una matriz reducida de 5500x5500
similarity_matrix = cosine_similarity(X[:5500,:])

# Obtener la descomposición en valores singulares aleatoria de la matriz de similitud de coseno con 10 componentes
n_components = 10
U, Sigma, VT = randomized_svd(similarity_matrix, n_components=n_components)

# Construir la matriz reducida de similitud de coseno
reduced_similarity_matrix = U.dot(np.diag(Sigma)).dot(VT)

reduced_similarity_matrix

reduced_similarity_df = pd.DataFrame(reduced_similarity_matrix)
reduced_similarity_df.to_csv('MachinePeli.csv', index=False)

reduced_similarity_df

def get_recommendation(titulo: str):
    try:
        #Ubicamos el indice del titulo pasado como parametro en la columna 'title' del dts user_item
        indice = np.where(MachinePeli['title'] == titulo)[0][0]
        #Encontramos los indices de las puntuaciones y caracteristicas similares del titulo 
        puntuaciones_similitud = reduced_similarity_matrix[indice,:]
        #Ordenamos los indices de menor a mayor
        puntuacion_ordenada = np.argsort(puntuaciones_similitud)[::-1]
        #seleccionamos solo 5 
        top_indices = puntuacion_ordenada[:5]
        #retornamos los 5 items con sus titulos como una lista
        return MachinePeli.loc[top_indices, 'title'].tolist()
        #Si el titulo dado no se encuentra damos un aviso
    except IndexError:
        print(f"El título '{titulo}' no se encuentra en la base de datos. Intente con otro título.")

get_recommendation('the grand seduction')