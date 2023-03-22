*En Bref : 

	- Script écrit en PowerShell 

	- Permet à un utilisateur de : 
		 D’afficher les différentes options sous forme d’un écran d’accueil 
		 D’afficher les principales caractéristiques du système 
		 D’afficher les différents processus en cours d’utilisation 
		 D’afficher le fichier log 
		 De copier le fichier log sur une clef USB 

	- L’utilisateur pourra choisir les options possibles par une entrée au clavier entre 1 et 5. 

	- Chaque commande est inscrite dans un fichier log.

	- Pour ne pas à modifier dans le script, le chemin menant au dossier "MonDossier" et fichier "monfichier.log", 
	il est conseillé de copier le dossier contenant le script et les autres fichiers .txt sur la racine Windows(C:). 


*Plus en Détails: 

	Ce script est en PowerShell et permet d'afficher un menu principal avec 5 options. L'utilisateur peut choisir une option en entrant un nombre entre 1 et 5. Ensuite, une action spécifique est exécutée en fonction du choix de l'utilisateur.

	Le script utilise une boucle while qui s'exécutera en boucle tant que la valeur $true est vraie. Cela signifie que le menu principal sera affiché à chaque itération de la boucle.

	Le menu principal est affiché en appelant la fonction Show-MainMenu.

	Ensuite, le script utilise la fonction Read-Host pour demander à l'utilisateur d'entrer un choix. L'option choisie est stockée dans la variable $choice.

	Le script utilise une instruction switch pour exécuter une action spécifique en fonction du choix de l'utilisateur. Si l'utilisateur choisit l'option 1, la fonction Show-SystemInfo est appelée. Si l'utilisateur choisit l'option 2, la fonction Show-ProcessInfo est appelée. Si l'utilisateur choisit l'option 3, la fonction Show-LogFile est appelée. Si l'utilisateur choisit l'option 4, la fonction Copy-LogFileToUsb est appelée. Si l'utilisateur choisit l'option 5, le script affiche un message de sortie et se termine.

	Si l'utilisateur entre une valeur qui n'est pas comprise entre 1 et 5, le script affiche un message d'erreur et retourne au menu principal.

	Enfin, le script utilise la fonction Write-ToLogFile pour écrire des informations dans un fichier journal, la fonction Clear-Host pour effacer l'écran et la fonction Start-Sleep pour attendre 5 secondes avant de quitter le programme avec la fonction Exiting-Program.






																			Made by DabCelest
												  							------------------