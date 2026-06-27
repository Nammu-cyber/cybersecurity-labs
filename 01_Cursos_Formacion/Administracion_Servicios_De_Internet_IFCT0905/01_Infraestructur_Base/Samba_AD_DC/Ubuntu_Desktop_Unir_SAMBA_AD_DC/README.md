# Unir Ubuntu Desktop a un dominio Samba Active Directory

> Laboratorio práctico para integrar un equipo Ubuntu Desktop en un dominio Samba AD DC usando Kerberos, Winbind, NSS y PAM.

## Objetivo

Unir un cliente Ubuntu Desktop al dominio `curso.local`, autenticarse contra Samba Active Directory y permitir el inicio de sesión con cuentas de dominio.

Al finalizar, el cliente deberá:

- Resolver `curso.local` y `dc.curso.local`.
- Sincronizar hora con el controlador de dominio.
- Obtener tickets Kerberos.
- Unirse al dominio mediante `net ads join`.
- Resolver usuarios y grupos del dominio mediante Winbind.
- Crear automáticamente directorios home para usuarios de dominio.
- Permitir autenticación CLI y GUI con cuentas del dominio.

## Entorno de laboratorio

| Elemento | Valor |
|---|---|
| Cliente | Ubuntu Desktop |
| Hostname | `ud101` |
| Dominio | `curso.local` |
| Realm | `CURSO.LOCAL` |
| Workgroup | `CURSO` |
| Controlador de dominio | `dc.curso.local` |
| IP del DC | `192.168.1.8` |

## 1. Conexión y acceso inicial

Conectar por SSH al cliente si se administra remotamente:

```bash
ssh nombredeusuario@IP
```

Instalar SSH si no está disponible:

```bash
sudo apt-get install ssh
```

Comprobar servicio:

```bash
sudo systemctl status ssh
```

## 2. Configurar hostname del cliente

Cambiar hostname:

```bash
sudo hostnamectl set-hostname ud101
```

Comprobar FQDN:

```bash
hostname -f
```

## 3. Configurar resolución local

Editar `/etc/hosts`:

```bash
sudo nano /etc/hosts
```

Añadir:

```text
192.168.1.8     curso.local curso
192.168.1.8     dc.curso.local dc
```

Comprobar conectividad:

```bash
ping -c2 curso.local
```

## 4. Sincronización horaria

Kerberos es sensible a diferencias de hora entre cliente y controlador de dominio.

Instalar `ntpdate`:

```bash
sudo apt-get install ntpdate
```

Alternativa con `timedatectl`:

```bash
sudo timedatectl set-ntp true
timedatectl status
```

En clientes Windows se puede resincronizar con:

```powershell
w32tm /resync
```

Comprobar sincronización con el dominio:

```bash
sudo ntpdate -q curso.local
sudo ntpdate curso.local
```

## 5. Instalar paquetes necesarios

```bash
sudo apt-get install samba krb5-config krb5-user winbind libpam-winbind libnss-winbind
```

Durante la configuración de Kerberos utilizar:

```text
CURSO.LOCAL
dc.curso.local
dc.curso.local
```

## 6. Verificar autenticación Kerberos

Solicitar ticket con la cuenta administradora del dominio:

```bash
kinit administrator@CURSO.LOCAL
klist
```

Si `klist` muestra un ticket válido, la resolución DNS, Kerberos y la conectividad con el controlador funcionan correctamente.

## 7. Preparar configuración de Samba en el cliente

Crear copia del archivo original:

```bash
sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.initial
```

Crear un nuevo archivo:

```bash
sudo nano /etc/samba/smb.conf
```

Contenido recomendado:

```ini
[global]
        workgroup = CURSO
        realm = CURSO.LOCAL
        netbios name = ud101
        security = ADS
        dns forwarder = 192.168.1.8

        idmap config * : backend = tdb
        idmap config * : range = 50000-1000000

        template homedir = /home/%D/%U
        template shell = /bin/bash
        winbind use default domain = true
        winbind offline logon = false
        winbind nss info = rfc2307
        winbind enum users = yes
        winbind enum groups = yes

        vfs objects = acl_xattr
        map acl inherit = Yes
        store dos attributes = Yes
```

## 8. Gestionar servicios Samba en el cliente

Reiniciar servicios clásicos de Samba:

```bash
sudo systemctl restart smbd nmbd
```

Detener `samba-ad-dc`, ya que este equipo será cliente del dominio, no controlador:

```bash
sudo systemctl stop samba-ad-dc
```

Habilitar servicios necesarios:

```bash
sudo systemctl enable smbd nmbd
```

## 9. Unir Ubuntu Desktop al dominio

Ejecutar:

```bash
sudo net ads join -U administrator
```

En el servidor Samba AD DC, comprobar que el equipo aparece unido:

```bash
sudo samba-tool computer list
```

## 10. Configurar NSS para usuarios y grupos del dominio

Editar `nsswitch.conf`:

```bash
sudo nano /etc/nsswitch.conf
```

Ajustar estas líneas:

```text
passwd:       compat winbind
group:        compat winbind
shadow:       compat winbind
hosts:        files dns
```

Reiniciar Winbind:

```bash
sudo systemctl restart winbind
```

## 11. Verificar integración con el dominio

Listar usuarios del dominio:

```bash
wbinfo -u
```

Listar grupos del dominio:

```bash
wbinfo -g
```

Verificar resolución NSS:

```bash
sudo getent passwd | grep administrator
sudo getent group | grep 'domain admins'
id administrator
```

## 12. Configurar PAM y creación automática de home

Ejecutar:

```bash
sudo pam-auth-update
```

Seleccionar los módulos necesarios para autenticación con cuentas del dominio.

Editar:

```bash
sudo nano /etc/pam.d/common-account
```

Añadir al final:

```text
session    required    pam_mkhomedir.so    skel=/etc/skel/    umask=0022
```

Esto permite que, cuando un usuario de dominio inicie sesión por primera vez, se cree automáticamente su directorio home.

## 13. Probar autenticación con cuenta de dominio

Autenticación en terminal:

```bash
su administrator
```

Añadir privilegios sudo a la cuenta de dominio, si se necesita para administración:

```bash
sudo usermod -aG sudo administrator
```

Autenticación en entorno gráfico:

```text
administrator@curso.local
```

## Validaciones finales recomendadas

```bash
hostname -f
ping -c2 curso.local
sudo ntpdate -q curso.local
kinit administrator@CURSO.LOCAL
klist
testparm
sudo net ads testjoin
wbinfo -u
wbinfo -g
sudo getent passwd | grep administrator
sudo getent group | grep 'domain admins'
id administrator
```

En el controlador de dominio:

```bash
sudo samba-tool computer list
```

## Problemas frecuentes

### Error al unirse al dominio

Comprobar DNS, hora y Kerberos:

```bash
ping -c2 dc.curso.local
sudo ntpdate -q curso.local
kinit administrator@CURSO.LOCAL
```

### Usuarios del dominio no aparecen

Revisar Winbind y NSS:

```bash
sudo systemctl status winbind
cat /etc/nsswitch.conf
wbinfo -u
getent passwd
```

### No se crea el home del usuario

Revisar PAM:

```bash
cat /etc/pam.d/common-account
```

Debe existir:

```text
session    required    pam_mkhomedir.so    skel=/etc/skel/    umask=0022
```

## Conclusión

Se ha unido Ubuntu Desktop al dominio Samba Active Directory `curso.local`, habilitando autenticación con cuentas de dominio mediante Kerberos, Samba, Winbind, NSS y PAM. Este laboratorio permite integrar clientes Linux en una infraestructura de dominio centralizada junto a clientes Windows.
