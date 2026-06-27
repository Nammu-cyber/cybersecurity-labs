# Windows Server 2025 - AD DS, DNS y unión de cliente al dominio

## Descripción

Actividad de creación de entorno cliente-servidor con Windows Server 2025 y Windows 11 Pro, incluyendo AD DS, dominio local, usuarios, grupos, DNS y unión del cliente al dominio.

## Tecnologías / comandos trabajados

- Windows Server 2025
- Windows 11 Pro
- Active Directory
- DNS
- Dominio local
- Usuarios y grupos

## Contexto

Laboratorio realizado en entorno controlado como parte del bloque de Seguridad Informática IFCT0109. El contenido se ha normalizado para GitHub, eliminando referencias personales innecesarias y manteniendo las evidencias visuales del trabajo realizado.

## Procedimiento y evidencias

Nammu

## Actividad 5 · Creación del servidor, preparación del cliente y unión al dominio

#### Enunciado

En esta actividad vais a montar la base de un pequeño entorno cliente-servidor de empresa utilizando dos máquinas virtuales:

una máquina con Windows Server 2025

una máquina con Windows 11 Pro

El objetivo es preparar el servidor, convertirlo en controlador de dominio, crear varios usuarios de prueba y unir el equipo cliente Windows 11 al dominio para comprobar que el entorno funciona correctamente.

El dominio de trabajo será (ejemplo) :

novislab.local

#### Objetivo de la actividad

Al finalizar esta actividad debéis haber conseguido:

arrancar y preparar una máquina virtual con Windows Server 2025

arrancar y preparar una máquina virtual con Windows 11 Pro

configurar el servidor con nombre e IP fija

Window Server

![Evidencia 001](img/001-evidencia.png)

Windows 10

![Evidencia 002](img/002-evidencia.png)

instalar Active Directory Domain Services

![Evidencia 003](img/003-evidencia.png)

promocionar el servidor a controlador de dominio

crear el dominio novislab.local

![Evidencia 004](img/004-evidencia.png)

crear 6 o 8 usuarios del dominio

![Evidencia 005](img/005-evidencia.png)

crear grupos y asignar los usuarios a los grupos

![Evidencia 006](img/006-evidencia.png)

configurar el cliente Windows 11 para que use el servidor como DNS

![Evidencia 007](img/007-evidencia.png)

unir el cliente Windows 11 al dominio

![Evidencia 008](img/008-evidencia.png)

iniciar sesión en el cliente con un usuario del dominio

![Evidencia 009](img/009-evidencia.png)

![Evidencia 010](img/010-evidencia.png)

![Evidencia 011](img/011-evidencia.png)

![Evidencia 012](img/012-evidencia.png)

## Actividad 5B (parte 2) en parejas · Integración en dominio y comprobación de permisos

#### Enunciado

En esta actividad trabajaréis por parejas para simular un entorno real de red cliente-servidor en una empresa.

Cada pareja estará formada por:

Alumno A → hará de administrador del servidor

Alumno B → hará de cliente del dominio

Nota: Una vez acabéis la primera parte intercambiar los roles de cliente y administrador del servidor

El alumno que hace de administrador será el responsable de tener preparado su Windows Server, con su dominio, usuarios, grupos y recursos compartidos.El alumno que hace de cliente deberá crear o utilizar su máquina Windows 11, unirla al dominio de su compañero e iniciar sesión con un usuario del dominio con permisos limitados.

El objetivo es que comprobéis en la práctica cómo funcionan:

la unión de un equipo al dominio

el inicio de sesión con usuarios del dominio

los permisos de acceso a carpetas y recursos

las restricciones según grupos y asignación de permisos

La idea es simular que un usuario de una empresa intenta acceder a distintos recursos del servidor y comprobar a cuáles puede entrar y a cuáles no según los permisos configurados.

#### Objetivo de la actividad

Al finalizar esta actividad debéis haber conseguido:

crear o preparar una máquina cliente con Windows 11 Pro

configurar la red del cliente para trabajar con el servidor del compañero

unir el cliente al dominio del compañero

iniciar sesión con un usuario del dominio con permisos limitados

comprobar el acceso a carpetas compartidas y otros recursos

verificar qué recursos están permitidos y cuáles están restringidos

documentar las pruebas realizadas y los resultados obtenidos

Organización de la actividad

Alumno A · Administrador del servidor

Debe encargarse de:

tener el servidor funcionando como controlador de dominio

disponer de usuarios y grupos creados (le dirá al compañero su usuario y su contraseña)

tener carpetas compartidas configuradas

asignar permisos de acceso a los usuarios o grupos

indicar al compañero qué usuario del dominio puede utilizar para la práctica

Alumno B · Cliente del dominio

Debe encargarse de:

preparar su máquina Windows 11

configurar la red y el DNS para apuntar al servidor del compañero

![Evidencia 013](img/013-evidencia.png)

unir el equipo al dominio del compañero

![Evidencia 014](img/014-evidencia.png)

iniciar sesión con el usuario facilitado

![Evidencia 015](img/015-evidencia.png)

![Evidencia 016](img/016-evidencia.png)

realizar las pruebas de acceso a los recursos compartidos

![Evidencia 017](img/017-evidencia.png)

anotar los resultados obtenidos

Importante

Después de terminar la primera ronda, podéis intercambiar roles para que ambos practiquéis tanto la parte de servidor como la parte de cliente.

Desarrollo de la actividad

## Parte 1 · Preparación del entorno

El alumno A arranca su Windows Server y comprueba que el dominio está operativo.

El alumno B arranca su Windows 11 Pro.

El alumno B configura el cliente para que use como DNS la IP del servidor del compañero.

Ambos comprueban conectividad entre cliente y servidor.

## Parte 2 · Unión del cliente al dominio

El alumno B une su equipo Windows 11 al dominio del compañero.

Reinicia el equipo si es necesario.

Inicia sesión con un usuario del dominio proporcionado por el alumno A.

## Parte 3 · Pruebas de acceso

El alumno A indica qué carpetas, recursos o servicios debería poder usar ese usuario.

El alumno B realiza pruebas de acceso a:

carpeta común

carpetas departamentales

unidades de red, si existen

acceso remoto, si está permitido

otros recursos que el compañero haya configurado

El alumno B debe comprobar y anotar:

a qué recursos puede acceder

a qué recursos no puede acceder

si puede solo leer o también modificar

si el comportamiento coincide con los permisos asignados

Ejemplos de comprobaciones

Podéis hacer pruebas como estas:

entrar en la carpeta COMUN

![Evidencia 018](img/018-evidencia.png)

intentar entrar en ADMINISTRACION

![Evidencia 019](img/019-evidencia.png)

intentar entrar en COMERCIAL

![Evidencia 020](img/020-evidencia.png)

intentar entrar en DIRECCION

![Evidencia 021](img/021-evidencia.png)

crear un archivo de prueba en una carpeta permitida

![Evidencia 022](img/022-evidencia.png)

intentar crear un archivo en una carpeta no permitida

comprobar si aparecen unidades de red mapeadas

comprobar si el usuario puede o no usar RDP, si se ha configurado

![Evidencia 023](img/023-evidencia.png)

## Conclusión

Esta práctica refuerza competencias de administración, reconocimiento y análisis técnico en entornos Windows/Linux, documentando comandos, configuración y evidencias de ejecución en laboratorio.
