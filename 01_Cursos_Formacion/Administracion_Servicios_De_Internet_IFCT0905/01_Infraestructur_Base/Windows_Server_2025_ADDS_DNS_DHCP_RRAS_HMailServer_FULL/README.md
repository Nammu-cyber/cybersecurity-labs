# Windows Server 2025: Active Directory, DNS, DHCP, RRAS, SMB y hMailServer

> Laboratorio documentado paso a paso en entorno controlado con Windows Server y cliente Windows. Este README reproduce el flujo completo del documento original para poder subirlo a GitHub como write-up técnico.

## Índice

- [Objetivo del laboratorio](#objetivo-del-laboratorio)
- [Entorno de laboratorio](#entorno-de-laboratorio)
- [Configuración de interfaces de red](#configuracion-de-interfaces-de-red)
- [Promover a dominio y unir máquinas](#promover-a-dominio-y-unir-maquinas)
- [Administración de Active Directory](#administracion-de-active-directory)
- [Crear recursos compartidos SMB](#crear-recursos-compartidos-smb)
- [Enrutamiento RRAS y NAT para acceso a Internet](#enrutamiento-rras-y-nat-para-acceso-a-internet)
- [Servidor DNS - Domain Name System](#servidor-dns---domain-name-system)
- [DHCP - Dynamic Host Configuration Protocol](#dhcp---dynamic-host-configuration-protocol)
- [hMailServer - Servidor de correo](#hmailserver---servidor-de-correo)
- [Conclusiones](#conclusiones)
- [Disclaimer](#disclaimer)

## Objetivo del laboratorio

Montar una infraestructura base con Windows Server que incluya controlador de dominio, unión de cliente al dominio, administración de usuarios y grupos, recursos compartidos SMB, salida a Internet mediante RRAS/NAT, resolución DNS directa e inversa, DHCP y un servidor de correo interno con hMailServer y Thunderbird.

## Entorno de laboratorio

| Elemento | Configuración |
|---|---|
| Servidor | Windows Server 2025 |
| Cliente | Windows 11 |
| Dominio | `curso.lan` |
| IP servidor | `192.168.10.1` |
| IP cliente inicial | `192.168.10.11` |
| Rango DHCP | `192.168.10.50 - 192.168.10.70` |
| Servicios | AD DS, DNS, DHCP, SMB, RRAS/NAT, hMailServer, Thunderbird, SSL/TLS |

---


## Configuración de interfaces de red

En el Servidor:

IP 192.168.10.1

![Evidencia 001](img/001-evidencia.png)

En el Cliente:

IP 192.168.10.11

![Evidencia 002](img/002-evidencia.png)

Comprobamos con ipconfig en el cmd que nos sale la configuración correcta tanto en el Servidor como en el equipo Cliente.

![Evidencia 003](img/003-evidencia.png)

![Evidencia 004](img/004-evidencia.png)

Configuramos una regla en el firewall del Servidor que se llame PING con en protocolo ICMPv4, para poder hacer ping entre máquinas.


## Promover a dominio y unir máquinas

En el panel de la izquierda seleccionamos “Servidor local”, clicamos en el nombre de equipo y le damos a “Cambiar”.

![Evidencia 005](img/005-evidencia.png)

Nos saldrá una advertencia, la seleccionamos y se nos abrirá el “Asistente para configuración de Servicios de dominio de Active Directory”, seleccionamos “Agregar un nuevo bosque” y le ponemos el nombre de dominio que queramos, en este caso se llamará curso.lan.

![Evidencia 006](img/006-evidencia.png)

Nos dará un error, le daremos a siguiente y proseguimos.

![Evidencia 007](img/007-evidencia.png)

Aquí podemos ver el script que nos ayudaría a configurarlo por comandos.

![Evidencia 008](img/008-evidencia.png)

Ahora reiniciamos el servidor y nos aparecerá el nombre de dominio asignado.

![Evidencia 009](img/009-evidencia.png)

Para que las máquinas Clientes puedan resolver el nombre de dominio tenemos que agregarles al “Servidor DNS preferido” la IP del Servidor 192.168.10.1

![Evidencia 010](img/010-evidencia.png)

Ahora al hacer ping desde la máquina cliente al nombre de dominio asignado al servidor, éste le responderá, y tendremos la configuración correcta:

```text
ping curso.lan
```
![Evidencia 011](img/011-evidencia.png)

Uniremos la máquina cliente dentro de la red interna al servidor, buscamos “Obtener acceso a trabajo o escuela”, seleccionamos “Conectar”, luego en “Unirse a un dominio”, ponemos el nombre de dominio que hemos creado y “Siguiente”.

![Evidencia 012](img/012-evidencia.png)

Ponemos las credenciales del Servidor y seleccionamos “Aceptar”.

![Evidencia 013](img/013-evidencia.png)

Nos saldrá “Agregar cuenta”, y en “Tipo de cuenta” ponemos “Administrador” y le damos a “Siguiente”.

![Evidencia 014](img/014-evidencia.png)

Ya no usaremos mas el usuario Administrador por que lo vamos a deshabilitar, sólo nos sirve para vincular los equipos al servidor.

![Evidencia 015](img/015-evidencia.png)


## Administración de Active Directory

Vamos a crear un usuario administrador y deshabilitaremos el usuario Administrador por defecto.

En “Herramientas” seleccionamos “Usuarios y equipos de Active Directory”. En el panel de la izquierda seleccionamos “curso.lan”, “Users” y clicamos con el botón derecho en el usuario Administrador y seleccionamos “Copiar”.

![Evidencia 016](img/016-evidencia.png)

Le pondremos el nombre de “curso”, y en nombre de inicio de sesión también “curso”, al hacerlo lo demás se completa solo.

![Evidencia 017](img/017-evidencia.png)

Ahora nos saldrá el usuario que hemos copiado.

![Evidencia 018](img/018-evidencia.png)

Iniciamos sesión con el usuario curso que tiene todos los permisos heredados al haberlo copiado del usuario Administrador.

![Evidencia 019](img/019-evidencia.png)

Si nos vamos al mismo lugar donde estaban lo usuarios, podremos clicar con el botón derecho en el usuario Administrador y seleccionamos “Deshabilitar cuenta”.

![Evidencia 020](img/020-evidencia.png)

Creamos unidades organizativas.

En “Herramientas” seleccionamos “Usuarios y equipos de Active Directory”, clicamos con el botón derecho sobre “curso.lan”, seleccionamos “Nuevo”, “Unidad organizativa”.

![Evidencia 021](img/021-evidencia.png)

Le ponemos el nombre de DEPARTAMENTOS ya que vamos a crear departamentos dentro de ella y dejamos seleccionado de opción de “Proteger contenedor contra…”.

![Evidencia 022](img/022-evidencia.png)

Creamos dentro de DEPARTAMENTOS de la misma manera que hemos hecho antes. Botón derecho sobre DEPARTAMENTOS y creamos una a una las unidades organizativas INFORMATICA y COMERCIAL.

![Evidencia 023](img/023-evidencia.png)

Creamos usuarios, botón derecho sobre el departamento que queramos, “Nuevo” y “Usuario”.

![Evidencia 024](img/024-evidencia.png)

Ponemos el nombre del nuevo usuario así tal y como está y le damos a “Siguiente”.

![Evidencia 025](img/025-evidencia.png)

Nos quedará cuando terminemos de esta manera:

![Evidencia 026](img/026-evidencia.png)

Creamos los grupos dentro de los departamentos, botón derecho en la parte de debajo de los usuarios dentro del departamento que queramos, “Nuevo” y “Grupo”.

![Evidencia 027](img/027-evidencia.png)

Le ponemos el nombre “informática”, (yo al hacerlo rápido lo escribí como informáticca), no hay problema con ello, y le damos a “Aceptar”.

![Evidencia 028](img/028-evidencia.png)

Añadimos al grupo los usuarios creados. Seleccionamos el usuario que queramos, botón derecho, “Propiedades”, “Miembro de”, “Agregar”, ponemos el nombre del grupo y le damos a “Comprobar nombres”, así se autocompletará solo o nos dejará mirar los grupos de hay con ese nombre. Le damos a “Aceptar” y “Aplicar”.

![Evidencia 029](img/029-evidencia.png)

Lo comprobamos dentro del grupo seleccionando sus propiedades y dentro a “Miembros”.

![Evidencia 030](img/030-evidencia.png)

Le podemos dar permisos al grupo informática como administradores de la misma manera que a los usuarios.

Ahora probamos a iniciar sesión con los usuarios.

También podemos mover a los usuarios entre grupos.

![Evidencia 031](img/031-evidencia.png)


## Crear recursos compartidos SMB

Protocolo SMB (Server Message Block).

Seleccionamos en el panel de la izquierda “Servicios de archivos y de almacenamiento” luego “Recursos compartidos” y dentro con el botón derecho seleccionamos “Nuevo recurso compartido”.

![Evidencia 032](img/032-evidencia.png)

Seleccionamos “Rápido”

![Evidencia 033](img/033-evidencia.png)

Seleccionamos “Ruta de acceso personalizada” y la configuramos de esta manera.

![Evidencia 034](img/034-evidencia.png)

“Nueva carpeta” dentro de (C:), creamos una llamada DEPARTAMENTOS y dentro de ella otra llamada INFORMATICA.

![Evidencia 035](img/035-evidencia.png)

Aquí podemos ver la ruta del recurso compartido que tendremos que poner más a delante en el Explorador de archivos ( \\DC-CURSO-01\INFORMATICA ) dentro de la máquina Cliente.

![Evidencia 036](img/036-evidencia.png)

Aquí podríamos Cifrar la carpeta compartida con contraseña para mayor seguridad, pero en este caso no lo haremos.

![Evidencia 037](img/037-evidencia.png)

Ahora especificamos los permisos.

![Evidencia 038](img/038-evidencia.png)

Deshabilitamos herencia y seleccionamos la primera opción, así nos dejará quitar y agregar los permisos.

![Evidencia 039](img/039-evidencia.png)

Quitamos todas menos al Administrador y agregamos sólo el grupo informática en la opción de “Agregar”.

![Evidencia 040](img/040-evidencia.png)

Cuando estemos dentro de “Agregar” le damos a “Seleccionar una entidad de seguridad”, y hacemos el mismo procedimiento de buscar el grupo.

![Evidencia 041](img/041-evidencia.png)

Seleccionamos “Control total” y “Aceptar”.

![Evidencia 042](img/042-evidencia.png)

Por último, le damos en Aplicar y Crear.

![Evidencia 043](img/043-evidencia.png)

![Evidencia 044](img/044-evidencia.png)

Después de crearla nos aparecerá el nuevo recurso compartido.

![Evidencia 045](img/045-evidencia.png)

Ahora en Windows 11 podemos ver con los usuarios lo recursos compartidos de esta manera:

En el explorador de archivo ponemos la ruta que nos han dado:

```text
\\DC-CURSO-01\informatica
```
![Evidencia 046](img/046-evidencia.png)

Podemos crear carpetas dentro de los recursos compartidos y darles permisos según nos convenga o necesitemos, de la misma manera que hemos hecho hasta ahora agregando y quitando permisos de usuarios y grupos.

![Evidencia 047](img/047-evidencia.png)


## Enrutamiento RRAS y NAT para acceso a Internet

Seleccionamos “Administrar”, “Agregar roles y características” y en “Roles del servidor” seleccionamos “Acceso remoto”.

![Evidencia 048](img/048-evidencia.png)

En “Servicios de rol” seleccionamos “Enrutamiento” y le damos en “Agregar características”, se seleccionará por si solo la opción de “DirectAccess y VPN (RAS)”, lo dejamos seleccionado y siguiente.

![Evidencia 049](img/049-evidencia.png)

![Evidencia 050](img/050-evidencia.png)

Por último, le daremos a instalar y esperaremos a que se complete.

![Evidencia 051](img/051-evidencia.png)

Ahora configuramos y habilitamos, Seleccionamos “Herramientas” y “Enrutamiento y acceso remoto”.

![Evidencia 052](img/052-evidencia.png)

Botón derecho sobre DC-CURSO-01 y le damos a “Configurar y habilitar Enrutamiento y acceso remoto”.

![Evidencia 053](img/053-evidencia.png)

Seleccionamos la red WAN que en este caso es la “Ethernet”, que es la red que nos dará conexión a internet y le damos a “Siguiente”.

![Evidencia 054](img/054-evidencia.png)

Una vez hecho, si nos vamos a NAT nos aparecerán las redes configuradas.

![Evidencia 055](img/055-evidencia.png)

En la máquina Cliente configuraremos la “Puerta de enlace predeterminada” con la IP del servidor “192.168.10.1”.

![Evidencia 056](img/056-evidencia.png)

Si ahora hacemos ping a google.es veremos como se transmiten los paquetes.

![Evidencia 057](img/057-evidencia.png)

En el Servidor si le damos a recargar, nos aparecerán ahora los paquetes que se han trasmitido.

![Evidencia 058](img/058-evidencia.png)

Si seleccionamos “Ethernet” con botón derecho y le damos a “Mostrar Asignaciones…” podemos ver en detalle lo que hemos hecho con el comando ping en la maquina Cliente.

![Evidencia 059](img/059-evidencia.png)


## Servidor DNS - Domain Name System

Configuraremos las zonas de DNS para que se traduzca correctamente el nombre de dominio.


### Zona directa

En DNS en el panel izquierdo, botón derecho sobre el Servidor seleccionamos “Administrador de DNS”.

![Evidencia 060](img/060-evidencia.png)

En el Servidor, botón derecho sobre “curso.lan” dentro de “Zonas de búsqueda directa” y seleccionamos “Nuevo Host”. Ponemos el nombre que queramos y la IP el Servidor.

![Evidencia 061](img/061-evidencia.png)

Nos saldrá tal que así.

![Evidencia 062](img/062-evidencia.png)

En la carpeta “curso.lan”, hacemos clic derecho sobre ella y seleccionamos “Crear Nuevo Dominio”, luego podemos crearle un nuevo host llamado smr o lo que queramos poner.

![Evidencia 063](img/063-evidencia.png)


### Zona inversa

Dentro de “Zonas de búsqueda inversa”, creamos una “Zona nueva…”.

![Evidencia 064](img/064-evidencia.png)

Tipo de zona, seleccionamos “Zona principal” y “Siguiente”.

![Evidencia 065](img/065-evidencia.png)

En “Ámbito de replicación de zona de Active Directory” dejamos seleccionado la segunda opción.

![Evidencia 066](img/066-evidencia.png)

En “Nombre de la zona de búsqueda inversa” seleccionamos la IPv4.

![Evidencia 067](img/067-evidencia.png)

Ponemos la Id del servidor para la zona inversa de esta manera.

![Evidencia 068](img/068-evidencia.png)

En “Actualización dinámica” dejamos seleccionado la opción de “Permitir solo actualizaciones dinámicas seguras…”.

![Evidencia 069](img/069-evidencia.png)

Añadimos PTR (puntero). Dentro de “Zonas de búsqueda directa” en “curso.lan” tenemos el host del servidor con la IP del servidor, le damos a editar y seleccionamos “Actualizar registro del puntero (PTR) asociado” y aplicamos.

![Evidencia 070](img/070-evidencia.png)

Ahora dentro de “Zonas de búsqueda inversa” nos aparecerá el PTR nuevo, si no aparece esperamos o le damos a recargar.

![Evidencia 071](img/071-evidencia.png)

Si hacemos un nslookup en la máquina Cliente veremos como la IP del servidor nos resuelve el nombre.

![Evidencia 072](img/072-evidencia.png)

Ahora veremos los reenviadores. Con el botón derecho en el Servidor le damos a “Propiedades” y nos movemos a la pestaña “Reenviadores”, aquí podemos ver los que nos salen.

![Evidencia 073](img/073-evidencia.png)

Podemos eliminarlos clicando en ellos y pulsando el botón “Eliminar”, luego en “Aceptar” y “Aplicar”, ahora no nos resolverá los nombres de dominio que busquemos, sólo los que tenemos en caché.

![Evidencia 074](img/074-evidencia.png)

Podemos añadirle en los reenviadores la IP 8.8.8.8 que es la de Google para que nos resuelva los nombres de dominio. También podemos crear Nuevo dominio como por ejemplo youtube.es y dentro de éste un Nuevo Host al que le daremos la ip del Servidor 192.168.10.1, así cuando un trabajador quiera visitar youtube con la máquina cliente, se redirigirá automáticamente a nuestro servidor impidiendo visitar nombres de dominio que no queramos.

![Evidencia 075](img/075-evidencia.png)

Si queremos que resuelva nombres de dominio solo para nuestra red interna y no dejar que otros de fuera de la red puedan acceder, en “Propiedades” del servidor pestaña “Interfaces” seleccionamos la opción “Solo las siguientes direcciones IP:”, luego quitamos todas menos la IP del Servidor “192.168.10.1”. Aplicamos y aceptamos.

![Evidencia 076](img/076-evidencia.png)


## DHCP - Dynamic Host Configuration Protocol

Vamos a hacer que el servidor asigne parámetros de red a los Clientes de la red interna, asignando automáticamente direcciones IP a esas máquinas.

Arriba seleccionamos “Administrar” Roles y características, en la pestaña “Roles de servidor” seleccionamos “Servidor DHCP”, agregamos y “Siguiente”.

![Evidencia 077](img/077-evidencia.png)

Una vez instalado, en la advertencia le damos a “Completar configuración de DHCP”.

![Evidencia 078](img/078-evidencia.png)

Lo dejamos tal que así, y “Confirmar”.

![Evidencia 079](img/079-evidencia.png)

Ahora nos metemos en “DHCP”, botón derecho sobre el servidor y “Administrar DHCP”.

![Evidencia 080](img/080-evidencia.png)

En “IPv4” le damos a botón derecho y “Ámbito nuevo…”.

![Evidencia 081](img/081-evidencia.png)

Le ponemos el nombre de “REDINTERNA” y le damos a “Siguiente”.

![Evidencia 082](img/082-evidencia.png)

En “Intervalos de direcciones IP”, le ponemos el rango desde la 50 hasta la 70 que es el rango que va a tener para repartir direcciones IP.

![Evidencia 083](img/083-evidencia.png)

En “Configurar opciones DHCP”, seleccionamos “Configurar estas opciones ahora”.

![Evidencia 084](img/084-evidencia.png)

En “Enrutador” ponemos la IP 192.168.10.1 que es la del servidor y le damos a “Agregar”, para que haga de puerta de enlace predeterminada.

![Evidencia 085](img/085-evidencia.png)

Aquí lo dejamos así como esta en la captura.

![Evidencia 086](img/086-evidencia.png)

En “Activar ámbito”, seleccionamos “Activar este ámbito ahora”.

![Evidencia 087](img/087-evidencia.png)

Ahora podemos ver en nuevo ámbito creado.

![Evidencia 088](img/088-evidencia.png)

Ahora para comprobar que lo hemos hecho correctamente, en la máquina Cliente, nos vamos a conexiones de red y en las propiedades de IPv4 lo ponemos en automática, para que el servidor sea el que asigne la IP a ésta máquina de forma automática dentro del intervalo desde la 50 a la 70 como habíamos configurado.

![Evidencia 089](img/089-evidencia.png)

En el Servidor si recargamos podemos ver como dentro de DHCP tenemos la máquina Cliente con la IP 192.168.10.50 asignada por el DHCP.

![Evidencia 090](img/090-evidencia.png)

Ahora dentro del DNS en la Zona de búsqueda directa, podemos comprobar como donde ponía antes la IP que termina en 11 ahora tiene la 50, si no sale así, salimos y volvemos a entrar para que se recargue y se actualice para poder visualizarlo correctamente.

![Evidencia 091](img/091-evidencia.png)


## hMailServer - Servidor de correo

Servidor de correo, con protocolos SMTP e IMAP y POP3.

![Evidencia 092](img/092-evidencia.png)

Mientras se va descargando nos vamos al buscador y nos vamos a ir descargando hmailserver y mozilla thunderbird en https://ftp.mozilla.org/pub/thunderbird/releases la versión 128.4.0

![Evidencia 093](img/093-evidencia.png)

![Evidencia 094](img/094-evidencia.png)

![Evidencia 095](img/095-evidencia.png)

Cuando se haya instalado la nueva característica y no antes, podemos proceder a instalar los ejecutables de Thunderbird y hMailServer.

En hMailServer le damos a todo a Siguiente, aceptamos términos y condiciones y ponemos contraseña para administrar todo.

![Evidencia 096](img/096-evidencia.png)

![Evidencia 097](img/097-evidencia.png)

![Evidencia 098](img/098-evidencia.png)

![Evidencia 099](img/099-evidencia.png)

![Evidencia 100](img/100-evidencia.png)

![Evidencia 101](img/101-evidencia.png)

Ahora nos centramos en hMailServer para configurar el dominio que vamos a utilizar y crear los usuarios.

En la siguiente ventana si no aparece “localhost”, tenemos que añadírselo, seleccionamos “Add”, ponemos “localhost”, y el nombre del Usuario Administrador de hMailServer. Luego pulsamos en “Save” y “Connect”.

![Evidencia 102](img/102-evidencia.png)

Una vez dentro de hMailServer añadimos el dominio de nuestro servidor, seleccionamos la opción “habilitar” y luego en “Save”.

![Evidencia 103](img/103-evidencia.png)

Una vez dentro nos movemos a “Settings”, “Anti-spam”, “Logging”, habilitamos todo y le damos a “Save”.

![Evidencia 104](img/104-evidencia.png)

Luego pulsamos en “Show Logs”, se abrirá el explorador de archivos, lo minimizamos para utilizarlo posteriormente.

![Evidencia 105](img/105-evidencia.png)

Creamos usuarios de prueba para configurar todo correctamente, nos movemos hacia “Domains”, “curso.lan”, “Accounts”, y en la pestaña “General”, añadimos nuevo usuario tal y como se ve en la captura.

![Evidencia 106](img/106-evidencia.png)

Añadimos sólo “Reglas de entrada” en el firewall del Servidor, de los puertos de los servicios que vamos a utilizar, podríamos añadir reglas de salida si quisiéramos entrar al servidor fuera de nuestra red, paro ahora solo queremos utilizarlo en nuestra red interna.

Marcamos “Puerto”.

![Evidencia 107](img/107-evidencia.png)

Marcamos “TCP”, y especificamos los puertos.

![Evidencia 108](img/108-evidencia.png)

Marcamos “Permitir la conexión”.

![Evidencia 109](img/109-evidencia.png)

Aquí lo dejamos todo marcado, pero podríamos marcar lo que necesitásemos en un momento dado.

![Evidencia 110](img/110-evidencia.png)

Le ponemos el nombre asociado a la regla.

![Evidencia 111](img/111-evidencia.png)

Y quedaría así.

![Evidencia 112](img/112-evidencia.png)

Ahora en thunderbird en el engranaje podemos añadir usuarios.

![Evidencia 113](img/113-evidencia.png)

Marcamos la opción IMAP que es la que queremos en este caso y seleccionamos “Hecho”.

![Evidencia 114](img/114-evidencia.png)

Se abrirá esta ventana, marcamos “Entiendo los riesgos”, y le damos a “Confirmar”.

![Evidencia 115](img/115-evidencia.png)

Ahora deshabilitamos POP3 ya que no lo vamos a utilizar. Nos movemos a “Settings”, “Protocols”, y dentro desmarcamos la opción “POP3” y le damos a “Save”.

![Evidencia 116](img/116-evidencia.png)

Después de deshabilitarlo tenemos que reiniciar hMailServer ya que a veces cuando deshabilitas un servicio puede llegar a dar problemas en el Servidor. Presionamos la tecla “Windows”, escribimos “Servicios”, y dentro de “Servicios(locales)”, bajamos hasta “hMailServer”, pulsamos botón derecho sobre él y le damos a “Reiniciar”.

![Evidencia 117](img/117-evidencia.png)

Ahora si comprobamos en el explorador de archivos lo que habíamos minimizado, deberían aparecer dos archivos, éstos son los logs que es donde nos aparece toda la información, si algún día tenemos problemas podemos verlo aquí directamente.

![Evidencia 118](img/118-evidencia.png)

Ahora instalamos win64openssl, nos pedirá que instalemos C++ si no lo teníamos ya antes, aceptamos los términos y finalizamos después de instalar C++.

![Evidencia 119](img/119-evidencia.png)

![Evidencia 120](img/120-evidencia.png)

Ahora implementamos SSL/TLS. Abrimos cmd como administrador, nos movemos a la dirección “C:\\Program Files\OpenSSL-Win64\bin”, y en esta ruta ponemos los siguientes comandos:

```text
openssl.exe genrsa -out curso.lan.key 2048
openssl.exe req -new -nodes -key curso.lan.key -out curso.lan.csr
```
Aquí ponemos lo necesario y el nombre de dominio en “Common Name”.

```text
openssl.exe x509 -req -days 2048 -in curso.lan.csr -signkey curso.lan.key -out curso.lan.cert
```
![Evidencia 121](img/121-evidencia.png)

![Evidencia 122](img/122-evidencia.png)

![Evidencia 123](img/123-evidencia.png)

Lo configuramos en hMailServer. Copiamos la ruta del cmd en la que estábamos y la copiamos en el explorador de archivos, una vez dentro podemos ver los tres archivos que hemos creado con OpenSSL.

![Evidencia 124](img/124-evidencia.png)

Seleccionamos los tres archivos y los cortamos para sacarlos de ahí.

![Evidencia 125](img/125-evidencia.png)

Nos movemos en el explorador de archivos a la ruta “C:\\Program Files(x86)\hMailServer\”, creamos dentro una carpeta llamada “SSL” y pegamos dentro de ella los tres archivos.

![Evidencia 126](img/126-evidencia.png)

Ahora en hMailServer nos movemos a “Settings”, “Advanced”, “SSL-certificates”, ponemos el nombre de dominio del Servidor. En “Certificate file” ponemos el archivo curso.lan.cert, y en “Private key file”, ponemos el archivo curso.lan.key

![Evidencia 127](img/127-evidencia.png)

---

## Conclusiones

Este laboratorio deja documentada una infraestructura Windows Server funcional con servicios esenciales de administración de red: dominio, usuarios, grupos, recursos compartidos, DNS, DHCP, enrutamiento/NAT y correo interno. La práctica permite entender cómo se integran los servicios base de una red corporativa en un entorno controlado.

## Disclaimer

Laboratorio realizado exclusivamente en entorno local y controlado con fines formativos. No debe aplicarse sobre sistemas de terceros ni redes reales sin autorización expresa.