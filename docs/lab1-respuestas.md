# 1º ¿Cuál es la diferencia entre Working Directory, Staging Area y Local Repository? Da un ejemplo de un archivo pasando por las tres.
Working directory es el espacio de trabajo, en este sitio se modifican los archivos y sus cambios son detectados. La Staging Area, es paralela al Working directory, un archivo puede estar en ambos sitios al mismo tiempo. 
Puesto que la Staging Area, representa el listado de archivos seleccionados para el siguiente commit. No todos los archivos de un Working directory modificados están obligados a ir a la Staging Area. 
Y el Local Repository es la representación del repositorio en el local de la maquina. Esta representación no tiene porque ser fiel a lo que  hay en remoto, pudiendo tener ramas que aún no hayan sido subidas y al mismo tiempo, 
ramas que fueron subidas, merengadas y luego borradas para liberar espacio. Teniendo de este modo un histórico de trabajo.
Como ejemplo, puedo crear un archivo script.sql en el Working Directory, luego añadirlo al Stating Area con git add script.sql y por último git commit lo añadiría al repositorio local.
# 2º Si modificas un archivo pero no haces git add, ¿aparece ese cambio en tu próximo commit? Explica por qué. 
No, puesto que no has añadido a la Staging Area el archivo en cuestión.
# 3º ¿Por qué git status no mostraba las carpetas vacías que creaste en la Parte C? ¿Qué truco usamos para solucionarlo? 
No mostraba las carpetas, porque Git no almacena carpetas vacías. Git almacena ficheros con la ruta de la carpeta a la que pertenece, pero no la carpeta en si misma.
Para solucionar este problema, se crea un archivo de nombre .gitkeep. Este archivo no tiene contenido y es exclusivamente para poder “almacenar” en Git una carpeta.
# 4º Explica con tus palabras qué es HEAD 
El HEAD es el puntero a la rama donde me encuentro trabajando en ese momento. Por tanto apunta tanto a la rama como al “commit” más reciente de dicha rama.
# 5º ¿Qué diferencia hay entre crear una branch con git switch -c y crear una carpeta nueva con mkdir? ¿Cómo lo comprobamos en la Parte G? 
Mkdir le dice al sistema operativo que debe crear una carpeta en una ubicación de disco. Git switch -c no crea carpeta alguna.  Para comprobar esto usamos: ls -la.
# 6º Durante el conflicto de la Parte H, ¿qué representaba el contenido entre <<<<<<< HEAD y =======? ¿Y entre ======= y >>>>>>>? 
El contenido entre HEAD y ===== es el contenido que tenía en mi rama actual y ===== >>>>> es el contenido de la rama a unir.
# 7º ¿Por qué NO se debe hacer git commit --amend sobre un commit que ya se subió con git push? 
Porque se reescribe el historial en local. Si ese historial local fue previamente subido al remoto, podemos generar una distorsión en los historiales.
Como comentario y en mi experiencia, sale más rentable no hacer nunca un amend. Los problemas que puede generar son muy muy dolorosos, yo personalmente prefiero hacer un segundo commit que corrija el anterior.
# 8º Si borras por accidente la carpeta .git de tu proyecto, ¿qué se pierde exactamente? ¿Se pierde también el código fuente que está en el disco? 
Se pierde la configuración de Git para ese repositorio, ramas y commits locales. El código no se pierde, puesto que son archivos totalmente paralelos. La carpeta .git es exclusivamente necesaria para Git y su funcionamiento.
# 9º Explica con tus propias palabras la diferencia entre Git y GitHub, sin usar la palabra "nube". 
Git es el software que maneja el repositorio local. GitHub es la plataforma online que nos permite usar Git y añade herramientas para trabajar con equipos como Pull Requests.
# 10º ¿Por qué no se debe subir un archivo .env con contraseñas reales a un repositorio, aunque el repositorio sea privado? 
Simplemente por seguridad. Lo ideal es que en entornos corporativos las contraseñas esten securializadas fuera del repositorio. En mi trabajo, dado que usamos Azure, usamos su Key Vault para este fin.
# 11º Un compañero te dice: "hice push y ahora GitHub me rechaza el segundo push con 'non-fastforward'". ¿Qué ha ocurrido probablemente y qué comando ejecutarías primero? 
Lo que ha ocurrido es que hay cambios en remoto que mi compañero no se descargo y por tanto no se han verificado. El primer comando que debe usar mi compañero es un git pull.
# 12 º¿Qué tipo de Conventional Commit (feat, fix, docs, test…) usarías para: añadir un índice de rendimiento a una tabla, corregir una restricción mal definida, y actualizar el README? 
Dividiría el commit en 3 diferentes. Enviar un único commit para 3 cambios de ambito diferente es una mala práctica. Siendo los commits convencionales:
- Añadir un índice de rendimiento a una tabla: perf
- Corregir una restricción mal definida: fix
- Actualizar el README: docs
