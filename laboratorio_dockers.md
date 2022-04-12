
# Laboratorio contenedores:

Todos los recursos necesarios están en [github](http://github.com/evtsrc/)

<br/><br/>
# DOCKER (40%)
## APACHE:
- Crea un Dockerfile que tenga de imagen base, la última versión [NÚMERO] oficial de apache (The Apache HTTP Server Project).
- añade el archivo de configuración que se os proporciona en [lab_2022_apache](https://github.com/evtsrc/lab_2022_apache).
- define como directorio de trabajo la ruta `/usr/local/apache2/conf/`.
- no te olvides de añadir el metadato mantainer con tu e-mail.
- y de copiar el Dockerfile en la ruta `/tmp`.

## POSTGRES:
- Crea un Dockerfile que tenga de imagen base, la última versión [NÚMERO] oficial de postgres.
- inserta el script proporcionado en [lab_2022_postgres](https://github.com/evtsrc/lab_2022_postgres) al directorio correspondiente para que se ejecute automáticamente.
- Cambia el puerto por defecto de Postgresql por el `6666` usando el comando CMD y el flag `-p`.  
- no te olvides de añadir el metadato mantainer con tu e-mail.
- y de copiar el Dockerfile en la ruta `/tmp`.

## PYTHON:
- Crea un Dockerfile que tenga de imagen base, la versión 3 de la imagen oficial de Python.
- define con ENTRYPOINT el proceso principal de la imagen.
- instala las dependencias del proyecto.
- inserta el código proporcionado en [lab_2022_python](https://github.com/evtsrc/lab_2022_python) .
- utiliza CMD para indicar el fichero python que quieres ejecutar.
- no te olvides de añadir el metadato mantainer con tu e-mail.
- y de copiar el Dockerfile en la ruta `/tmp`.
<br/><br/>
---------------
### Graba con asciinema los siguientes pasos: 
```
asciinema rec {USER}-docker.cat
```
1. Lista todas las imágenes que tengas en local.
2. Lista TODOS los contenedores.
3. Elimina todos los contenedores que están parados.
4. Ejecuta el comando que elimina todas las imagenes que están a "none".
<br/><br/>

**Para verificar que se han grabado correctamente los pasos:** 
```
asciinema play {USER}-docker.cat
```

<br/><br/>
# DOCKER-COMPOSE  (60%)
## Crea un fichero de configuración de docker-compose con los siguientes servicios:
- `{USER}_apache`: 
    - define el atributo para construir la imagen a partir del Dockerfile definido en el apartado anterior.
	- la imagen resultante deberá tener el siguiente nombre: `localhost:5000/{USER}_apache:0.1`.
	- publica el puerto 8080 y mapealo al puerto 80 del contenedor.
	- define la variable de entorno END_POINT con el valor `http://{PYTHON_SERVICE_NAME}:{PYTHON_SERVICE_PORT}`.
    - proporciona el fichero index.html a traves de un volumen mapeando a la ruta `/usr/local/apache2/htdocs/`.
	- este servicio dependerá del servicio de python.
- `{USER}_postgres`: 
    - define el atributo para construir la imagen apartir del Dockerfile definido en el apartado anterior.
	- la imagen resultante deberá tener el siguiente nombre:  `localhost:5000/{USER}_bd:0.1`.
	- expon el puerto en el que se levanta la BD.
	- define las siguientes variables de entorno:
		- POSTGRES_DB=labbdd
		- POSTGRES_USER={USER}
		- POSTGRES_PASSWORD={USER}
    - guarda los datos de la BD en un volumen.
- `{USER}_python`: 
    - define el atributo para construir la imagen apartir del Dockerfile definido en el apartado anterior.
	- la imagen resultante deberá tener el siguiente nombre: `localhost:5000/{USER}_py:0.1`.
	- expón el puerto en el que se levanta el proceso python.
	- define las siguientes variables de entorno con los valores necesarios:
		- POSTGRES_HOST=
		- POSTGRES_PORT=
		- POSTGRES_DB=
		- POSTGRES_USER=
		- POSTGRES_PASSWORD=
    - este servicio dependerá del servicio de postgres.
<br/><br/>
---------------
### Graba con asciinema los siguientes pasos: 

```
asciinema rec {USER}-docker-compose.cat
```
1. Construye las imágenes sin arrancar los contenedores.
2. Lista las imágenes usando el comando propio de docker-compose.
3. Arranca los contenedores en modo detached.
4. Valida y muestra el contenido de `docker-compose.yaml` usando el comando propio de docker-compose.
5. Muestra solo las trazas de la BD.
6. Muestra el contenido del Dockerfile de python 
	```
	docker-compose exec {USER}_python cat /tmp/Dockefile
	```
7. Comprueba que se ha desplegado la aplicación y carga el index.html desde el volumen. 
	```
	wget -qO- {URL}
	```
8. Comprueba que se ha desplegado la aplicación completa y los tres servicios están correctamente referenciados y enlazados. Usa el comando 
	```
	wget -qO- {URL}/app/accounts
	```
9. Inserta un nuevo valor en la BD
	```
	docker-compose exec {USER}_postgres psql -v ON_ERROR_STOP=1 -U {USERNAME} -d {DATABASE} -p {PORT}

	INSERT INTO accounts (username, password, email) VALUES ('user3', 'user3', 'user3@mail.com');

	exit
	```
10. Para y elimina todos los contenedores de este proyecto.
11. Vuelve a levantar los contenedores y verifica que el valor insertado perdura. 
12. Escala el servicio `{USER}_python` a 2.
13. Saca el listado de contenedores con el comando propio de docker-compose.
14. Para y elimina todos los contenedores de este proyecto.
<br/><br/>

**Para verificar que se han grabado correctamente los pasos:** 
```
asciinema play {USER}-docker-compose.cat
```

<br/><br/>
# ENTREGA:

Un archivo comprimido con la siguiente estructura

``` sh
├── apache
│   └── Dockerfile
│   └── index.html
│   └── my-httpd.conf
├── postgres
│   └── Dockerfile
├── python
│   └── Dockerfile
├── {USER}-docker.cat
├── {USER}-docker-compose.cat
└── docker-compose.yaml
```

**La corrección se hará sobre el archivo comprimido entregado, no se descargará nada más para validar el funcionamiento.**
<br/><br/>
