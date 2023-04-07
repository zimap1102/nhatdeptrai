$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date)  -RepetitionInterval (New-TimeSpan -Minutes 1);
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -NonInteractive -Command New-Item -ItemType File -Value nhatne -Path $env:USERPROFILE\Desktop\test.txt";
Register-ScheduledTask -TaskName "CreateTextFileTask" -Trigger $trigger -Action $action;
