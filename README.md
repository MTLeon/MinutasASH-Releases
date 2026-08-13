# Minutas ASH — Instaladores

Este repositorio publica exclusivamente instaladores, hashes SHA-256 y notas de versión verificadas de Minutas ASH.

El código fuente, configuraciones y documentación interna se mantienen fuera de este repositorio.

## Descargar e instalar

1. Abra la sección [Releases](../../releases) y descargue todos los archivos `MinutasASH_Setup_...partNN` de la versión deseada, junto con su archivo `SHA256`.
2. Guarde todas las partes en una misma carpeta, sin cambiarles el nombre.
3. Abra **Símbolo del sistema** en esa carpeta y ejecute:

   ```bat
   copy /b MinutasASH_Setup_2.3.4_Online.exe.part01+MinutasASH_Setup_2.3.4_Online.exe.part02+MinutasASH_Setup_2.3.4_Online.exe.part03+MinutasASH_Setup_2.3.4_Online.exe.part04 MinutasASH_Setup_2.3.4_Online.exe
   ```

4. Opcionalmente, compruebe el archivo resultante:

   ```powershell
   Get-FileHash .\MinutasASH_Setup_2.3.4_Online.exe -Algorithm SHA256
   ```

   El resultado debe coincidir con el hash publicado en la versión.
5. Ejecute `MinutasASH_Setup_2.3.4_Online.exe` y siga el asistente. Windows puede pedir confirmación al instalar software descargado de Internet.

## Seguridad y soporte

- Descargue instaladores únicamente desde este repositorio y confirme su hash SHA-256.
- No publique transcripciones, minutas, credenciales ni diagnósticos en incidencias o comentarios.
- Para usar audio/video, el instalador principal ya incorpora el componente local de Whisper. El complemento separado sirve para reparar o instalar esa función independientemente.
