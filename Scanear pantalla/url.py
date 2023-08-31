import urllib
from urllib.error import HTTPError
from urllib.request import Request, urlopen
import pandas as pd



#n = 1000
df = pd.read_excel(r'C:\Users\alekz\OneDrive\Desktop\excelentyc\actividad\Casinos.xlsx')
#df = df.head(n)
#print(df)
#ans = [0]*n
def getResponseCode(url):
    try:
        req = Request(url, headers={'User-Agent': 'Chrome/111.0.0.0'} )
        conn = urlopen(req)
        print(conn.url)
        return conn.status
    except HTTPError as e:
        return e.code
    except ConnectionResetError:
        return "IPb" #Se ha forzado la interrupción de una conexión existente por el host remoto
    except urllib.error.URLError:
        return "IPb" #Se ha forzado la interrupción de una conexión existente por el host remoto
    except ValueError:
        return f"La URL '{url}' no es valida"

for index, row in df.iterrows():
    # Obtener la URL y el nombre de la carpeta según la columna
    url = row['URL']
    carpeta = row['Casino']
    
    print(url)
    print(getResponseCode(url))
    #ans.append(getResponseCode(url))
    ans[index]=getResponseCode(url)

print(ans)   
df['Code'] = ans

df.to_excel("out.xlsx")


#Chrome/111.0.0.0
#[403, 200, 200, 'xxx', 403, 403, 403, 203, 200, 403, 403, 200, 403, 403, 403, 403, 403, 200, 403, 403, 200, 403, 403, 403, 403, 403, 451]
#[403, 200, 200, 'xxx', 403, 403, 403, 200, 200, 403, 403, 200, 403, 403, 403, 403, 403, 200, 403, 403, 200, 403, 403, 200, 403, 403, 200]  
#[403, 200, 200, 'xxx', 403, 403, 403, 200, 200, 403, 403, 200, 403, 403, 403, 403, 403, 200, 403, 403, 200, 403, 403, 200, 403, 403, 200]