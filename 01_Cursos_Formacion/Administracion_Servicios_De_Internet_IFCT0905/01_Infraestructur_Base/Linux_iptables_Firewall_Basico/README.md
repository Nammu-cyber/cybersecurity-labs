# Firewall básico con iptables

**Área:** Firewall y red

## Objetivo

Crear un script de iptables que limpie reglas previas, aplique política restrictiva por defecto y permita tráfico mínimo necesario para ICMP, DNS, HTTP y HTTPS.

## Tecnologías

- Linux
- iptables
- ICMP
- DNS
- HTTP
- HTTPS

## Desarrollo del laboratorio

### Objetivo del script

El script realiza tres acciones principales: limpiar reglas existentes de las tablas `filter` y `nat`, reiniciar contadores y aplicar una política por defecto restrictiva en `INPUT`, `OUTPUT` y `FORWARD`.

### Comandos útiles de inspección

```bash
iptables -L
iptables -L -nv --line-numbers
ss -ltuna
```

Eliminar una regla concreta:

```bash
iptables -D OUTPUT <numero_de_regla>
```

### Limpieza de reglas y contadores

```bash
iptables -t filter -F
iptables -t nat -F
iptables -t filter -Z
iptables -t nat -Z
```

### Política por defecto restrictiva

```bash
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP
```

Esta configuración bloquea todo salvo lo permitido explícitamente.

### Política alternativa permisiva

Solo como referencia, no usada en el modo restrictivo:

```bash
# iptables -P INPUT ACCEPT
# iptables -P OUTPUT ACCEPT
# iptables -P FORWARD ACCEPT
```

### Permitir ICMP

```bash
iptables -A OUTPUT -o enp0s3 -p icmp -j ACCEPT
iptables -A INPUT -i enp0s3 -p icmp -j ACCEPT
```

### Permitir DNS

```bash
iptables -A OUTPUT -o enp0s3 -p udp --dport 53 -j ACCEPT
iptables -A INPUT -i enp0s3 -p udp --sport 53 -j ACCEPT
iptables -A OUTPUT -o enp0s3 -p tcp --dport 53 -j ACCEPT
iptables -A INPUT -i enp0s3 -p tcp --sport 53 -j ACCEPT
```

### Permitir loopback

```bash
iptables -I INPUT 1 -i lo -j ACCEPT
iptables -I OUTPUT 1 -o lo -j ACCEPT
```

### Permitir HTTP

```bash
iptables -A OUTPUT -o enp0s3 -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -i enp0s3 -p tcp --sport 80 -j ACCEPT
```

### Permitir HTTPS

```bash
iptables -A OUTPUT -o enp0s3 -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -i enp0s3 -p tcp --sport 443 -j ACCEPT
```

### Script completo

```bash
#!/bin/bash

# Limpiar reglas existentes
iptables -t filter -F
iptables -t nat -F

# Reiniciar contadores
iptables -t filter -Z
iptables -t nat -Z

# Politica por defecto restrictiva
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# Loopback
iptables -I INPUT 1 -i lo -j ACCEPT
iptables -I OUTPUT 1 -o lo -j ACCEPT

# ICMP
iptables -A OUTPUT -o enp0s3 -p icmp -j ACCEPT
iptables -A INPUT -i enp0s3 -p icmp -j ACCEPT

# DNS UDP/TCP
iptables -A OUTPUT -o enp0s3 -p udp --dport 53 -j ACCEPT
iptables -A INPUT -i enp0s3 -p udp --sport 53 -j ACCEPT
iptables -A OUTPUT -o enp0s3 -p tcp --dport 53 -j ACCEPT
iptables -A INPUT -i enp0s3 -p tcp --sport 53 -j ACCEPT

# HTTP
iptables -A OUTPUT -o enp0s3 -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -i enp0s3 -p tcp --sport 80 -j ACCEPT

# HTTPS
iptables -A OUTPUT -o enp0s3 -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -i enp0s3 -p tcp --sport 443 -j ACCEPT
```

### Validaciones recomendadas

```bash
iptables -L -nv --line-numbers
ss -ltuna
ping -c 3 8.8.8.8
dig google.com
curl -I http://example.com
curl -I https://example.com
```

## Notas de seguridad

- Antes de ejecutar políticas DROP en remoto, asegúrate de permitir SSH o tener acceso por consola.

## Conclusión

Este laboratorio documenta una configuración reproducible en entorno local controlado y deja una base técnica reutilizable para futuras prácticas de administración de servicios.
