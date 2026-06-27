# Windows CMD - Práctica global de niveles 1, 2 y 3

## Descripción

Actividad global de reconocimiento y análisis básico del equipo desde CMD integrando comandos de los tres niveles trabajados.

## Tecnologías / comandos trabajados

- Windows 11
- CMD
- systeminfo
- ipconfig
- netstat
- tasklist
- tree
- findstr

## Contexto

Laboratorio realizado en entorno controlado como parte del bloque de Seguridad Informática IFCT0109. El contenido se ha normalizado para GitHub, eliminando referencias personales innecesarias y manteniendo las evidencias visuales del trabajo realizado.

## Procedimiento y evidencias

### Ejercicio 4: Consola CMD

Integración de comandos de Nivel 1, Nivel 2 y Nivel 3

#### Objetivo de la práctica

En esta práctica vais a poner en uso comandos de los tres niveles trabajados en CMD.

Esta práctica está planteada como una actividad global de reconocimiento y análisis básico del equipo desde CMD, usando comandos reales de trabajo técnico.

Ayudante

Tenéis el ayudante: <enlace_al_asistente>

Forma de entrega

Debéis entregar un documento con:

el comando utilizado en cada apartado

una captura de pantalla donde se vea claramente el resultado

una breve explicación de lo que habéis obtenido

Importante

La captura debe verse completa o lo suficientemente clara.

No vale solo escribir el comando: hay que mostrar el resultado.

Si en algún ejercicio aparece información diferente según el equipo, no pasa nada. Lo importante es que sepáis localizarla e interpretarla.

Estas normas de entrega se aplican a toda la práctica. No hace falta repetirlas en cada ejercicio.

PARTE 1 · Primer reconocimiento del equipo (Nivel 1)

Objetivo de esta parte

En esta parte debéis trabajar al menos 10 comandos del Nivel 1 para realizar un reconocimiento básico del equipo y moveros con soltura en CMD.

Comandos mínimos que deben aparecer en esta parte

cls

date

time

help

comando /?

cd

dir

tree

mkdir

rmdir

type

copy

hostname

ver

systeminfo

ipconfig

ping

1. Limpiar la consola y consultar fecha y hora

#### Tarea

Limpia la consola.

![Evidencia 001](img/001-evidencia.png)

Muestra la fecha del sistema.

![Evidencia 002](img/002-evidencia.png)

Muestra la hora del sistema.

![Evidencia 003](img/003-evidencia.png)

#### Debes entregar

captura del comando para limpiar la consola

captura donde se vea la fecha

captura donde se vea la hora

breve explicación de para qué sirve cada uno

2. Consultar ayuda básica

#### Tarea

Muestra la ayuda del comando ping.

![Evidencia 004](img/004-evidencia.png)

Muestra la ayuda del comando dir usando /?.

![Evidencia 005](img/005-evidencia.png)

Explica qué utilidad tiene consultar la ayuda antes de ejecutar un comando desconocido.

Consultar que parámetros tiene y como podemos conseguir la información que necesitamos.

3. Comprobar carpeta actual y moverse por el sistema

#### Tarea

Muestra la carpeta actual.

![Evidencia 006](img/006-evidencia.png)

Entra en una carpeta de tu perfil de usuario.

Sube un nivel.

Entra en C:\Windows.

Vuelve a una carpeta de trabajo.

![Evidencia 007](img/007-evidencia.png)

Explica qué hace cd y qué significa cambiar de ruta.

Es poder moverte entre carpetas y cambiar de ruta es entrar en las carpetas padres y sus respectivos subdirectorios

4. Listar y visualizar estructura de carpetas

#### Tarea

Muestra el contenido de una carpeta con dir.

![Evidencia 008](img/008-evidencia.png)

Repite con dir /b.

![Evidencia 009](img/009-evidencia.png)

Repite con dir /p.

![Evidencia 010](img/010-evidencia.png)

Muestra la estructura con tree.

![Evidencia 011](img/011-evidencia.png)

Repite con tree /f.

![Evidencia 012](img/012-evidencia.png)

Compara brevemente dir y tree.

Tree te muestra el árbol de carpetas y subcarpetas a demás de los archivos, y dir sólo te muestra lo que contiene el directorio don de estas

5. Crear una estructura de carpetas para la práctica

#### Tarea

Crea la siguiente estructura:

PracticaCMD ├── Nivel1 ├── Nivel2 └── Nivel3

![Evidencia 013](img/013-evidencia.png)

Después elimina una carpeta vacía de prueba y vuelve a crearla.

![Evidencia 014](img/014-evidencia.png)

6. Crear y copiar un archivo de texto

#### Tarea

Crea un archivo de texto llamado datos.txt.

![Evidencia 015](img/015-evidencia.png)

Muéstralo con type.

![Evidencia 016](img/016-evidencia.png)

Haz una copia con otro nombre.

![Evidencia 017](img/017-evidencia.png)

Copia ese archivo dentro de una de las carpetas creadas antes.

![Evidencia 018](img/018-evidencia.png)

Comprueba con dir que existen ambos archivos.

![Evidencia 019](img/019-evidencia.png)

7. Consultar información del equipo

#### Tarea

Muestra el nombre del equipo.

![Evidencia 020](img/020-evidencia.png)

Muestra la versión de Windows.

![Evidencia 021](img/021-evidencia.png)

Ejecuta systeminfo.

Localiza en la salida:

sistema operativo

![Evidencia 022](img/022-evidencia.png)

memoria RAM

![Evidencia 023](img/023-evidencia.png)

fecha de instalación

![Evidencia 024](img/024-evidencia.png)

grupo de trabajo o dominio

![Evidencia 025](img/025-evidencia.png)

8. Consultar configuración de red y conectividad

#### Tarea

Ejecuta ipconfig.

![Evidencia 026](img/026-evidencia.png)

Ejecuta ipconfig /all.

Localiza:

IPv4

![Evidencia 027](img/027-evidencia.png)

máscara de subred

![Evidencia 028](img/028-evidencia.png)

puerta de enlace

![Evidencia 029](img/029-evidencia.png)

DNS

![Evidencia 030](img/030-evidencia.png)

Haz ping a:

la puerta de enlace

![Evidencia 031](img/031-evidencia.png)

8.8.8.8

![Evidencia 032](img/032-evidencia.png)

google.com

![Evidencia 033](img/033-evidencia.png)

Explica qué comprueba cada uno de esos ping.

La conectividad entre las máquinas

PARTE 2 · Enumeración y análisis intermedio (Nivel 2)

Objetivo de esta parte

En esta parte debéis trabajar al menos 10 comandos del Nivel 2 para hacer una enumeración más técnica del sistema y de la red.

Comandos mínimos que deben aparecer en esta parte

whoami

whoami /all

whoami /groups

whoami /priv

getmac

getmac /v

arp -a

nslookup

tracert

pathping

tasklist

tasklist /v

taskkill

findstr

where

more

9. Consultar el usuario actual

#### Tarea

Muestra el usuario actual.

![Evidencia 034](img/034-evidencia.png)

Muestra toda la información del usuario.

![Evidencia 035](img/035-evidencia.png)

Consulta sus grupos.

![Evidencia 036](img/036-evidencia.png)

Consulta sus privilegios.

![Evidencia 037](img/037-evidencia.png)

Explica qué información nueva aporta cada variante.

10. Consultar MAC y tabla ARP

#### Tarea

Ejecuta getmac.

![Evidencia 038](img/038-evidencia.png)

Ejecuta getmac /v.

![Evidencia 039](img/039-evidencia.png)

Ejecuta arp -a.

![Evidencia 040](img/040-evidencia.png)

Localiza una IP y su MAC asociada.

![Evidencia 041](img/041-evidencia.png)

Explica brevemente la relación entre IP y MAC.

La mac es física y esta siempre asociada a una IP de la máquina

11. Resolver dominios y analizar rutas

#### Tarea

Ejecuta nslookup google.com.

![Evidencia 042](img/042-evidencia.png)

Ejecuta nslookup openai.com.

![Evidencia 043](img/043-evidencia.png)

Ejecuta tracert google.com.

![Evidencia 044](img/044-evidencia.png)

Ejecuta pathping google.com.

![Evidencia 045](img/045-evidencia.png)

Explica qué diferencia hay entre ping, tracert y pathping.

12. Consultar procesos

#### Tarea

Ejecuta tasklist.

![Evidencia 046](img/046-evidencia.png)

Ejecuta tasklist /v.

![Evidencia 047](img/047-evidencia.png)

Localiza un proceso conocido y anota su PID.

![Evidencia 048](img/048-evidencia.png)

Si el profesor lo indica, abre el Bloc de notas y ciérralo desde CMD con taskkill.

![Evidencia 049](img/049-evidencia.png)

![Evidencia 050](img/050-evidencia.png)

Explica cuándo usarías tasklist y cuándo taskkill.

Tasklist para ver los procesos que hay en el sistema y takkill para cerrar ese proceso

Importante

No cierres procesos del sistema.

13. Filtrar y localizar información

#### Tarea

Filtra archivos .txt con findstr.

Usa where para localizar notepad.

![Evidencia 051](img/051-evidencia.png)

Usa more para paginar la salida de un comando largo.

Explica para qué sirve cada uno de esos comandos.

14. Búsqueda guiada de información en salidas

#### Tarea

Usa tasklist combinado con findstr para localizar un proceso concreto.

Usa dir combinado con findstr para localizar archivos de texto.

![Evidencia 052](img/052-evidencia.png)

Usa un comando largo combinado con more.

![Evidencia 053](img/053-evidencia.png)

Explica qué ventaja tiene filtrar la salida.

Que puedes ver solo la información que necesitas y asi no llenas la consola de información y pierdes menos tiempo

PARTE 3 · Análisis técnico y administración (Nivel 3)

Objetivo de esta parte

En esta parte debéis trabajar al menos 10 comandos del Nivel 3 para consultar información más avanzada sobre conexiones, servicios, rutas, permisos, tareas y usuarios.

Comandos mínimos que deben aparecer en esta parte

netstat

netstat -a

netstat -ano

netsh interface show interface

netsh wlan show profiles

netsh advfirewall show allprofiles

route print

sc query

sc query state= all

schtasks /query

schtasks /query /v

icacls

attrib

fc

net user

15. Consultar conexiones y puertos

#### Tarea

Ejecuta netstat.

![Evidencia 054](img/054-evidencia.png)

Ejecuta netstat -a.

![Evidencia 055](img/055-evidencia.png)

Ejecuta netstat -ano.

![Evidencia 056](img/056-evidencia.png)

Localiza:

una conexión establecida

![Evidencia 057](img/057-evidencia.png)

un puerto en escucha

![Evidencia 058](img/058-evidencia.png)

un PID asociado

![Evidencia 059](img/059-evidencia.png)

Explica qué diferencia observas entre las tres salidas.

16. Relacionar conexiones con procesos

#### Tarea

Toma un PID de netstat -ano.

![Evidencia 060](img/060-evidencia.png)

Busca el proceso correspondiente usando tasklist.

![Evidencia 061](img/061-evidencia.png)

Relaciona conexión y proceso.

Explica la relación encontrada.

17. Consultar red avanzada

#### Tarea

Ejecuta netsh interface show interface.

![Evidencia 062](img/062-evidencia.png)

Ejecuta netsh wlan show profiles.

![Evidencia 063](img/063-evidencia.png)

Ejecuta netsh advfirewall show allprofiles.

![Evidencia 064](img/064-evidencia.png)

Ejecuta route print.

![Evidencia 065](img/065-evidencia.png)

Explica qué información aporta cada uno.

18. Consultar servicios y tareas programadas

#### Tarea

Ejecuta sc query.

![Evidencia 066](img/066-evidencia.png)

Ejecuta sc query state= all.

![Evidencia 067](img/067-evidencia.png)

Ejecuta schtasks /query.

![Evidencia 068](img/068-evidencia.png)

Ejecuta schtasks /query /v.

![Evidencia 069](img/069-evidencia.png)

Elige un servicio y una tarea programada y explica qué has encontrado.

19. Consultar permisos y atributos

#### Tarea

Ejecuta icacls sobre una carpeta de la práctica.

![Evidencia 070](img/070-evidencia.png)

Ejecuta icacls sobre un archivo de texto.

![Evidencia 071](img/071-evidencia.png)

Ejecuta attrib sobre los archivos de la práctica.

![Evidencia 072](img/072-evidencia.png)

Si el profesor lo indica, oculta un archivo de prueba y vuelve a mostrarlo.

Explica qué te muestran los permisos y qué te muestran los atributos.

20. Comparar archivos y consultar usuarios

#### Tarea

Crea dos archivos de texto parecidos, con una pequeña diferencia.

![Evidencia 073](img/073-evidencia.png)

Compáralos con fc

![Evidencia 074](img/074-evidencia.png)

Ejecuta net user.

![Evidencia 075](img/075-evidencia.png)

Consulta un usuario concreto con net user nombre_usuario.

![Evidencia 076](img/076-evidencia.png)

Explica qué diferencia hay entre listar todos los usuarios y consultar uno concreto.

21. Revisión final de comandos avanzados

#### Tarea

Haz una tabla resumen donde indiques al menos 10 comandos de esta parte y expliques: 1. qué hace cada comando 2. qué información aporta 3. en qué situación lo usarías

PARTE 4 · Informe final

22. Informe técnico breve

#### Tarea

Con toda la información obtenida, realiza un pequeño informe final donde resumas:

Nombre del equipo

![Evidencia 077](img/077-evidencia.png)

Usuario actual

![Evidencia 078](img/078-evidencia.png)

IPv4 del equipo

![Evidencia 079](img/079-evidencia.png)

Una dirección MAC

![Evidencia 080](img/080-evidencia.png)

Una conexión de red y su PID

![Evidencia 081](img/081-evidencia.png)

El proceso asociado a esa conexión

![Evidencia 082](img/082-evidencia.png)

Un servicio del sistema

![Evidencia 083](img/083-evidencia.png)

Una tarea programada

![Evidencia 084](img/084-evidencia.png)

Un permiso detectado en una carpeta

![Evidencia 085](img/085-evidencia.png)

Una conclusión final sobre lo que has aprendido en la práctica

Mi conclusión es que cuanto mas profundo aprenda sobre los comandos y su utilidad a demás de poder concatenar comandos, mejor y mas rápido voy a poder sacar la información que necesite en cada momento

#### Debes entregar

texto resumen final

acompañado de las capturas más importantes

Importante

No hagáis esta práctica como una lista mecánica de comandos. La idea es que empecéis a ver CMD como una herramienta real de trabajo técnico.

Cuanto mejor entendáis lo que estáis viendo, más utilidad le sacaréis en administración de sistemas, análisis y seguridad informática.

## Conclusión

Esta práctica refuerza competencias de administración, reconocimiento y análisis técnico en entornos Windows/Linux, documentando comandos, configuración y evidencias de ejecución en laboratorio.
