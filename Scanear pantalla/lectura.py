#Tener en cuenta las bibliotecas que instalar
import pandas as pd
import os
from selenium import webdriver
from selenium.common.exceptions import WebDriverException
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities  
import time

# Cargar el archivo Excel (Ingresar la ruta del excel)
df = pd.read_excel(r'C:\Users\user\Documents\Casinos.xlsx')
pais = input("Nombre del pais que se esta verificando: ")

# Configuraciones iniciales del webdriver
options = webdriver.ChromeOptions()
options.add_argument('--ignore-certificate-errors')
options.add_argument('--incognito')

driver = webdriver.Chrome(options=options)
actUrl=[]

# Repetir sobre el archivo (importante especificar el nombre de la columna)
for index, row in df.iterrows():
    # Obtener la URL y el nombre de la carpeta según la columna
    url = row['URL']
    casino = row['Casino']
    carpeta = pais
    nombre_archivo = f'{casino}.png'
    
    # Ruta de guardado de los pantallazos
    ruta_carpeta = os.path.join(r'C:\Users\user\Documents\WebdriverExcel', carpeta)
    
    # Crear la carpeta si no existe
    if not os.path.exists(ruta_carpeta):
        os.makedirs(ruta_carpeta)
    
    # Navegar a la página y tomar el pantallazo
    #try:
        #driver.get(url)
    ruta_archivo = os.path.join(ruta_carpeta, nombre_archivo)
    try:
        driver.get(url)
        actUrl.append(driver.current_url)
        driver.save_screenshot(ruta_archivo)
    except WebDriverException:
        actUrl.append("Blocked")
        
df['URL Real'] = actUrl
df.to_excel("output.xlsx")
"""
        try:
            print("DATRA: ", data)
        except TypeError:
            print("ajdhs")
    except WebDriverException:
        print("ERR_NAME_NOT_RESOLVED / IP Block")"""
# Cerrar el webdriver
#driver.quit()