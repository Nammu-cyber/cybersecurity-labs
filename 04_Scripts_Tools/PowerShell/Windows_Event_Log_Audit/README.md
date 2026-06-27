# Windows Event Log Audit · Failed Login Attempts

Mini herramienta en PowerShell para auditar intentos fallidos de inicio de sesión en Windows a partir del registro de seguridad del sistema.

El script consulta el visor de eventos de Windows, filtra los eventos de error de autenticación con **Event ID 4625**, extrae los intentos asociados al usuario `Admin` y genera un archivo de salida con el recuento de fallos detectados.

## Objetivo

El objetivo de este laboratorio/script es practicar una tarea básica de auditoría defensiva en Windows:

- Revisar eventos de seguridad del sistema.
- Identificar intentos fallidos de inicio de sesión.
- Filtrar eventos por usuario.
- Generar un log de auditoría local.
- Automatizar una comprobación sencilla con PowerShell.

## Requisitos

- Sistema Windows con PowerShell.
- Permisos suficientes para leer el registro de seguridad.
- Ejecutar PowerShell como administrador.
- Auditoría de inicio de sesión habilitada en Windows.

## Funcionamiento

El script realiza los siguientes pasos:

1. Define un archivo de salida en el escritorio del usuario `Admin`.
2. Crea o limpia el archivo de auditoría.
3. Consulta el registro de seguridad de Windows.
4. Filtra los eventos con ID `4625`, correspondientes a fallos de inicio de sesión.
5. Filtra los eventos asociados al usuario `Admin`.
6. Agrupa los resultados y cuenta los intentos fallidos.
7. Escribe el resumen final en un archivo `.log`.

## Ejecución

Desde PowerShell ejecutado como administrador:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\auditoria_fallos.ps1
```

El resultado se guarda en:

```powershell
C:\Users\Admin\Desktop\auditoria_fallos_Admin.log
```

## Evento analizado

El script analiza el siguiente evento de Windows:

```text
Event ID 4625: An account failed to log on
```

Este evento se genera cuando se produce un intento fallido de autenticación en el sistema.

## Posibles mejoras

Este script puede ampliarse fácilmente para hacerlo más flexible:

- Permitir indicar el usuario como parámetro.
- Exportar resultados en CSV.
- Añadir fecha, hora, origen e IP del intento fallido.
- Filtrar por rango de fechas.
- Generar alertas si se supera un número determinado de fallos.
- Adaptarlo para auditorías de varios usuarios.

## Aviso

Este script está pensado para uso educativo y defensivo en entornos propios o autorizados. No debe utilizarse sobre sistemas ajenos sin permiso explícito.
