:: Imposta la barra delle applicazioni a sinistra su Windows 11
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 0 /f
:: Riavvia l'esplora risorse per applicare le modifiche
taskkill /f /im explorer.exe
start explorer.exe
