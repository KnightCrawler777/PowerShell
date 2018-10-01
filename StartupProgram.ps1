#region functions
function newForm ($Text, [int]$SizeX, [int]$SizeY)
{
	$NewForm1 = New-Object System.Windows.Forms.Form
		$NewForm1.Text = $Text
		$NewForm1.Size = New-Object System.Drawing.Size($SizeX,$SizeY)
		$NewForm1.FormBorderStyle = "FixedDialog" # sets the window to where it cant be rescaled
		$NewForm1.TopMost = $true
		$NewForm1.ControlBox = $true # gives us the top right x min max controls
		$NewForm1.StartPosition = "CenterScreen"
		$NewForm1.Font = "Segoe UI"
	return $NewForm1
}

function newLabel ($Text, [int]$LocationX, [int]$LocationY, [int]$SizeX, [int]$SizeY)
{
	$NewLabel1 = New-Object System.Windows.Forms.Label
		$NewLabel1.Location = New-Object System.Drawing.Size($LocationX,$LocationY)
		$NewLabel1.Size = New-Object System.Drawing.Size($SizeX,$SizeY)
		$NewLabel1.TextAlign = "MiddleCenter"
		$NewLabel1.Text = $Text
		$NewLabel1.Font = [System.Drawing.Font]::new("Comic Sans MS", 12, [System.Drawing.FontStyle]::Underline)
	return $NewLabel1
}

function newButton ($Text, [int]$LocationX, [int]$LocationY, [int]$SizeX, [int]$SizeY)
{
	$newButton1 = New-Object System.Windows.Forms.Button
		$newButton1.Location = New-Object System.Drawing.Size($LocationX,$LocationY)
		$newButton1.Size = New-Object System.Drawing.Size($SizeX,$SizeY)
		$newButton1.TextAlign = "MiddleCenter"
		$newButton1.Text = $Text
	return $newButton1
}

function StartAppxPackage ($Name)
{
	foreach($package in Get-AppxPackage) 
	{ 
		foreach($appId in ($package | Get-AppxPackageManifest).Package.Applications.Application.Id) 
		{ 
			if(($package.Name -like $Name) -or ($appId -like $Name)) 
			{ 
				$commandLine = "shell:AppsFolder\$($package.PackageFamilyName)!$appId"  
					start $commandLine 
			} 
		} 
	}
}
#endregion functions

# Load required assemblies
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

#party time
Play 'C:\Users\jhensley\Music\Alan Walker - Fade.mp3'

#voice 
#Add-Type -AssemblyName System.speech
#$voice=New-Object System.Speech.Synthesis.SpeechSynthesizer
#$hostname=hostname
$date=Get-Date
#$voice.Speak("Hello. My name is $hostname. It is $date.")

# Drawing form and controls
$form_mainscreen = newForm "PRECO @ $date" 650 350 # create main screen form

#region labels	
# adding a label to my form (uncontrollable text object)
$labelOne_mainscreen = newLabel "Programs" 30 15 190 20 # create main screen label
	$form_mainscreen.Controls.Add($labelOne_mainscreen) # add label to the mainscreen form
	
# adding a label to my form (uncontrollable text object)
$labelTwo_mainscreen = newLabel "Music" 220 15 190 20 # create main screen label
	$form_mainscreen.Controls.Add($labelTwo_mainscreen) # add label to the mainscreen form
	
# adding a label to my form (uncontrollable text object)
$labelThree_mainscreen = newLabel "Combos" 410 15 190 20 # create main screen label
	$form_mainscreen.Controls.Add($labelThree_mainscreen) # add label to the mainscreen form
#endregion labels

#region programs
# add a button
$button_chrome = newButton "Chrome" 50 50 150 20
	$button_chrome.Add_Click({
		# Commands to run when button is clicked
		Set-Location "C:\Program Files (x86)\Google\Chrome\Application"
		.\chrome.exe "www.facebook.com"
		sleep 1
		.\chrome.exe "/new-tab www.google.com"
		})
	$form_mainscreen.Controls.Add($button_chrome)
	
# add a button
$button_Outlook = newButton "Outlook" 50 100 150 20
	$button_Outlook.Add_Click({
		# Commands to run when button is clicked
		explorer.exe shell:AppsFolder\Microsoft.Office.Desktop_8wekyb3d8bbwe!Outlook # Open Outlook
	})
	$form_mainscreen.Controls.Add($button_Outlook)
	
# add a button
$button_Syspro = newButton "SYSPRO" 50 150 150 20
	$button_Syspro.Add_Click({
		# Commands to run when button is clicked
		.\SYSPROClient.exe /WCF=PIKSSYSPRO1:1978 /BASEDIR=0 /oper=jhensley /pass=newone2 /comp=1 #Open SysPro
	})
	$form_mainscreen.Controls.Add($button_Syspro)
	
# add a button
$button_acade = newButton "AutoCAD Electrical" 50 200 150 20
	$button_acade.Add_Click({
		# Commands to run when button is clicked
		Start-Process "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\AutoCAD Electrical 2018 - English\AutoCAD Electrical 2018 - English.lnk" # Open AutoCAD Electrical
	})
	$form_mainscreen.Controls.Add($button_acade)
#endregion programs
	
#region music
# add a button
$button_spotify = newButton "Spotify" 240 50 150 20
	$button_spotify.Add_Click({
		# Start Spotify
		Start-Process "C:\Users\jhensley\AppData\Roaming\Spotify\Spotify.exe"
	})
	$form_mainscreen.Controls.Add($button_spotify)
	
# add a button
$button_itunes = newButton "iTunes" 240 100 150 20
	$button_itunes.Add_Click({
		# Start iTunes
		Start-Process "C:\Program Files\iTunes\iTunes.exe"
	})
	$form_mainscreen.Controls.Add($button_itunes)

# add a button
$button_pandora = newButton "Pandora" 240 150 150 20
	$button_pandora.Add_Click({
		# Start Pandora
		StartAppxPackage *Pandora*
	})
	$form_mainscreen.Controls.Add($button_pandora)
#endregion music
	
#region combos
# add a button
$button_everything = newButton "Chrome and Outlook" 430 50 150 20
	$button_everything.Add_Click({
		# Commands to run when button is clicked
		explorer.exe shell:AppsFolder\Microsoft.Office.Desktop_8wekyb3d8bbwe!Outlook # Open Outlook
		Set-Location "C:\Program Files (x86)\Google\Chrome\Application"
		.\chrome.exe "www.facebook.com"
		sleep 1
		.\chrome.exe "/new-tab www.google.com"
	})
	$form_mainscreen.Controls.Add($button_everything)
	
# add a button
$button_everything = newButton "SYSPRO and AutoCAD" 430 100 150 20
	$button_everything.Add_Click({
		# Commands to run when button is clicked
        cd C:\SYSPRO7Client\Base\
        .\SYSPROClient.exe /WCF=PIKSSYSPRO1:1978 /BASEDIR=0 /oper=jhensley /pass=newone2 /comp=1 #Open SysPro
		Start-Process "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\AutoCAD Electrical 2018 - English\AutoCAD Electrical 2018 - English.lnk"
	})
	$form_mainscreen.Controls.Add($button_everything)
#endregion combos
	
# add a button
$button_exit = newButton "Exit (Open Nothing)" 240 250 150 20
	$button_exit.Add_Click({
		# Commands to run when button is clicked
		$form_mainscreen.Close() # close the form and exit the script
	})
	$form_mainscreen.Controls.Add($button_exit)
	
# show form
$form_mainscreen.Add_Shown({$form_mainscreen.Activate()})
[void] $form_mainscreen.ShowDialog()

# Backup Script into U Drive (at the end so drives have time to map)
Copy-Item C:\users\jhensley\Documents\StartupProgram.ps1 U:\StartupProgram.ps1 -Force

# Start-Process <filepath> will start the program(s) we want started