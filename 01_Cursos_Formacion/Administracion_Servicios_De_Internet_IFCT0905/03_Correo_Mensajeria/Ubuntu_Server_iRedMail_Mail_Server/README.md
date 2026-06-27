# iRedMail en Ubuntu Server

**Área:** Correo y webmail

## Objetivo

Montar un servidor de correo local para el dominio curso.local con acceso web, administración de usuarios y resolución de errores habituales durante la instalación.

## Tecnologías

- Ubuntu Server 22.04
- iRedMail 1.8.0
- Nginx
- MariaDB
- Roundcube
- iRedAdmin
- Fail2ban
- Netdata

## Desarrollo del laboratorio

### Contexto inicial

Servidor con hostname `servidor.curso.local`, IP interna `192.168.1.8`, dominio de correo `curso.local`, iRedMail `1.8.0` y Ubuntu Server `22.04`.

Objetivo: crear un servidor de correo local para usuarios tipo `alumno1@curso.local` y `alumno2@curso.local`, accesible desde navegador en la red interna.

### Problema inicial: sistema operativo no compatible

Al ejecutar `sudo bash iRedMail.sh`, el instalador mostró un error indicando que la versión del sistema operativo no era compatible.

Se comprobó que Ubuntu Server 22.04 debería ser compatible con iRedMail 1.8.0, pero el instalador no detectaba correctamente la versión.

### Solución al bloqueo del instalador

Buscar el mensaje de error:

```bash
grep -r "Release version of the operating system" .
```

El resultado apuntó a `conf/global`.

Editar el archivo:

```bash
nano conf/global
```

Localizar la línea `exit 255` asociada al bloqueo y comentarla:

```bash
#exit 255
```

Ejecutar de nuevo:

```bash
sudo bash iRedMail.sh
```

Resultado esperado: acceso a la pantalla azul del instalador.

### Instalación guiada de iRedMail

Pantalla inicial: seleccionar `Yes / Next`.

Directorio de almacenamiento de correos: dejar `/var/vmail`.

Servidor web preferido: seleccionar `Nginx`.

Backend/base de datos: seleccionar `MariaDB`.

Contraseña de MariaDB: introducir una contraseña segura y anotarla fuera del repositorio.

Primer dominio de correo: introducir `curso.local`, no `servidor.curso.local`.

Administrador del dominio: se crea `postmaster@curso.local`.

Componentes opcionales recomendados: `Roundcube`, `iRedAdmin`, `Fail2ban` y `Netdata`.

Confirmar instalación con `y` cuando aparezca `Continue? [y/N]`.

### Final de instalación

Aceptar reglas de firewall proporcionadas por iRedMail:

```text
Use firewall rules provided by iRedMail? -> y
Restart firewall now? -> y
```

Reiniciar el sistema:

```bash
sudo reboot
```

Archivo importante generado:

```bash
cat /home/alex/iRedMail-1.8.0/iRedMail.tips
```

Este archivo contiene URLs, usuarios, contraseñas generadas, rutas y servicios. No debe subirse a GitHub.

### Conflicto Apache / Nginx

Síntoma: al acceder a `https://192.168.1.8/` aparecía la página por defecto de Apache2.

Causa: Apache estaba instalado y activo, ocupando los puertos web que debía usar Nginx.

Solución:

```bash
sudo systemctl stop apache2
sudo systemctl disable apache2
sudo systemctl restart nginx
```

### Accesos correctos

Un `403 Forbidden` en `https://192.168.1.8/` no implica fallo. Las rutas correctas son:

```text
https://192.168.1.8/mail/       -> Roundcube
https://192.168.1.8/iredadmin/  -> Panel iRedAdmin
```

### Diagnóstico de 502 Bad Gateway en Roundcube

Síntoma: acceso a `/mail/` con `502 Bad Gateway` de Nginx.

Comprobar PHP-FPM:

```bash
sudo dpkg -l | grep -E "php.*fpm"
systemctl list-units --type=service | grep -i php
ls -l /run/php/
```

Resultado esperado: `php8.1-fpm.service` activo y socket `/run/php/php8.1-fpm.sock`.

Revisar logs:

```bash
sudo tail -n 30 /var/log/nginx/error.log
```

Error clave detectado:

```text
connect() failed while connecting to upstream
upstream: "fastcgi://127.0.0.1:9999"
```

Interpretación: Nginx intentaba conectar con PHP en `127.0.0.1:9999`, pero PHP estaba realmente en el socket `/run/php/php8.1-fpm.sock`.

### Corrección de fastcgi_pass

Buscar configuración:

```bash
sudo grep -R "fastcgi_pass" /etc/nginx/templates/
```

Editar:

```bash
sudo nano /etc/nginx/templates/fastcgi_php.tmpl
```

Sustituir:

```nginx
fastcgi_pass php_workers;
```

por:

```nginx
fastcgi_pass unix:/run/php/php8.1-fpm.sock;
```

Aplicar cambios:

```bash
sudo systemctl restart php8.1-fpm
sudo systemctl restart nginx
```

### Flujo final validado

Acceder a `https://192.168.1.8/iredadmin/`.

Crear usuarios de correo.

Acceder a `https://192.168.1.8/mail/`.

Enviar correos entre cuentas locales.

## Notas de seguridad

- No subir `iRedMail.tips` ni contraseñas reales al repositorio.

## Conclusión

Este laboratorio documenta una configuración reproducible en entorno local controlado y deja una base técnica reutilizable para futuras prácticas de administración de servicios.
