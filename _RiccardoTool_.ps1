# Create By Riccardo Plehan - Social ---> https://socialtoapp.com/richy88

# Richiedi l'esecuzione con privilegi elevati
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
  exit
}

# Verifica se Chocolatey � gi� installato
if (-not (Get-Command choco.exe -ErrorAction SilentlyContinue)) {
  # Scarica e installa Chocolatey
  Set-ExecutionPolicy Bypass -Scope Process -Force
  Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

Write-Host "Tool Create By Riccardo Plehan - Social ---> https://socialtoapp.com/richy88"
Write-Host "Avvio In Corso..."

Start-Sleep -Seconds 2

# Lista pacchetti Chocolatey personalizzata
$packages = @(
    "open-shell",
    "googlechrome",
    "thunderbird",
    "adobereader",
    "7zip.install",
    "libreoffice-fresh",
    "cdburnerxp",
    "k-litecodecpackfull",
    "paint.net",
    "kis",
    "geforce-game-ready-driver",
    "amd-ryzen-chipset",
    "",
    "",
    "",
    ""
)

Write-Host "  _____   _____ ___  
 |  __ \ / ____/ _ \ 
 | |__) | |   | (_) |
 |  _  /| |    > _ < 
 | | \ \| |___| (_) |
 |_|  \_\\_____\___/ "

# Crea l'interfaccia utente
Add-Type -AssemblyName System.Windows.Forms
$form = New-Object System.Windows.Forms.Form
$form.Text = "Windows Tool By Riccardo Plehan Use Chocolatey For Install"
$form.Width = 800
$form.Height = 800
$form.StartPosition = "CenterScreen"

# Aggiungi icona al form
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# URL dell'icona su GitHub (raw link)
$iconUrl = "https://raw.githubusercontent.com/Richy88/ToolWindows1.0/refs/heads/main/_Ricona_.ico"

# Percorso temporaneo dove salvare l'icona
$tempIconPath = [System.IO.Path]::GetTempFileName().Replace(".tmp", ".ico")

# Scarica l'icona
Invoke-WebRequest -Uri $iconUrl -OutFile $tempIconPath

# Crea il form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Windows Tool By Riccardo Plehan Use Chocolatey For Install"
$form.ClientSize = New-Object System.Drawing.Size(800, 800)

# Carica l'icona scaricata
$form.Icon = New-Object System.Drawing.Icon($tempIconPath)

# Aggiungi lo sfondo al form
$url = "https://iili.io/JnNNMZv.png"
$wc = New-Object System.Net.WebClient
$imageBytes = $wc.DownloadData($url)
$stream = New-Object System.IO.MemoryStream(,$imageBytes)
$backgroundImage = [System.Drawing.Image]::FromStream($stream)
$form.BackgroundImage = $backgroundImage
$form.BackgroundImageLayout = [System.Windows.Forms.ImageLayout]::Stretch

# Crea un pulsante Icona sul form
$buttonIco = New-Object Windows.Forms.Button
$buttonIco.Text = "Ico QuestoPc"
$buttonIco.Location = New-Object Drawing.Point(15, 65)
$buttonIco.Size = New-Object Drawing.Size(80, 30)

# Aggiungi un gestore di eventi del pulsante Icona
$buttonIco.Add_Click({
    # Abilita l'icona del computer sul desktop
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value 0

    # Aggiorna il desktop per applicare le modifiche
    Stop-Process -Name Explorer -Force
    Start-Process explorer
})

$form.Controls.Add($buttonIco)

# Aggiungi un pulsante per eseguire il file info.reg
$regButton = New-Object System.Windows.Forms.Button
$regButton.Location = New-Object System.Drawing.Point(15, 100)
$regButton.Size = New-Object System.Drawing.Size(80, 30)
$regButton.Text = "Info Reg"
$regButton.Add_Click({
    # Esegui il file .reg utilizzando regedit.exe e attendi la completamento del processo
    $regFile = Join-Path $PSScriptRoot "ElettronetInfo.reg"
    $process = [System.Diagnostics.Process]::Start("regedit.exe", "/s `"$regFile`"")
    $process.WaitForExit()

    # Mostra una notifica
    [System.Windows.Forms.MessageBox]::Show("Elettronet info impostato correttamente!", "Oem Information Elettronet", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})

$form.Controls.Add($regButton)

# Crea un pulsante per selezionare rapidamente pi� elementi (Win 10 & 11 All)
$multiSelectButton = New-Object System.Windows.Forms.Button
$multiSelectButton.Location = New-Object System.Drawing.Point(100, 65)
$multiSelectButton.Size = New-Object System.Drawing.Size(100, 30)
$multiSelectButton.Text = "Win 10 / 11 All&"
$multiSelectButton.Add_Click({
    # Crea un array con gli indici degli elementi da selezionare
    $selectedIndices = 0, 1, 2, 3, 4, 5, 6, 7, 8

    # Seleziona gli elementi nell'array di indici
    foreach ($index in $selectedIndices) {
        $checkedListBox.SetItemChecked($index, $true)
    }
})

$form.Controls.Add($multiSelectButton)

# Crea un pulsante per selezionare rapidamente pi� elementi (Win 10 & 11 Lite)
$multiSelectButton = New-Object System.Windows.Forms.Button
$multiSelectButton.Location = New-Object System.Drawing.Point(100, 100)
$multiSelectButton.Size = New-Object System.Drawing.Size(100, 30)
$multiSelectButton.Text = "Win 10 / 11 Lite"
$multiSelectButton.Add_Click({
    # Crea un array con gli indici degli elementi da selezionare
    $selectedIndices = 0, 1, 2, 3, 4, 5, 7, 8

    # Seleziona gli elementi nell'array di indici
    foreach ($index in $selectedIndices) {
        $checkedListBox.SetItemChecked($index, $true)
    }
})

$form.Controls.Add($multiSelectButton)

# Crea un pulsante che sposta la barra delle apllicazioni a sinistra su windows 11
$ButtonBarraW11 = New-Object Windows.Forms.Button
$ButtonBarraW11.Text = "W11 barra sinistra"
$ButtonBarraW11.Location = New-Object Drawing.Point(15, 135)
$ButtonBarraW11.Size = New-Object System.Drawing.Size(80, 30)

# Gestore per l'evento Click del pulsante
$ButtonBarraW11.Add_Click({
    $ScriptRoot = $PSScriptRoot
    $BatchFile = Join-Path -Path $ScriptRoot -ChildPath "W11BarraSinistra.bat"
    
    if (Test-Path -Path $BatchFile -PathType Leaf) {
        Start-Process -FilePath $BatchFile
    } else {
        [System.Windows.Forms.MessageBox]::Show("File batch non trovato!", "Errore", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
})

$Form.Controls.Add($ButtonBarraW11)

#Deseleziona tutti i pacchetti
$buttonDeselezionaTutti = New-Object System.Windows.Forms.Button
$buttonDeselezionaTutti.Location = New-Object System.Drawing.Point(100, 135)
$buttonDeselezionaTutti.Size = New-Object System.Drawing.Size(100, 30)
$buttonDeselezionaTutti.Text = "Deseleziona Tutti"
$buttonDeselezionaTutti.Add_Click({
    for ($i = 0; $i -lt $checkedListBox.Items.Count; $i++) {
        $checkedListBox.SetItemChecked($i, $false)
    }
})

$form.Controls.Add($buttonDeselezionaTutti)

# Crea un pulsante per visualizzare una notifica con l'elenco dei pacchetti installati
$buttonNotify = New-Object System.Windows.Forms.Button
$buttonNotify.Text = "Installati"
$buttonNotify.Location = New-Object System.Drawing.Point(10, 340)
$buttonNotify.Size = New-Object System.Drawing.Size(100, 30)
$buttonNotify.Add_Click({
    $packages = & choco.exe list --local-only | Where-Object { $_ -notmatch '^Chocolatey' -and $_ -notmatch '^kb2' } | foreach { $_.split("|")[0].trim() }
    $message = "Attualmente Installati:`n`n"
    foreach ($package in $packages) {
        $message += "$package`n"
    }
    $title = "Chocolatey HeloWord ;D"
    [System.Windows.Forms.MessageBox]::Show($message, $title, [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})

$form.Controls.Add($buttonNotify)

# Crea un pulsante "Installa"
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(10, 380)
$button.Size = New-Object System.Drawing.Size(100, 30)
$button.Text = "Installa"
$button.ForeColor = "Green"

$form.Controls.Add($button)

# Crea un pulsante "disinstalla"
$buttonUninstall = New-Object System.Windows.Forms.Button
$buttonUninstall.Text = "Disinstalla"
$buttonUninstall.Location = New-Object System.Drawing.Point(10, 420)
$buttonUninstall.Size = New-Object System.Drawing.Size(100, 30)
$buttonUninstall.ForeColor = [System.Drawing.Color]::Red

$buttonUninstall.Add_Click({
    # Nascondi il form durante l'esecuzione della disinstallazione
    $form.Hide()

    $selectedPackages = $checkedListBox.CheckedItems

    # Mostra un messaggio di conferma all'utente
    $messageBoxResult = [System.Windows.Forms.MessageBox]::Show("Sei sicuro di voler disinstallare i pacchetti selezionati?", "Mona te son sicuro?", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Question)

    # Verifica se l'utente ha confermato la disinstallazione
    if ($messageBoxResult -eq [System.Windows.Forms.DialogResult]::Yes) {
        foreach ($packageName in $selectedPackages) {
            $arguments = "uninstall", $packageName, "-y"
            Start-Process "choco.exe" -ArgumentList $arguments -NoNewWindow -Wait
        }

        # Mostra un messaggio di conferma
        [System.Windows.Forms.MessageBox]::Show("Disinstallazioni completate!.", "Conferma", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    }

    # Fai riapparire il form
    $form.Show()
})

$form.Controls.Add($buttonUninstall)

# Aggiungi pulsante pulisci console
$clearButton = New-Object System.Windows.Forms.Button
$clearButton.Text = "Clear Console"
$clearButton.Location = New-Object System.Drawing.Point(10, 460)
$clearButton.Size = New-Object System.Drawing.Size(100, 30)
$clearButton.Add_Click({
    Clear-Host
})

$form.Controls.Add($clearButton)

# Avvia Attiva Windows
function ExecuteCommand {
    try {
        # Esegui il comando in un thread separato
        Start-Job -ScriptBlock {
            Invoke-Expression "iex(wget -useb https://massgrave.dev/get)"
        } | Out-Null

        # Aggiungi il messaggio di successo
        Write-Host "Download & Avvio Dello Script In Corso..."
    } catch {
        Write-Host "Errore durante l'esecuzione del comando: $_"
    }
}

$buttonActivator = New-Object System.Windows.Forms.Button
$buttonActivator.Location = New-Object System.Drawing.Point(610, 30)
$buttonActivator.Size = New-Object System.Drawing.Size(100, 30)
$buttonActivator.Text = "Attiva Windows"
$buttonActivator.Add_Click({
    ExecuteCommand
})

$form.Controls.Add($buttonActivator)

# Aggiungi un pulsante per aprire una finestra del prompt dei comandi
$cmdButton = New-Object System.Windows.Forms.Button
$cmdButton.Location = New-Object System.Drawing.Point(610, 65)
$cmdButton.Size = New-Object System.Drawing.Size(100, 30)
$cmdButton.Text = "Apri Cmd"
$cmdButton.Add_Click({
    # Avvia una nuova finestra del prompt dei comandi
    Start-Process cmd.exe
})

$form.Controls.Add($cmdButton)

# Aggiungi un pulsante per eseguire un controllo completo del sistema
$Scanbutton = New-Object System.Windows.Forms.Button
$Scanbutton.Location = New-Object System.Drawing.Point(715,65)
$Scanbutton.Size = New-Object System.Drawing.Size(80,31)
$Scanbutton.Text = "SyS Scan"

$Scanbutton.Add_Click({
    $Form.Hide()
    $commands = @"
    chkdsk /scan /perf
    SFC /scannow
    DISM /Online /Cleanup-Image /RestoreHealth
    SFC /scannow
    pause
"@
    $encoded = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($commands))
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c powershell -encodedcommand $encoded" -Verb RunAs -Wait
    $Form.Show()
})

$Form.Controls.Add($Scanbutton)

# Aggiungi il pulsante per Pulire il disco
$cleanUpButton = New-Object System.Windows.Forms.Button
$cleanUpButton.Location = New-Object System.Drawing.Point(610, 100)
$cleanUpButton.Size = New-Object System.Drawing.Size(100, 30) # Modifica le dimensioni del pulsante
$cleanUpButton.Text = "Pulisci Disco"
$cleanUpButton.Add_Click({
    Start-Process -FilePath "cleanmgr.exe" -ArgumentList "/sagerun:65535" # Pulisci tutti i dischi e i file temporanei di Windows
    Remove-Item -Path "$env:TEMP\*" -Recurse -Force # Rimuovi tutti i file temporanei
    $prefetch = "$env:SystemRoot\Prefetch\*"
    Remove-Item -Path $prefetch -Force -Confirm:$false # Rimuovi tutti i file di Prefetch senza richiedere conferma
    $winTemp = "C:\Windows\Temp"
    Remove-Item -Path $winTemp\* -Recurse -Force # Rimuovi tutti i file nella cartella C:\Windows\Temp
    $softwaredist = "C:\Windows\SoftwareDistribution\Download"
    Remove-Item -Path $softwaredist\* -Recurse -Force # Rimuovi tutti i file nella cartella C:\Windows\SoftwareDistribution\Download
})

$form.Controls.Add($cleanUpButton)

# Aggiungi il pulsante per aprire NetPlWiz
$ButtonNetplwiz = New-Object System.Windows.Forms.Button
$ButtonNetplwiz.Location = New-Object System.Drawing.Point(610,135)
$ButtonNetplwiz.Size = New-Object System.Drawing.Size(100,30)
$ButtonNetplwiz.Text = "Apri Netplwiz"
$ButtonNetplwiz.Add_Click({
    Start-Process -FilePath "netplwiz"
})

$Form.Controls.Add($ButtonNetplwiz)

# Crea il pulsante "Imposta Power Plan su Prestazioni elevate"
$buttonSetPowerPlan = New-Object System.Windows.Forms.Button
$buttonSetPowerPlan.Location = New-Object System.Drawing.Point(610, 170)
$buttonSetPowerPlan.Size = New-Object System.Drawing.Size(100, 30)
$buttonSetPowerPlan.Text = "Prestazioni"
$buttonSetPowerPlan.Add_Click({
    # Imposta il power plan su "Prestazioni elevate"
    powercfg /s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    Write-Host "Power Plan impostato su Prestazioni elevate."
    
    # Invia la notifica quando l'operazione � stata completata
    $notification = New-Object System.Windows.Forms.NotifyIcon
    $notification.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info
    $notification.BalloonTipTitle = "Operazione completata"
    $notification.BalloonTipText = "Power Plan impostato su Prestazioni elevate."
    $notification.Visible = $true
    $notification.ShowBalloonTip(5000)
})

$form.Controls.Add($buttonSetPowerPlan)

# Crea un pulsante disabilita app in backgroud
$buttonbackground = New-Object Windows.Forms.Button
$buttonbackground.Text = "Background app"
$buttonbackground.Location = New-Object Drawing.Point(715, 170)
$buttonbackground.Size = New-Object System.Drawing.Size(80, 31)
$buttonbackground.Add_Click({
    # Disabilita le app in background
    Write-Host "Disabilitazione delle app in background..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name "GlobalUserDisabled" -Value 1
    Write-Host "Le app in background sono state disabilitate."
})

$Form.Controls.Add($buttonbackground)

$checkedListBox = New-Object System.Windows.Forms.CheckedListBox
$checkedListBox.Location = New-Object System.Drawing.Point(215, 10)
$checkedListBox.Size = New-Object System.Drawing.Size(380, 330)
$packages | ForEach-Object { $checkedListBox.Items.Add($_) }
$form.Controls.Add($checkedListBox)

#Esegui Exe Dns Panel
$exeButton = New-Object System.Windows.Forms.Button
$exeButton.Location = New-Object System.Drawing.Point(610, 205)
$exeButton.Size = New-Object System.Drawing.Size(100, 30)
$exeButton.Text = "Dns Panel"
$exeButton.Add_Click({
    # URL del file .exe da scaricare
    $exeUrl = "https://github.com/Richy88/ToolWindows1.0/raw/refs/heads/main/DnsPanel.exe"

    # Specifica il percorso temporaneo dove salvare il file .exe
    $tempExe = Join-Path $env:TEMP "DnsPanel.exe"

    # Scarica il file .exe da GitHub
    Invoke-RestMethod -Uri $exeUrl -OutFile $tempExe

    Write-Host "File .exe scaricato in: $tempExe"

    # Esegui il file .exe scaricato
    Write-Host "Avvio di DnsPanel in corso..."

    # Avvia il file .exe
    Start-Process $tempExe
})

$form.Controls.Add($exeButton)

# Crea il pulsante "Riavvia"
$restartButton = New-Object System.Windows.Forms.Button
$restartButton.Location = New-Object System.Drawing.Point(690, 340)
$restartButton.Size = New-Object System.Drawing.Size(100, 30)
$restartButton.Text = "Riavvia Pc"
$restartButton.Font = New-Object System.Drawing.Font("Impact", 11, [System.Drawing.FontStyle]::Regular)
$restartButton.ForeColor = "orange"

# Aggiungi un evento click al pulsante "Riavvia"
$restartButton.Add_Click({
    # Chiedi la conferma prima di riavviare il computer
    $result = [System.Windows.Forms.MessageBox]::Show("Sei sicuro di voler riavviare il computer?", "Mona te son sicuro?", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Question)
    if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
        # Riavvia il computer
        Restart-Computer -Force
    }
})

$form.Controls.Add($restartButton)

# Crea il pulsante "Spegni"
$shutdownButton = New-Object System.Windows.Forms.Button
$shutdownButton.Location = New-Object System.Drawing.Point(690, 380)
$shutdownButton.Size = New-Object System.Drawing.Size(100, 30)
$shutdownButton.Text = "Spegni Pc"
$shutdownButton.Font = New-Object System.Drawing.Font("Impact", 11, [System.Drawing.FontStyle]::Regular)
$shutdownButton.ForeColor = "Red"

# Aggiungi un evento click al pulsante "Spegni"
$shutdownButton.Add_Click({
    # Chiedi la conferma prima di spegnere il computer
    $result = [System.Windows.Forms.MessageBox]::Show("Sei sicuro di voler spegnere il computer?", "Mona te son sicuro?", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Question)
    if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
        # Spegni il computer
        Stop-Computer -Force
    }
})

$form.Controls.Add($shutdownButton)

# Aggiungi il pulsante exit powershell
$exitButton = New-Object System.Windows.Forms.Button
$exitButton.Location = New-Object System.Drawing.Point(690, 420)
$exitButton.Size = New-Object System.Drawing.Size(100, 30)
$exitButton.Text = "Exit"
$exitButton.Font = New-Object System.Drawing.Font("Impact", 11, [System.Drawing.FontStyle]::Regular)
$exitButton.ForeColor = "Red"

# Aggiungi un evento click al pulsante "Exit"
$exitButton.Add_Click({
    # Visualizza una finestra di conferma
    $result = [System.Windows.Forms.MessageBox]::Show("Sei sicuro di voler chiudere il programma?", "Mona te son sicuro?", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Question)
    if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
        # Chiudi il form
        $form.Close()
    }
})

$form.Controls.Add($exitButton)

$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(10, 360)
$progressBar.Size = New-Object System.Drawing.Size(370, 20)
$progressBar.Style = "Continuous"
$progressBar.Minimum = 0
$progressBar.Maximum = $packages.Count
$progressBar.Visible = $false
$form.Controls.Add($progressBar)

# Aggiungi un gestore di eventi per il clic del pulsante
$button.Add_Click({
    # Disabilita il form durante l'installazione
    $form.Enabled = $false

    # Installa i pacchetti selezionati con Chocolatey
    if ($checkedListBox.CheckedItems.Count -gt 0) {
        $packagesToInstall = @()
        foreach ($item in $checkedListBox.CheckedItems) {
            $packagesToInstall += $item.ToString()
        }

        # Mostra la barra di avanzamento durante l'installazione
        $progressBar.Visible = $true
        $i = 1

        # Nascondi il form durante l'installazione
        $form.Visible = $false

        foreach ($package in $packagesToInstall) {
            Write-Progress -Activity "Installazione pacchetti con Chocolatey" -PercentComplete (($i / $packagesToInstall.Count) * 100) -Status "Installazione di $package..."
            $installCmd = "choco install " + $package + " --ignore-checksums" + " -y"
            Start-Process powershell -ArgumentList "-Command `"$installCmd`"" -NoNewWindow -Wait
            $i++
            $progressBar.Value = $i
        }
        $progressBar.Visible = $false

        # Mostra un messaggio di completamento
        [System.Windows.Forms.MessageBox]::Show("Installazioni completate!", "Mona Go Fin!", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)

        # Riabilita il form dopo l'installazione
        $form.Enabled = $true
        $form.Visible = $true
    } else {
        [System.Windows.Forms.MessageBox]::Show("Non hai selezionato nessun pacchetto da installare!", "Allora te son mona!", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)

        # Riabilita il form dopo l'installazione
        $form.Enabled = $true
    }
})

# Avvia l'interfaccia utente
$form.ShowDialog() | Out-Null


# Create By Riccardo Plehan - Social ---> https://socialtoapp.com/richy88
# Create By Riccardo Plehan - Social ---> https://socialtoapp.com/richy88
# Create By Riccardo Plehan - Social ---> https://socialtoapp.com/richy88
# Create By Riccardo Plehan - Social ---> https://socialtoapp.com/richy88

