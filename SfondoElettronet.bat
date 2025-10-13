@echo off
setlocal

:: URL diretto dell'immagine su GitHub
set IMAGE_URL=https://raw.githubusercontent.com/RC8Dev/WinTools/refs/heads/main/SfondoElettronet.png

:: Percorso locale dove salvare l'immagine
set DEST=C:\sfondo_elettronet1.png

echo Scarico immagine da GitHub...
certutil -urlcache -split -f "%IMAGE_URL%" "%DEST%"
if errorlevel 1 (
    echo Errore nel download dell'immagine.
    pause
    goto :eof
)

echo Imposto lo sfondo del desktop...

:: Imposta il percorso nel registro
REG ADD "HKCU\Control Panel\Desktop" /V Wallpaper /T REG_SZ /F /D "%DEST%"

:: Imposta lo stile (10 = riempi, 6 = adatta, 0 = centrare, ecc.)
REG ADD "HKCU\Control Panel\Desktop" /V WallpaperStyle /T REG_SZ /F /D 10
REG ADD "HKCU\Control Panel\Desktop" /V TileWallpaper /T REG_SZ /F /D 0

:: Aggiorna lo sfondo usando PowerShell (più affidabile su Windows 11)
powershell -command ^
    "$code = '[DllImport(\"user32.dll\", SetLastError = true)] public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);';" ^
    "Add-Type -MemberDefinition $code -Name WinAPI -Namespace Wallpaper;" ^
    "[Wallpaper.WinAPI]::SystemParametersInfo(20, 0, '%DEST%', 3)"

echo Fatto! Lo sfondo dovrebbe essere aggiornato.
pause
endlocal
