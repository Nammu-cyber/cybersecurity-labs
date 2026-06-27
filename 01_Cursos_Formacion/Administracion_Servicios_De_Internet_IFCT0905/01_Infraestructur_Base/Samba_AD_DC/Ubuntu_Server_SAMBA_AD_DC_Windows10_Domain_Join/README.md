# Ubuntu Server como Samba Active Directory Domain Controller

> Laboratorio práctico para desplegar un controlador de dominio Active Directory sobre Ubuntu Server utilizando Samba AD DC, Kerberos, DNS interno y sincronización horaria con Chrony.

## Objetivo

Configurar un servidor Ubuntu como controlador de dominio compatible con Active Directory, usando el dominio interno `curso.local` y el controlador `dc.curso.local`.

Al finalizar, el servidor deberá permitir:

- Resolver el dominio local `curso.local`.
- Actuar como Domain Controller mediante Samba AD DC.
- Autenticar usuarios mediante Kerberos.
- Publicar servicios internos de dominio, LDAP y Kerberos.
- Sincronizar tiempo con Chrony para evitar errores de autenticación.
- Gestionar usuarios, equipos y grupos con `samba-tool`.
- Preparar la unión de clientes Windows y Linux al dominio.

## Entorno de laboratorio

| Elemento | Valor |
|---|---|
| Servidor | Ubuntu Server |
| Hostname | `dc` |
| FQDN | `dc.curso.local` |
| Dominio | `curso.local` |
| Realm Kerberos | `CURSO.LOCAL` |
| NetBIOS Domain | `CURSO` |
| IP del controlador | `192.168.1.8` |
| Red interna | `192.168.1.0/24` |
| DNS backend | `SAMBA_INTERNAL` |
| DNS forwarder | `8.8.8.8` |

## 1. Configuración inicial del servidor

### 1.1 Cambiar hostname

```bash
sudo hostnamectl set-hostname dc
```

Comprobar el nombre configurado:

```bash
hostname
hostname -f
```

### 1.2 Modificar `/etc/hosts`

Editar el archivo:

```bash
sudo nano /etc/hosts
```

Añadir o ajustar la entrada del controlador:

```text
192.168.1.8 dc.curso.local dc
```

Comprobar resolución del FQDN:

```bash
hostname -f
ping -c2 dc.curso.local
```

## 2. Configuración DNS local del propio servidor

Para evitar conflictos con `systemd-resolved`, se desactiva el servicio y se gestiona manualmente `/etc/resolv.conf`.

```bash
sudo systemctl disable --now systemd-resolved
sudo unlink /etc/resolv.conf
sudo nano /etc/resolv.conf
```

Contenido recomendado:

```text
nameserver 192.168.1.8
nameserver 8.8.8.8
search curso.local
```

Hacer el archivo inmutable para evitar cambios automáticos:

```bash
sudo chattr +i /etc/resolv.conf
```

> Nota: en entornos profesionales se debe documentar esta decisión, porque hacer inmutable `/etc/resolv.conf` puede dificultar cambios posteriores de red. En laboratorio es útil para mantener estable la resolución DNS.

## 3. Instalación de Samba AD DC

Actualizar repositorios:

```bash
sudo apt update
```

Instalar Samba y dependencias necesarias:

```bash
sudo apt install -y acl attr samba samba-dsdb-modules samba-vfs-modules smbclient winbind libpam-winbind libnss-winbind libpam-krb5 krb5-config krb5-user dnsutils chrony net-tools
```

Durante la configuración de Kerberos se utilizarán estos valores:

```text
CURSO.LOCAL
dc.curso.local
dc.curso.local
```

## 4. Preparar servicios para Samba AD DC

Un controlador Samba AD DC no utiliza los servicios clásicos `smbd`, `nmbd` y `winbind` como servicio principal.

Detener y deshabilitar servicios innecesarios:

```bash
sudo systemctl disable --now smbd nmbd winbind
```

Habilitar el servicio correcto:

```bash
sudo systemctl unmask samba-ad-dc
sudo systemctl enable samba-ad-dc
```

## 5. Provisionar Samba Active Directory

Crear copia del archivo original:

```bash
sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.orig
```

Ejecutar el provisionado:

```bash
sudo samba-tool domain provision
```

Valores del provisionado:

```text
Realm: CURSO.LOCAL
Domain: CURSO
Server Role: dc
DNS backend: SAMBA_INTERNAL
DNS forwarder IP address: 8.8.8.8
```

## 6. Configurar Kerberos

Guardar configuración original:

```bash
sudo mv /etc/krb5.conf /etc/krb5.conf.orig
```

Copiar la configuración generada por Samba:

```bash
sudo cp /var/lib/samba/private/krb5.conf /etc/krb5.conf
```

## 7. Iniciar y comprobar Samba AD DC

Iniciar el servicio:

```bash
sudo systemctl start samba-ad-dc
```

Comprobar estado:

```bash
sudo systemctl status samba-ad-dc
```

El servicio debe aparecer como `active (running)`.

## 8. Configurar sincronización de tiempo con Chrony

Samba Active Directory depende de Kerberos, y Kerberos requiere que los relojes del controlador de dominio y los clientes estén sincronizados. Esto evita errores de autenticación y reduce riesgos de ataques de repetición.

Ajustar permisos del socket de NTP firmado:

```bash
sudo chown root:_chrony /var/lib/samba/ntp_signd/
sudo chmod 750 /var/lib/samba/ntp_signd/
```

Editar Chrony:

```bash
sudo nano /etc/chrony/chrony.conf
```

Añadir o verificar estas líneas:

```text
bindcmdaddress 192.168.1.8
allow 192.168.1.0/24
ntpsigndsocket /var/lib/samba/ntp_signd
```

Reiniciar y verificar:

```bash
sudo systemctl restart chronyd
sudo systemctl status chronyd
```

## 9. Verificación DNS y servicios de dominio

Verificar registros A:

```bash
host -t A curso.local
host -t A dc.curso.local
```

Verificar registros SRV de Kerberos y LDAP:

```bash
host -t SRV _kerberos._udp.curso.local
host -t SRV _ldap._tcp.curso.local
```

Verificar recursos compartidos predeterminados:

```bash
smbclient -L curso.local -N
```

## 10. Verificar autenticación Kerberos

Solicitar ticket Kerberos:

```bash
kinit administrator@CURSO.LOCAL
klist
```

Probar acceso a `netlogon`:

```bash
sudo smbclient //localhost/netlogon -U 'administrator'
```

## 11. Administración básica del dominio

Cambiar contraseña del usuario `administrator`:

```bash
sudo samba-tool user setpassword administrator
```

Validar configuración de Samba:

```bash
testparm
```

Comprobar nivel funcional del dominio:

```bash
sudo samba-tool domain level show
```

## 12. Gestión de usuarios

Crear usuario:

```bash
sudo samba-tool user create usuario_curso
```

Listar usuarios:

```bash
sudo samba-tool user list
```

Eliminar usuario:

```bash
samba-tool user delete <nombre_del_usuario>
```

## 13. Gestión de equipos

Listar equipos unidos al dominio:

```bash
sudo samba-tool computer list
```

Eliminar equipo:

```bash
sudo samba-tool computer delete <nombre_del_equipo>
```

## 14. Gestión de grupos

Crear grupo:

```bash
samba-tool group add <nombre_del_grupo>
```

Listar grupos:

```bash
samba-tool group list
```

Listar miembros de un grupo:

```bash
samba-tool group listmembers 'Domain Admins'
```

Agregar usuario a un grupo:

```bash
samba-tool group addmembers <nombre_del_grupo> <nombre_del_usuario>
```

Eliminar usuario de un grupo:

```bash
samba-tool group removemembers <nombre_del_grupo> <nombre_del_usuario>
```

## Validaciones finales recomendadas

```bash
hostname -f
ping -c2 dc.curso.local
systemctl status samba-ad-dc
systemctl status chronyd
host -t A curso.local
host -t A dc.curso.local
host -t SRV _kerberos._udp.curso.local
host -t SRV _ldap._tcp.curso.local
smbclient -L curso.local -N
kinit administrator@CURSO.LOCAL
klist
sudo samba-tool domain level show
sudo samba-tool user list
sudo samba-tool computer list
```

## Problemas frecuentes

### El FQDN no resuelve

Revisar:

```bash
cat /etc/hosts
cat /etc/resolv.conf
hostname -f
```

### Kerberos falla

Comprobar hora y sincronización:

```bash
timedatectl status
systemctl status chronyd
```

### Samba no arranca

Validar configuración:

```bash
testparm
sudo journalctl -u samba-ad-dc --no-pager | tail -n 80
```

### Clientes no encuentran el dominio

Comprobar registros SRV:

```bash
host -t SRV _kerberos._udp.curso.local
host -t SRV _ldap._tcp.curso.local
```

## Conclusión

Se ha configurado un controlador de dominio Active Directory en Ubuntu Server utilizando Samba AD DC. El servidor queda preparado para autenticar usuarios, gestionar equipos del dominio, publicar servicios Kerberos/LDAP y permitir la integración posterior de clientes Windows y Linux.
