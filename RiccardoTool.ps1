# RiccardoTool Modern V2.0
# Based on V0.8 by Riccardo Plehan
# Refactored for Modern UI (WPF) and clean code structure.

# --- 1. Controllo Privilegi di Amministratore ---
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Richiesta permessi di amministratore..." -ForegroundColor Yellow
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# --- 2. Setup Ambiente ---
Write-Host "Tool Create By Riccardo Plehan - Social ---> https://e-z.bio/richy88"
Write-Host "Avvio In Corso..."
Write-Host "  _____   _____ ___  
 |  __ \ / ____/ _ \ 
 | |__) | |   | (_) |
 |  _  /| |    > _ < 
 | | \ \| |___| (_) |
 |_|  \_\\_____\___/ "

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Check Chocolatey
if (-not (Get-Command choco.exe -ErrorAction SilentlyContinue)) {
    Write-Host "Installazione Chocolatey in corso..." -ForegroundColor Cyan
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# --- 3. Dati ---
$packages = @(
    "open-shell", "googlechrome", "thunderbird", "adobereader", "7zip.install",
    "libreoffice-fresh", "cdburnerxp", "k-litecodecpackfull", "paint.net",
    "kis", "geforce-game-ready-driver", "amd-ryzen-chipset"
)

# --- 4. Interfaccia Grafica (XAML) ---
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="RiccardoTool Modern V2.0" Height="900" Width="1200"
        WindowStartupLocation="CenterScreen"
        Background="#1E1E1E" Foreground="White">
    <Window.Resources>
        <!-- Stile Pulsanti Moderni -->
        <Style TargetType="Button">
            <Setter Property="Background" Value="#333333"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="Margin" Value="6"/>
            <Setter Property="Padding" Value="12,8"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="border" Background="{TemplateBinding Background}" CornerRadius="6" Padding="{TemplateBinding Padding}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="border" Property="Background" Value="#505050"/>
                            </Trigger>
                            <Trigger Property="IsPressed" Value="True">
                                <Setter TargetName="border" Property="Background" Value="#007ACC"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- Stile CheckBox -->
        <Style TargetType="CheckBox">
            <Setter Property="Foreground" Value="#DDDDDD"/>
            <Setter Property="FontSize" Value="15"/>
            <Setter Property="Margin" Value="8,4"/>
            <Setter Property="VerticalContentAlignment" Value="Center"/>
        </Style>

        <!-- Stile GroupBox -->
        <Style TargetType="GroupBox">
            <Setter Property="Foreground" Value="#4CC9F0"/> 
            <Setter Property="FontSize" Value="16"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Margin" Value="5"/>
            <Setter Property="Padding" Value="10"/>
            <Setter Property="BorderBrush" Value="#444444"/>
            <Setter Property="BorderThickness" Value="1"/>
        </Style>
    </Window.Resources>

    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="320" />
            <ColumnDefinition Width="*" />
        </Grid.ColumnDefinitions>

    <!-- COLONNA SINISTRA: Lista Pacchetti e Installazione -->
        <Grid Grid.Row="0" Grid.Column="0" Margin="10">
            <Grid.RowDefinitions>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="*"/>
                <RowDefinition Height="Auto"/>
            </Grid.RowDefinitions>
            
            <TextBlock Text="&#x1F4E6; Pacchetti" FontSize="24" FontWeight="Bold" Foreground="White" Margin="0,0,0,10" HorizontalAlignment="Center"/>

            <Border Grid.Row="1" Background="#252526" CornerRadius="8" BorderBrush="#3E3E42" BorderThickness="1">
                <ScrollViewer VerticalScrollBarVisibility="Auto" Margin="5">
                    <StackPanel Name="PackageListPanel"/>
                </ScrollViewer>
            </Border>

            <StackPanel Grid.Row="2" Margin="0,15,0,0">
                <ProgressBar Name="PkgProgressBar" Height="10" Margin="5" Background="#333333" Foreground="#00E676" Visibility="Collapsed"/>
                <TextBlock Name="StatusText" Text="" Foreground="#AAAAAA" FontSize="12" Margin="5" HorizontalAlignment="Center"/>
                
                <Button Name="BtnInstall" Content="&#x2B07; INSTALLA SELEZIONATI" Background="#2E7D32" FontWeight="Bold" FontSize="16" Height="45"/>
                <Button Name="BtnUninstall" Content="&#x1F5D1; DISINSTALLA" Background="#C62828" Margin="6,5,6,15"/>
            </StackPanel>
        </Grid>

        <!-- COLONNA DESTRA: Strumenti e Utility -->
        <ScrollViewer Grid.Row="0" Grid.Column="1" VerticalScrollBarVisibility="Auto">
            <StackPanel Margin="10,20,20,20">
                <TextBlock Text="&#x1F6E0; Windows Tools - Powered by Richy88_" FontSize="28" FontWeight="Bold" Foreground="#FFFF00" Margin="5,0,0,20" Effect="{DynamicResource DropShadow}"/>

                <!-- Selezione Rapida -->
                <GroupBox Header=" Selezione Rapida ">
                    <WrapPanel Orientation="Horizontal">
                        <Button Name="BtnSelectAll" Content="Tutti (Win 10/11)" Width="150"/>
                        <Button Name="BtnSelectLite" Content="Lite (Win 10/11)" Width="150"/>
                        <Button Name="BtnDeselectAll" Content="Deseleziona Tutto" Width="150"/>
                        <Button Name="BtnListInstalled" Content="Lista Installati" Width="150"/>
                    </WrapPanel>
                </GroupBox>

                <!-- Sistematizzazione in gruppi logici -->
                <GroupBox Header=" Prestazioni &amp; Pulizia " Margin="5,15,5,5">
                    <WrapPanel>
                        <Button Name="BtnCleanDisk" Content="&#x1F9F9; Pulizia Avanzata" Width="150" ToolTip="Esegue cleanmgr e pulisce temp"/>
                        <Button Name="BtnSysScan" Content="&#x1F50D; Scan &amp; Repair" Width="150" ToolTip="Esegue SFC e DISM"/>
                        <Button Name="BtnPowerPlan" Content="&#x26A1; Max Prestazioni" Width="150" ToolTip="Imposta Power Plan Prestazioni Elevate"/>
                        <Button Name="BtnDisableBgApps" Content="&#x1F6AB; No App Backgr." Width="150"/>
                    </WrapPanel>
                </GroupBox>

                <GroupBox Header=" Interfaccia &amp; Personalizzazione " Margin="5,5,5,5">
                    <WrapPanel>
                        <Button Name="BtnMyPcIcon" Content="&#x1F5A5; Icona Questo PC" Width="150" ToolTip="Mostra l'icona Questo PC sul desktop"/>
                        <Button Name="BtnTaskbarLeft" Content="&#x2B05; Win11 Toolbar Sx" Width="150"/>
                        <Button Name="BtnInfoReg" Content="&#x1F4DD; Info OEM Reg" Width="150"/>
                    </WrapPanel>
                </GroupBox>

                <GroupBox Header=" Admin &amp; Network " Margin="5,5,5,5">
                    <WrapPanel>
                        <Button Name="BtnActivateWin" Content="&#x1F511; Attiva Windows" Width="150" Background="#5D4037" ToolTip="Script Massgrave"/>
                        <Button Name="BtnDnsPanel" Content="&#x1F310; DNS Panel" Width="150"/>
                        <Button Name="BtnNetplwiz" Content="&#x1F464; Netplwiz" Width="120"/>
                    </WrapPanel>
                </GroupBox>

                <!-- Console e Spegnimento -->
                <GroupBox Header=" Power &amp; Console " Margin="5,15,5,5">
                    <WrapPanel>
                         <Button Name="BtnOpenCmd" Content="&#x1F4BB; CMD" Width="100"/>
                         <Button Name="BtnClearConsole" Content="C Pulisci" Width="100"/>
                         <Button Name="BtnRestart" Content="&#x1F504; RIAVVIA" Background="#EF6C00" Foreground="Black" Width="120" FontWeight="Bold"/>
                         <Button Name="BtnShutdown" Content="&#x1F534; SPEGNI" Background="#B71C1C" Width="120" FontWeight="Bold"/>
                         <Button Name="BtnExit" Content="&#x274C; ESCI" Width="100"/>
                    </WrapPanel>
                </GroupBox>
            </StackPanel>
        </ScrollViewer>
        <TextBlock Name="FooterLink" Grid.Row="1" Grid.ColumnSpan="2" 
                   Text="Windows Tool - Powered by Richy88_" 
                   Foreground="#666666" Cursor="Hand" 
                   HorizontalAlignment="Center" Margin="5,0,5,10" FontSize="14">
             <TextBlock.Style>
                <Style TargetType="TextBlock">
                    <Style.Triggers>
                        <Trigger Property="IsMouseOver" Value="True">
                             <Setter Property="Foreground" Value="#4CC9F0"/>
                             <Setter Property="TextDecorations" Value="Underline"/>
                        </Trigger>
                    </Style.Triggers>
                </Style>
             </TextBlock.Style>
        </TextBlock>
    </Grid>
</Window>
"@

# --- 5. Caricamento XAML ---
$reader = (New-Object System.Xml.XmlNodeReader $xaml)
try {
    $window = [Windows.Markup.XamlReader]::Load($reader)
}
catch {
    Write-Warning "Errore XAML: $_"
    Read-Host "Premi Invio per uscire"
    exit
}

# Scarica e Imposta Icona da GitHub
$iconUrl = "https://raw.githubusercontent.com/RC8Dev/WinTools/main/_Ricona_.ico"
$iconDest = "$env:TEMP\_Ricona_.ico"
try {
    if (-not (Test-Path $iconDest)) {
        Invoke-WebRequest -Uri $iconUrl -OutFile $iconDest -ErrorAction SilentlyContinue
    }
    if (Test-Path $iconDest) {
        $window.Icon = [System.Windows.Media.Imaging.BitmapFrame]::Create([System.Uri]$iconDest)
    }
}
catch {}

# --- 6. Helper e Funzioni ---
function Get-Ctrl ($name) { 
    $ctrl = $window.FindName($name)
    if ($null -eq $ctrl) { Write-Host "ATTENZIONE: Controllo '$name' non trovato nello XAML." -ForegroundColor Red }
    return $ctrl
}

function Show-Msg ($msg, $title = "Info", $icon = "Information", $buttons = "OK") {
    return [System.Windows.Forms.MessageBox]::Show($msg, $title, [System.Windows.Forms.MessageBoxButtons]::$buttons, [System.Windows.Forms.MessageBoxIcon]::$icon)
}

# Popolazione Checkbox
$panel = Get-Ctrl "PackageListPanel"
$checkBoxes = @{}

foreach ($pkg in $packages) {
    if (-not [string]::IsNullOrWhiteSpace($pkg)) {
        $chk = New-Object System.Windows.Controls.CheckBox
        $chk.Content = $pkg
        $chk.Name = "chk_$($pkg -replace '[^a-zA-Z0-9]', '_')"
        $panel.AddChild($chk)
        $checkBoxes[$pkg] = $chk
    }
}

# --- 7. Event Handler (Logica) ---

# Selezione Rapida
# Selezione Rapida
(Get-Ctrl "BtnSelectAll").Add_Click({ 
        $exclude = "kis", "geforce-game-ready-driver", "amd-ryzen-chipset"
        $checkBoxes.GetEnumerator() | ForEach-Object {
            if ($exclude -notcontains $_.Key) {
                $_.Value.IsChecked = $true
            }
            else {
                $_.Value.IsChecked = $false
            }
        }
    })

(Get-Ctrl "BtnSelectLite").Add_Click({ 
        $checkBoxes.Values | ForEach-Object { $_.IsChecked = $false }
        # Lista Lite basata sull'originale (indici 0,1,2,3,4,5,7,8)
        $litePackages = "open-shell", "googlechrome", "thunderbird", "adobereader", "7zip.install", "libreoffice-fresh", "k-litecodecpackfull", "paint.net"
        foreach ($p in $litePackages) { if ($checkBoxes.ContainsKey($p)) { $checkBoxes[$p].IsChecked = $true } }
    })

(Get-Ctrl "BtnDeselectAll").Add_Click({ 
        $checkBoxes.Values | ForEach-Object { $_.IsChecked = $false } 
    })

(Get-Ctrl "BtnListInstalled").Add_Click({
        $status = Get-Ctrl "StatusText"
        $status.Text = "Recupero lista pacchetti..."
        [System.Windows.Forms.Application]::DoEvents()
        $list = & choco.exe list --local-only
        Show-Msg "$list" "Pacchetti Installati"
        $status.Text = ""
    })

# Installazione
(Get-Ctrl "BtnInstall").Add_Click({
        $selected = $checkBoxes.Values | Where-Object { $_.IsChecked } | ForEach-Object { $_.Content }

        if ($selected.Count -gt 0) {
            $pbar = Get-Ctrl "PkgProgressBar"
            $status = Get-Ctrl "StatusText"
            $pbar.Visibility = "Visible"
            $pbar.Maximum = $selected.Count
            $pbar.Value = 0
        
            try {
                $window.Hide() # Nasconde la finestra come nella vecchia versione
            
                $i = 0
                foreach ($pkg in $selected) {
                    $i++
                    $status.Text = "Installazione: $pkg ($i/$($selected.Count))"
                    [System.Windows.Forms.Application]::DoEvents() 
            
                    # Esegui comando
                    Start-Process powershell -ArgumentList "-Command `"choco install $pkg --ignore-checksums -y`"" -NoNewWindow -Wait
            
                    $pbar.Value = $i
                }
                $status.Text = "Operazione completata!"
                Show-Msg "Installazione completata!" "Mona go fini!"
            }
            catch {
                Show-Msg "Errore durante l'installazione: $_" "Errore" "Error"
            }
            finally {
                $window.Show() # Mostra di nuovo la finestra
                $window.Activate()
                $pbar.Visibility = "Collapsed"
            }
        }
        else {
            Show-Msg "Seleziona almeno un pacchetto." "Attenzione" "Warning"
        }
    })

# Disinstallazione
(Get-Ctrl "BtnUninstall").Add_Click({
        $selected = $checkBoxes.Values | Where-Object { $_.IsChecked } | ForEach-Object { $_.Content }

        if ($selected.Count -gt 0) {
            if ((Show-Msg "Sei sicuro di voler DISINSTALLARE i pacchetti selezionati?" "Attenzione" "Warning" "YesNo") -eq "Yes") {
                try {
                    $window.Hide() # Nasconde la finestra
                    $status = Get-Ctrl "StatusText"
            
                    foreach ($pkg in $selected) {
                        $status.Text = "Disinstallazione: $pkg"
                        [System.Windows.Forms.Application]::DoEvents()
                        Start-Process "choco.exe" -ArgumentList "uninstall", $pkg, "-y" -NoNewWindow -Wait
                    }
                    $status.Text = "Disinstallazione completata"
                    Show-Msg "Disinstallazione completata!"
                }
                catch {
                    Show-Msg "Errore durante la disinstallazione: $_" "Errore" "Error"
                }
                finally {
                    $window.Show() # Mostra di nuovo la finestra
                    $window.Activate()
                }
            }
        }
        else {
            Show-Msg "Nessun pacchetto selezionato." "Errore" "Error"
        }
    })    
# Utility
(Get-Ctrl "BtnMyPcIcon").Add_Click({
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value 0
        Stop-Process -Name Explorer -Force
        Write-Host "Icona ripristinata. Explorer riavviato." -ForegroundColor Green
    })

(Get-Ctrl "BtnCleanDisk").Add_Click({
        Start-Process "cleanmgr.exe" -ArgumentList "/sagerun:65535"
        Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
        Show-Msg "Pulizia disco avviata e Temp svuotati."
    })

(Get-Ctrl "BtnSysScan").Add_Click({
        $window.Hide()
        Start-Process cmd -ArgumentList "/c echo AVVIO SCANSIONE COMPLETA... & echo --- CHKDSK --- & chkdsk /scan /perf & echo. & echo --- DISM --- & DISM /Online /Cleanup-Image /RestoreHealth & echo. & echo --- SFC --- & SFC /scannow & pause" -Verb RunAs -Wait
        $window.Show()
    })

(Get-Ctrl "BtnPowerPlan").Add_Click({
        powercfg /s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
        Write-Host "Power Plan: Prestazioni Elevate Attivato." -ForegroundColor Green
    })

(Get-Ctrl "BtnDisableBgApps").Add_Click({
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name "GlobalUserDisabled" -Value 1
        Write-Host "App in background disabilitate per l'utente corrente." -ForegroundColor Green
    })

(Get-Ctrl "BtnActivateWin").Add_Click({
        Write-Host "Verrà avviato lo script da massgrave.dev..." -ForegroundColor Green
        Start-Process powershell -ArgumentList "irm https://get.activated.win | iex"
    })

(Get-Ctrl "BtnTaskbarLeft").Add_Click({
        $url = "https://raw.githubusercontent.com/RC8Dev/WinTools/main/W11BarraSinistra.bat"
        $dest = "$env:TEMP\W11BarraSinistra.bat"
        Write-Host "Download in corso..." -ForegroundColor Cyan
        try {
            Invoke-WebRequest -Uri $url -OutFile $dest -ErrorAction Stop
            Start-Process $dest -Wait
            Write-Host "Eseguito." -ForegroundColor Green
        }
        catch {
            Show-Msg "Errore download: $_" "Errore" "Error"
        }
    })

(Get-Ctrl "BtnInfoReg").Add_Click({
        $url = "https://raw.githubusercontent.com/RC8Dev/WinTools/main/ElettronetInfo.reg"
        $dest = "$env:TEMP\ElettronetInfo.reg"
        Write-Host "Download in corso..." -ForegroundColor Cyan
        try {
            Invoke-WebRequest -Uri $url -OutFile $dest -ErrorAction Stop
            Start-Process "regedit.exe" -ArgumentList "/s `"$dest`"" -Wait
            Show-Msg "Registro applicato."
        }
        catch {
            Show-Msg "Errore download: $_" "Errore" "Error"
        }
    })

(Get-Ctrl "BtnDnsPanel").Add_Click({
        $url = "https://raw.githubusercontent.com/RC8Dev/WinTools/main/DnsPanel.exe"
        $dest = "$env:TEMP\DnsPanel.exe"
        Write-Host "Download in corso..." -ForegroundColor Cyan
        try {
            Invoke-WebRequest -Uri $url -OutFile $dest -ErrorAction Stop
            Start-Process $dest
        }
        catch {
            Show-Msg "Errore download: $_" "Errore" "Error"
        }
    })

(Get-Ctrl "BtnNetplwiz").Add_Click({ Start-Process "netplwiz" })
(Get-Ctrl "BtnOpenCmd").Add_Click({ Start-Process "cmd.exe" })
(Get-Ctrl "BtnClearConsole").Add_Click({ Clear-Host; Show-Msg "Console pulita." })

# Spegnimento
(Get-Ctrl "BtnExit").Add_Click({ $window.Close() })
(Get-Ctrl "BtnRestart").Add_Click({ if ((Show-Msg "Riavviare ora?" "Conferma" "Question" "YesNo") -eq "Yes") { Restart-Computer -Force } })
(Get-Ctrl "BtnShutdown").Add_Click({ if ((Show-Msg "Spegnere ora?" "Conferma" "Question" "YesNo") -eq "Yes") { Stop-Computer -Force } })

# Footer
(Get-Ctrl "FooterLink").Add_MouseLeftButtonDown({
        Start-Process "https://e-z.bio/richy88"
    })

# --- 8. Avvio ---
$window.Add_Closed({ [System.Windows.Threading.Dispatcher]::CurrentDispatcher.InvokeShutdown() })
$window.Show()
[System.Windows.Threading.Dispatcher]::Run()
