# Preguntas de Comprobación - Laboratorio 2

### 1. ¿Por qué un Issue sin criterios de aceptación es un problema, aunque la descripción general parezca clara?
Porque carece de una definición objetiva de cuándo el trabajo está realmente "terminado" (Definition of Done). Una descripción general solo expresa una intención, mientras que los criterios de aceptación establecen una lista de comprobación verificable. Sin ellos, el programador no sabe cuándo parar y el revisor no tiene un estándar contra el que verificar si el Pull Request satisface la necesidad.

---

### 2. Explica la diferencia entre "Refs #N" y "Closes #N" en un mensaje de commit o en la descripción de un Pull Request.
* **`Refs #N`**: le dice a GitHub que debe referenciar la Pull Request o Commit con una Issue abierta (con número N). Esto sirve para tener trazabilidad durante el desarrollo.
* **`Closes #N`**: se indica como comando para GitHub. GitHub al leer ese comando entiende que debe cerrar la Issue con número N en caso de que la Pull Request haya sido completada e integrada.

---

### 3. ¿Qué ocurre exactamente si intentas hacer git push directamente sobre una branch main protegida? ¿Es un error tuyo o un fallo del sistema?
Git rechaza el push inmediatamente e informa de que la rama está protegida y debe hacerse por una pull request. 

Es un error del usuario al intentar realizar una acción que rompe las reglas establecidas.

---

### 4. Un compañero te dice: "he aprobado el PR sin mirar los archivos, total ya me fío". ¿Qué riesgo tiene esa forma de revisar?
Tiene demasiados riesgos. Los riesgos pueden ser de diferente gravedad, pero pueden ir desde bugs tontos donde se ha cambiado la palabra de un literal a un fallo del sistema que provoque la caída del mismo. Además, no habría forma de garantizar el cumplimiento de los acceptance criteria definidos.

---

### 5. Si el reviewer pide un cambio y tú ya habías hecho push de tu branch, ¿tienes que abrir un Pull Request nuevo? Explica qué ocurre técnicamente con el PR existente cuando haces un nuevo commit.
No, simplemente se sigue trabajando sobre esa rama sin ninguna diferencia para el entorno local del programador. La PR incluye todo los commits realizados en una rama para su integración con otra, dado que es una solicitud vinculada a la rama de origen.

---

### 6. Describe con tus palabras la diferencia entre Merge commit, Squash and merge y Rebase and merge. ¿Cuál usarías para una branch con commits "wip", "fix", "fix2", "ok ya"?
* **Merge commit**: une las dos ramas creando un commit adicional de integración. Ideal para ramas con muchos commits o largas.
* **Squash and merge**: une todos los commits en uno. Esto es recomendable para cambios pequeños y cuando nos interesa mantener el historial de la rama destino lo más limpio posible.
* **Rebase and merge**: integra en la rama destino cada uno de los commits realizados sobre la rama origen. Lo hace de forma secuencial y sin generar un commit de merge. Esto provoca historiales lineales.

Para una rama con ese tipo de commits usaría “squash and merge” por son commits que no aportan valor al historial.

---

### 7. ¿Por qué borrar una branch después del merge no elimina el trabajo realizado en ella?
Porque los registros quedan guardados en la rama destino.

---

### 8. ¿Qué información debería contener siempre la descripción de un Pull Request, como mínimo?
Debe estructurarse siguiendo una plantilla estándar con cuatro apartados clave:   
- **PDFSummary**: Una descripción clara que explique qué hace el cambio a alto nivel.   
- **PDFChanges**: Lista de los cambios técnicos y archivos clave modificados o añadidos. 
- **Testing**: Explicación de las pruebas realizadas para validar que funciona.   
- **PDFRelated Issue**: Referencia explícita al ticket que motivó el trabajo.  

---

### 9. Un reviewer escribe solo "esto está mal" como comentario. ¿Qué le falta a ese comentario para ser útil? Reescríbelo tú con un ejemplo inventado.
Al comentario le falta contexto e información.

Un ejemplo podría ser: “los datos de nombre y apellidos están intercambiados y se están usando mal. Esto provoca que no se pueda validar el código fiscal. Se recomienda revisar el correcto uso de dichos parámetros”.

---

### 10. ¿Qué diferencia hay entre que main esté protegida y que simplemente el equipo "se ponga de acuerdo" en no hacer push directo?
Si está protegida el sistema hace de escudo ante errores involuntarios. Si no está protegida. Es como he comentado en la pregunta 3º de este documento, el sistema de reglas de Git sirve para protegernos y respetar la metodología de trabajo establecida en un proyecto. Además, abre la puerta a hacer push simples directos a main generando problemas en el futuro.

---

### 11. Explica con un ejemplo propio la diferencia entre un comentario issue: (blocking) y uno nitpick: (if-minor) en formato Conventional Comments.
* **issue: (blocking)** señala un problema crítico, por tanto la PR no puede ser aprobada. 
  * Ejemplo: `issue (blocking): La consulta concatena la variable de entrada directamente sin parametrizar, crea vulnerabilidad de inyección SQL.`
* **issue: (if-minor)** señala un detalle menor, algo que no bloquee la PR.
  * Ejemplo: `nitpick (if-minor): Hay una línea vacía extra final del archivo CONTRIBUTING.md. Debería ser eliminada si es posible.`

---

### 12. Si tu próximo commit es feat!: cambia la firma de la función principal de la API, ¿qué tipo de versión SemVer se dispara y por qué?
feat! rompe la compatibilidad de versiones del código. El SemVer disparado podría ser debido a un incremento MAJOR para ir de 2.4.1 a 3.0.0.

---

### 13. ¿Por qué abrir un Draft PR desde el primer commit estructural puede ahorrar tiempo al equipo, aunque parezca más lento para el autor individual?
Porque aplica el principio de “Fail Fast” y permite que las conversaciones con los compañeros comiencen desde el inicio. Los compañeros pueden ir revisando y comentando como está el código antes de finalizar todos los cambios. Esto gana tiempo puesto que el equipo senior puede ir avisando de problemas y que sean resueltos de forma más simple.