
# Declaration de la fonction d'affichage de l'ecran d'accueil
function Show-MainMenu {
    #Clear-Host
    Get-Content C:\Script_Rap\menu_report_2.txt
}
# Initialisation des ressources internes necessaires 
$folderPath = "C:\MonDossier"
$folderExists = Test-Path $folderPath

if(-not $folderExists){
    New-Item -ItemType Directory -Path $folderPath
    Write-ToLogFile "Creation du dossier MonDossier"
    Write-Host "Le dossier MonDossier a ete cree"
}

$filePath = "C:\MonDossier\monfichier.log"
$fileExists = Test-Path $filePath

if(-not $fileExists){
    New-Item -ItemType File -Path $filePath
    Write-ToLogFile "Creation du fichier monfichier.log"
    Write-Host "Le fichier monfichier.log a ete cree"
}

# Declaration de la fonction d'affichage des caracteristiques du systeme
function Show-SystemInfo {
    Clear-Host
    Write-ToLogFile "Affichage des caracteristiques du systeme"
    Write-Host "Caracteristiques du systeme:"
    Write-Host "Nom de l'ordinateur: $env:COMPUTERNAME"
    Write-Host "Version de Windows: $(Get-CimInstance Win32_OperatingSystem | Select-Object Caption, Version, OSArchitecture)"
    Write-Host "Memoire Physique totale: $(Get-CimInstance Win32_ComputerSystem | Select-Object TotalPhysicalMemory | ForEach-Object { $_.TotalPhysicalMemory / 1MB }) Mo"
    Read-Host -Prompt "Appuyez sur Entrée pour revenir au menu principal."
}

# Declaration de la fonction d'affichage des processus en cours d'utilisation
function Show-ProcessInfo {
    Clear-Host
    Write-ToLogFile "Affichage des processus en cours d'utilisation"
    Write-Host "Processus en cours d'utilisation:"
    Get-Process | Select-Object Id, ProcessName, CPU, PrivateMemorySize, WorkingSet | Out-Gridview  #Format-Table
    Read-Host -Prompt "Appuyez sur Entree pour revenir au menu principal."
}

# Declaration de la fonction d'écriture dans le fichier log
function Write-ToLogFile ($message) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    #$command = $($MyInvocation.Line)
    $logEntry = "$timestamp - $message" #-$command
    Add-Content -Path $filePath -Value $logEntry
}

# Declaration de la fonction d'affichage du fichier log
function Show-LogFile {
    Clear-Host
    Write-ToLogFile "Affichage du fichier log"
    Write-Host "Contenu du fichier log:"
    Get-Content -Path "C:\MonDossier\monfichier.log"
    Read-Host -Prompt "Appuyez sur Entree pour revenir au menu principal."
}

# Declaration de la fonction de copie du fichier log sur une clef USB
function Copy-LogFileToUsb {
    Clear-Host
    Write-ToLogFile "Tentative de copie du fichier log sur une clef USB"

    $usbDrive = Get-WmiObject Win32_Volume | Where-Object { $_.DriveType -eq 2 } | Select-Object -First 1 # Pour recuperer la 1ere cle usb connectee 

    if ($usbDrive) {  #Processus de verification usb connectee et de copie de contenu fichier log
        $path = $usbDrive.DriveLetter + "\MonDossier" # verification existance du dossier sur usb ou sa creation
        if(!(Test-Path $path)){
            New-Item -ItemType Directory -Path $path
        }

        $log_file = $path + "\monfichier.log"   # verification existance du fichier log sur usb ou sa creation
        if(!(Test-Path $log_file)){
            New-Item -ItemType File -Path $log_file
        }

        $usbPath = $log_file
        Copy-Item -Path "C:\MonDossier\monfichier.log" -Destination $usbPath
        Write-ToLogFile "Copie du fichier log sur une clef USB"
        Write-Host "Le fichier log a ete copie avec succes sur la clef USB."
    }
    else {
        Write-ToLogFile "tentative echouee de copie du fichier log sur une clef USB"
        Write-Host "Aucune clef USB detectee."
    }
    Read-Host -Prompt "Appuyez sur Entree pour revenir au menu principal."
}

# Declaration de la fonction de sortie du programme
function Exiting-Program {
    exit
}

# Boucle principale du script
$choice = 0
while ($true) {
    Show-MainMenu
    $choice = Read-Host -Prompt "Entrer votre choix (1-5)." # utilisation de la commande Read-Host pour afficher le message et stocker la réponse de utili dans la variable $choice.
    switch($choice) {
        1 {
            Show-SystemInfo
        }
        2 {
            Show-ProcessInfo
        }
        3 {
            Show-LogFile
        }
        4 {
            Copy-LogFileToUsb
        }
        5 {
            Clear-Host
            Write-ToLogFile "Quitter program"
            Write-Host "SORTIE DU PROGRAMME....  AU REVOIR !"
            Start-Sleep -Seconds 5
            Exiting-Program
        }
        default {
            Clear-Host
            Write-ToLogFile "Choix Invalide"
            Write-Host "Choix Invalide"
        }
    }
}