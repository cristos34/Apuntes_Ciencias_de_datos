/*1- Ejecutar en la consola el contenedor “hello-world” del Docker-Hub y luego verificar si está ejecutando:
$ docker run hello-world (corro el contenedor hello-world)
$ docker ps (muestra los contenedores activos) : muestra solamente los contenedores que estan activo

2- Ejecutar una inspección de un contenedor específico
$ docker ps -a (muestra todos los contenedores 
$ docker inspect <container ID> (muestra el detalle completo de un contenedor)
$ docker inspect <name> (igual que el anterior pero invocado con el nombre)

3- Ejecutar el contenedor “hello-world” asignandole un nombre distinto.
$ docker run -d –-name hola-mundo hello-world (le asigno un nombre custom “hola-mundo”)
$ docker rename hola-mundo hola-a-todos (cambio el nombre de hola-mundo a hola-a-todos)

4- Ejecutar la eliminación de un contenedor (usar rm y prune)
$ docker rm <ID o nombre> (borro un contenedor)
$ docker container prune (borro todos lo contenedores que esten parados)

Explorar Docker Hub y probar ejecutar alguna de las imagenes. https://hub.docker.com/

11) Ejecutar la imagen “ubuntu”:
$ docker run ubuntu (corre un ubuntu pero lo deja apagado)
$ docker run -it ubuntu (lo corre y entro al shell de ubuntu)

            -i: interactivo
			-t: abre la consola

- corre el siguiente comando en la consola de linux $ cat /etc/lsb-release (veo la versión)

* Ejecutar la imagen “nginx” y probar los comandos “stop” y “rm”
$ docker run -d --name proxy nginx (corro un nginx)
$ docker stop proxy (apaga el contenedor)
$ docker rm proxy (borro el contenedor)
$ docker rm -f <contenedor> (lo para y lo borra)

12) Ejecutar nginx exponiendo el puerto 8080 de mi máquina
Exponer contenedores:
$ docker run -d --name proxy -p 8081:80 nginx (corro un nginx y expongo el puerto 80 del contenedor en el puerto 8080 de mi máquina)

localhost:8081 (desde mi navegador compruebo que funcione)

13) Ejecutar el comando logs para ver los logs del contenedor de nginx:
$ docker logs proxy (veo los logs)
$ docker logs -f proxy (hago un follow del log)

14) Ejecutar comando “logs –tail” para ver las últimas N entradas de log
$ docker logs --tail 10 -f proxy (veo y sigo solo las 10 últimas entradas del log)

15) Ejecutar la imagen “mongodb” y asociarla con un directorio en mi máquina
$ mkdir dockerdata (creo un directorio en mi máquina)
$ docker run -d –-name mongodb -v <path de mi maquina>:<path dentro del contenedor(/data/db)> mongo (corro un contenedor de mongo y creo un bind mount)
Se debe entrar al directorio creado y desde ahí ejecutar el siguiente comando (o en su defecto copiar el resultado de pwd dentro del directorio en nuestra declaración):

docker run -d --name mongodb -v "$(pwd)":/data/db mongo

De arrojar error Exited (132) debemos usar otra versión (4.4 por ejemplo) usango mogno:X.X en vez de mongo solamente.2

16) Ejecutar el comando “exec” para introducirse en el shell de un contenedor:
$ docker ps (veo los contenedores activos)
$ docker exec -it mongodb bash (entro al bash del contenedor)

17) Ejecutar los siguientes comandos:
$ mongo (me conecto a la base de datos)
show dbs (listo las bases de datos)
use prueba (creo la base “prueba”)
db.prueba.insert({‘color’: ’azul’}) (inserto un nuevo dato)
db.prueba.find() (veo el dato que cargué)
Revisar el contenido del directorio creado
Volver a ejecutar el contenedor mongodb y verificar que el dato insertado en una ejecución previa ya se pueda ver, debido a que la nueva ejecución levanta lo datos ligados mediante Bind. Se debe usar el comando docker container start mongodb si está parado

18) Volúmenes
$ docker exec -it mongodb bash (ingresar al contenedor)

$ mongo (conectarse a la BBDD)

show dbs #se listan las BBDD

use prueba #se crea la BBDD prueba

db.prueba.insert({“color”:“azul”}) #se carga un dato

db.prueba.find() #se visualiza el dato cargado

Y al crear un nuevo contenedor se usa el mismo

docker run -d --name db --mount type=bind,source='/home/ubuntu/dockerdata',target='/data/db' mongo 5)dockerrun−d−−namedb−−mounttype=bind,source= 
′
 /home/ubuntu/dockerdata 
′
 ,target= 
′
 /data/db 
′
 mongo5) docker run -d --name ubuntu_test ubuntu tail -f /dev/null 6) docker exec -it ubuntu_test bash 7) En el contendedor, se crea el directorio “test”, al salir del contenedor para copiar un archivo dentro del contenedor:dockerexec−itubuntu 
t
​
 estbash7)Enelcontendedor,secreaeldirectorio“test”,alsalirdelcontenedorparacopiarunarchivodentrodelcontenedor: docker cp test.txt ubuntu_test:test 8) Copiar desde el contenedor a la máquina anfitrión: $ docker cp ubuntu_test:test [carpeta local]

19) Imagenes:
$ docker image ls (ver las imágenes que tengo localmente)
$ docker pull ubuntu:20.04 (bajo la imagen de ubuntu con una versión específica)

$ mkdir imagenes (creo un directorio en mi máquina)

$ cd imagenes (entro al directorio)

$ touch hola.txt (creo un archivo txt y dentro ingreso la palabra 'hola')

$ touch Dockerfile (creo un Dockerfile)

$ vi Dockerfile (abro el Dockerfile con editor de textos 'vi')

##Contenido del Dockerfile##

FROM ubuntu:20.04
COPY /hola.txt /
RUN cat /hola.txt

##fin##

$ docker build -t ubuntu:latest . (creo una imagen con el contexto de build <directorio>)
$ docker run -it ubuntu:latest (corro el contenedor con la nueva imagen)

$ docker login (me logueo en docker hub)

$ docker tag ubuntu:latest miusuario/ubuntu:latest (cambio el tag para poder subirla a mi docker hub)

$ docker push miusuario/ubuntu:latest (publico la imagen a mi docker hub)
La importancia de entender el sistema de capas consiste en la optimización de la construcción del contenedor para reducir espacio ya que cada comando en el dockerfile crea una capa extra de código en la imagen.

Con docker commit se crea una nueva imagen con una capa adicional que modifica la capa base.

- Ejemplo: crear una nueva imagen a partir de la imagen de Ubuntu.

docker pull ubuntu

docker images

docker run -it cf0f3ca922e0 bin/bash

(modificar el contenedor: Ej apt-get install nmap)

docker commit deddd39fa163 ubuntu-nmap

$ docker history ubuntu:ubuntu2 (ver la info de como se construyó cada capa)

$ dive ubuntu:ubuntu2 (ver la info de la imagen con el programa dive)

20) Redes
Ejecutar los siguientes comandos:

$ docker network ls (listar las redes)
$ docker network create --attachable test_red (crear la red)
$ docker inspect test_red (ver definición de la red creada)
$ docker run -d --name db mongo (creo el contenedor)
$ docker network connect test_red db (conecto el contenedor “db” a la red “test_red”)
$ docker run -d --name app -p 3000:3000 --env MONGO_URL=mongodb://db:27017/test ubuntu (corro el contenedor “app” y le paso una variable)
$ docker network connect test_red app (conecto el contenedor “app” a la red “test_red”)
Homework
En el M3 se trabajó con con conjunto de datos que simulaban una empresa de venta de productos, deberás tomar ese mismo proceso de ETL y realizarlo con las herramientas Big Data que se verán en este módulo. Para esto, se provee de un entorno integrador: https://github.com/soyHenry/DS-M4-Herramientas_Big_Data

Verifica dentro de la práctica integradora, cuáles son las imágenes que se utilizan, y qué volúmenes, y cómo se podría persisitir todo lo que se vaya trabajando dentro de los contenedores.