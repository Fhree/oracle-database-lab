### Docker

**1. ¿Qué diferencia hay entre una imagen y un contenedor? Usa como ejemplo lo que hiciste en los ejercicios G2 y G4.**
La diferencia es que una imagen es una plantilla de solo lectura que contiene todo lo necesario para montar la aplicación (so, librerías, los programas,...). Es el paquete necesario de archivos para su instalación y ejecución. El contenedor es la instancia en ejecución de la imagen. Por tanto, es un espacio donde se pueden añadir diferentes programas para que se ejecuten de forma aislada al sistema anfitrión, permitiendo su portabilidad. Sin ir más lejos, yo tengo montado en mi sistema un contenedor con 3 contenedores dentro que trabajan conjuntamente. Concretamente hablo de una base de datos de PostgreDB, un backend en .Net y una web en Angular con nginx para su publicación.

**2. En el Ejercicio G5 el archivo nota.txt desapareció y en el G6 no. Explica por qué.**
Porque en el ejercicio G5 el archivo había sido creado dentro del contenedor y al borrar esté, el archivo se borra también. En el G6 se creó primero un volumen para el volcado de la información, por tanto el contenedor usaba el volumen como disco. Estos componentes son independientes el uno del otro, por tanto se pudo borrar el contenedor permitiendo mantener el volumen con la información.

**3. ¿Qué diferencia hay entre docker ps y docker ps -a, y qué significa STATUS = Exited (0)?**
La diferencia entre `docker ps` y `docker ps -a` es que `docker ps` muestra el listado de contenedores en ejecución, si no hubiera ninguno mostrará una lista vacía. En cambio, si añadimos el `-a` (all) estamos pidiendo el listado de contenedores, independientemente de su estado.
`STATUS = Exited` significa que el contenedor ya no está en ejecución y que terminó sin ningún error.

**4. En -p 8181:8181, ¿qué número corresponde a tu equipo y cuál al contenedor? ¿Qué pasaría con -p 80:8080 en el ejercicio de nginx?**
El primer 8181 corresponde al equipo anfitrión, el segundo 8181 corresponde al contenedor de Docker. 
Con `-p 80:8080` estás indicando que nginx está escuchando en el puerto 8080 del contenedor, es un puerto interno para el SO base del contenedor. Además, al indicar el 80 estas diciendo que nosotros debemos conectarnos con el puerto 80 para conectar con nginx.
Hay que matizar que Docker realiza una transformación de redes entre contenedores, actúa como un router con la red doméstica y el mundo de internet.

**5. ¿Por qué un contenedor de Oracle se queda en marcha y el de hello-world termina solo?**
El contenedor de hello-world termina automáticamente cuando termina la ejecución del proceso interno del contenedor (el hello-world), en cambio el contenedor de Oracle continua porque su proceso no ha terminado, está siempre escuchando nuevas peticiones.

**6. ¿Qué es el digest de una imagen y por qué lo registramos si ya sabemos que usamos :latest?**
Es el código identificador de la versión de la imagen del programa en cuestión. La registramos para asegurarnos que siempre se use la misma versión de la aplicación dado que `:latest` es solo una marca que va cambiando conforme se saquen nuevas versiones.

**7. ¿Qué comando borraría realmente los datos de Oracle? ¿Por qué docker rm oralab-26ai no lo hace?**
El comando sería `docker volume rm`.
`docker rm oralab-26ai` no borra los datos porque estos viven en el volumen de docker, no dentro del contenedor. `docker rm` borra el contenedor y lo que hubiera dentro del mismo.

---

### Git, organización y evidencia

**8. ¿Por qué este laboratorio se hace dentro del repositorio oracle-database-lab, con Issue, branch y Pull Request, en vez de en una carpeta aparte?**
Porque demuestra la forma de actuar en el mundo profesional además de que es una metodología muy extendida que permite asegurar la integridad del código y la resolución de los requerimientos.
Como apunte, en mi trabajo vamos con Azure DevOps, allí usamos User Storys cómo Issues a las que le asociamos la branch y la PR, solo que de una manera más intuitiva que la de GitHub, en mi opinión.

**9. ¿Qué diferencia hay entre source 00-config.sh y bash 00-config.sh? ¿Por qué usamos source?**
Bash produce un proceso hijo con sus respectivas variables de entorno que serán creadas y destruidas durante la vida del proceso hijo.
Source ejecuta el código dentro del proceso actual, por tanto las variables se mantienen y por eso lo usamos, para poder usar dichas variables en otros comandos.

**10. Explica cada parte del nombre 20260915T091230Z_02-docker.script.log.**
Es el estándar ISO 8601 para ordenación de archivos cronológicamente.
- 2026: año
- 09: mes
- 15: día
- T: separador de tiempo
- 09: hora
- 12: minutos
- 30: segundos
- Z: zona horaria zulu.

**11. ¿Para qué sirve .gitattributes y qué error evita?**
Sirve para indicar formatos o condiciones de los archivos con los que vamos a trabajar. De este modo nos evitamos errores entre SO por ejemplo, el CRLF de Windows y LF de Linux para los saltos de línea.

**12. ¿Por qué en este Pull Request elegimos Create a merge commit en lugar de Squash and merge?**
Porque contiene muchos commits intermedios, y es buena práctica realizar un commit merge donde se indique que se ha producido la integración de una rama.

---

### Seguridad

**13. Describe las cuatro capas de la estrategia de contraseñas (Parte D) y qué pasaría si te saltas la primera.**
- 1º gitIgnore: se le indica a Git que archivos debe evitar registrar. De este modo evitamos introducirlo en un commit y que quede registrada en el historial de Git algún dato que no debiera ser publicado.
- 2º plantilla versionada: realizamos una plantilla de la configuración de entornos, pero nunca subimos la configuración real a git.
- 3º config real: es el archivo en el que se basa la plantilla de la segunda capa. En este archivo es donde vive la información real de acceso a la BD.
- 4º lectura de contraseñas: se debe automatizar la lectura de contraseñas para evitar la introducción a mano, por tanto evitando así el conocimiento de la contraseña por parte del desarrollador.
En caso de saltarte la 1º, se provoca que las credenciales puedan subirse al repositorio de Git y que queden registradas. Por tanto, publicadas en el histórico y que no puedan ser borradas. Creo que para solucionar este problema habría que rehacer todo el conjunto de credenciales y contraseñas para evitar dejar la mínima traza.

**14. ¿Por qué no escribimos la contraseña directamente en el comando docker run, aunque el script no se suba a Git?**
Para evitar que quede escrita en el historial de la terminal de comandos del SO.

**15. Si descubres tu contraseña en un commit ya publicado, ¿basta con borrarla en un commit nuevo? ¿Qué debes hacer?**
No, no basta. Se debe crear un nuevo conjunto de credenciales.

---

### Oracle y herramientas

**16. ¿Por qué no usamos SPOOL ni @archivo.sql con sqlplus dentro del contenedor, y qué hicimos en su lugar?**
No se utilizan porque cada entorno utiliza sus propias herramientas. Si se mezclan estas herramientas con los entornos da lugar a problemas en tiempo de ejecución de difícil diagnóstico. En su lugar, instalamos una versión en cada SO, uno en el Windows anfitrión y otro dentro del Ubuntu WSL.

**17. ¿Qué hace WHENEVER SQLERROR EXIT SQL.SQLCODE al inicio de V000 y V001, y qué pasaría sin esa línea?**
Indica que en caso de error se aborte la ejecución indicando el código de error. Si no estuviera la línea y se produce un error, la ejecución de la migración continuará provocando que una migración se haya completado con errores. Esto provoca un entorno de ejecución donde no es fiable, dado que ha habido errores y no se sabe donde se produjo. 

**18. ¿Qué es una migración y por qué V000 y V001 no se deben editar una vez aplicadas?**
Una migración es una foto de un instante de un sistema. Por ejemplo, aplicado a SQL, una migración hace una foto del estado en ese instante de la base de datos. No se deben editar porque las migraciones se ejecutan en orden secuencial en función de su nombre, una edición puede provocar fallos que rompan la cadena de migraciones.

**19. ¿Por qué en SQL Developer se usa el servicio FREEPDB1 y no FREE ni un SID?**
FREE es el contenedor raíz que gestiona la memoria y metadatos. FREEPDB1 es la base de datos donde viven los datos.

**20. ¿Qué aporta SQLcl frente a SQL*Plus, y por qué un DBA debe dominar ambas?**
SQL*Plus es el cliente básico y viene instalado con todos los servidores Oracle. SQLcl, es solo un cliente para facilitar el uso de Oracle y permitir la integración con REST.

---

### Entorno de trabajo

**21. ¿Por qué el curso pasa de Git Bash a Ubuntu en WSL 2? Da al menos dos problemas concretos de Git Bash que desaparecen en Ubuntu.**
Porque Git Bash es un emulador de la terminal en Windows, Ubuntu en WSL 2 es un SO Ubuntu completo corriendo dentro de Windows, groso modo es una máquina virtual dentro de Windows.
Ejemplos de problemas:
- Transforma automáticamente las rutas de los directorios al romper el mapeo de las rutas absolutas.
- Carece de un gestor nativo de paquetes.

**22. ¿Por qué clonamos el repositorio en ~/oracle-database-lab y no trabajamos sobre la carpeta de Windows (/mnt/c/...)? ¿Y por qué recomendamos bash frente a zsh para los scripts del curso?**
Porque Ubuntu WSL 2 tiene su propio sistema de ficheros, y dado que estamos dentro de un Ubuntu, no hace falta montar el sistema de Windows para llegar a estos datos dando la vuelta para llegar al sistema propio de Ubuntu.
Se recomienda Bash por ser el estándar universal, de este modo te aseguras que va a funcionar cuando se integren en un proyecto que adopte el CI/CD.