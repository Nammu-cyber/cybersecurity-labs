# Windows 11 - IIS, sitios web, PHP y seguridad básica

Activación de IIS, creación de sitios, integración PHP, autenticación básica, restricciones IP, páginas de error y resolución de incidencias.

> Laboratorio documentado para portfolio tecnico. Entorno controlado, sin credenciales reales publicadas.

## Tecnologias

`Windows 11` `IIS` `PHP` `NTFS` `HTTP` `Seguridad básica`

## Entorno

| Campo | Valor |
|---|---|
| Sistema | Windows 11 |
| Servidor web | Internet Information Services (IIS) |
| Puertos | 80, 8080, 8081 |
| Componentes | World Wide Web Services, Management Tools, CGI/FastCGI, PHP |
| Tipo de práctica | Laboratorio local controlado |

## Objetivos

- Activar IIS y verificar la página por defecto en localhost.
- Crear un sitio web estático con contenido HTML en un puerto alternativo.
- Crear una aplicación PHP en IIS y comprobar phpinfo().
- Configurar autenticación básica, restricciones por IP y páginas de error personalizadas.
- Simular errores 403.14, 500.19 y 404, diagnosticarlos y aplicar solución.
- Restaurar permisos NTFS con takeown e icacls cuando el acceso queda bloqueado.

## Procedimiento resumido

### Instalación de IIS

Se activaron Internet Information Services, Servidor Web, Herramientas de administración web y World Wide Web Services desde Características de Windows.

### Sitio estático

Se creó C:\inetpub\wwwroot\SitiosWeb\MiEmpresa, se publicó un index.html y se enlazó a IIS como SitioEmpresa en el puerto 8080.

### Aplicación PHP

Se preparó C:\inetpub\wwwroot\SitiosWeb\AplicacionPHP, se configuró PHP/FastCGI y se verificó info.php en http://localhost:8081/info.php.

### Seguridad

Se habilitó autenticación básica, se limitó el acceso a localhost y se configuraron páginas de error 404/500 personalizadas.

### Troubleshooting

Se provocaron y resolvieron errores 403.14, 500.19 y 404, además de restaurar permisos NTFS con takeown e icacls.

## Comandos relevantes

```powershell
takeown /f "C:\inetpub\wwwroot\SitiosWeb\AplicacionPHP" /r /d s
icacls "C:\inetpub\wwwroot\SitiosWeb\AplicacionPHP" /reset /t /c /l
```

## Verificacion

- http://localhost muestra la página por defecto de IIS.
- http://localhost:8080 muestra el sitio corporativo estático.
- http://localhost:8081/info.php muestra la página phpinfo().
- Las restricciones IP, autenticación básica y errores personalizados responden según lo configurado.
- Tras restaurar permisos NTFS, el sitio vuelve a funcionar correctamente.

## Buenas practicas aplicadas o recomendadas

- No publicar autenticación básica sin TLS en producción.
- Evitar usuarios locales con contraseñas débiles.
- Aplicar permisos mínimos a las carpetas web.
- Mantener PHP actualizado y desactivar extensiones no necesarias.
- Revisar logs de IIS y eventos de Windows tras cada cambio.

## Evidencias visuales

Las siguientes imagenes corresponden a capturas del laboratorio y validaciones realizadas durante la practica.

### 01 captura pagina 01

![01 captura pagina 01](img/01-captura-pagina-01.png)

### 02 captura pagina 02

![02 captura pagina 02](img/02-captura-pagina-02.png)

### 03 captura pagina 03

![03 captura pagina 03](img/03-captura-pagina-03.png)

### 04 captura pagina 04

![04 captura pagina 04](img/04-captura-pagina-04.png)

### 05 captura pagina 05

![05 captura pagina 05](img/05-captura-pagina-05.png)

### 06 captura pagina 06

![06 captura pagina 06](img/06-captura-pagina-06.png)

### 07 captura pagina 07

![07 captura pagina 07](img/07-captura-pagina-07.png)

### 08 captura pagina 08

![08 captura pagina 08](img/08-captura-pagina-08.png)

### 09 captura pagina 09

![09 captura pagina 09](img/09-captura-pagina-09.png)

### 10 captura pagina 10

![10 captura pagina 10](img/10-captura-pagina-10.png)

### 11 captura pagina 11

![11 captura pagina 11](img/11-captura-pagina-11.png)

### 12 captura pagina 12

![12 captura pagina 12](img/12-captura-pagina-12.png)

### 13 captura pagina 13

![13 captura pagina 13](img/13-captura-pagina-13.png)

### 14 captura pagina 14

![14 captura pagina 14](img/14-captura-pagina-14.png)

### 15 captura pagina 15

![15 captura pagina 15](img/15-captura-pagina-15.png)

### 16 captura pagina 16

![16 captura pagina 16](img/16-captura-pagina-16.png)

### 17 captura pagina 17

![17 captura pagina 17](img/17-captura-pagina-17.png)


## Conclusiones

El laboratorio permite practicar una tarea realista de administracion de servicios web, documentando instalacion, configuracion, validacion y resolucion de errores. La documentacion se ha preparado para ser reutilizable como referencia tecnica en GitHub.

## Disclaimer

Uso exclusivamente formativo en entorno controlado. No contiene credenciales reales ni pretende ser una configuracion final de produccion.
