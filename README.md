# Minutas ASH — Instaladores

Este repositorio publica exclusivamente instaladores, hashes SHA-256 y notas de versión verificadas de Minutas ASH.

El código fuente, configuraciones y documentación interna se mantienen fuera de este repositorio.

## Descargar e instalar

La forma recomendada es usar el instalador asistido. Abra PowerShell y ejecute:

```powershell
irm -UseBasicParsing https://raw.githubusercontent.com/MTLeon/MinutasASH-Releases/main/Install-MinutasASH.ps1 | iex
```

El script descarga las partes de la última versión indicada, las reconstruye y verifica su SHA-256 antes de abrir el instalador. `-UseBasicParsing` evita el aviso propio de Windows PowerShell 5.1.

También puede descargar manualmente las partes y el archivo SHA-256 desde [Releases](../../releases). Use el comando `copy /b` indicado en las notas de versión para reconstruir el instalador.
## Seguridad y soporte

- Descargue instaladores únicamente desde este repositorio y confirme su hash SHA-256.
- No publique transcripciones, minutas, credenciales ni diagnósticos en incidencias o comentarios.
- Para usar audio/video, el instalador principal ya incorpora el componente local de Whisper. El complemento separado sirve para reparar o instalar esa función independientemente.
