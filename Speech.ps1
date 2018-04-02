Add-Type -AssemblyName System.speech
$voice=New-Object System.Speech.Synthesis.SpeechSynthesizer
$hostname=hostname
$date=Get-Date
$voice.Speak("Hello. My name is $hostname. It is $date.")
