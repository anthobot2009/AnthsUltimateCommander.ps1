Anths Ultimate Commander v2 - PowerShell GUI Script

Includes advanced optimization, FPS mode, restore point, network tweaks, Defender toggle, and more

Add-Type -AssemblyName PresentationFramework

function Show-Message { param([string]$msg) [System.Windows.MessageBox]::Show($msg, "Anths Ultimate Commander v2") }

function Create-RestorePoint { Checkpoint-Computer -Description "Anths Restore V2" -RestorePointType "MODIFY_SETTINGS" Show-Message "✅ Restore Point Created!" }

function Enable-UltimatePowerPlan { $guid = (powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61).Split()[3] powercfg -changename $guid "Anthony's Power Plan V2" powercfg -setactive $guid Show-Message "⚡ Ultimate Power Plan Activated" }

function Clean-System { Get-ChildItem -Path "$env:TEMP" -Recurse -Force | Remove-Item -Force -ErrorAction SilentlyContinue Remove-Item "C:\Windows\Temp*" -Recurse -Force -ErrorAction SilentlyContinue Remove-Item "C:\Windows\Prefetch*" -Recurse -Force -ErrorAction SilentlyContinue wevtutil cl Application wevtutil cl System Show-Message "🧹 System Cleaned" }

function Remove-Bloatware { $apps = @( "Microsoft.XboxApp", "Microsoft.XboxGamingOverlay", "Microsoft.YourPhone", "Microsoft.MixedReality.Portal", "Microsoft.GetHelp", "Microsoft.ZuneMusic", "Microsoft.ZuneVideo", "Microsoft.Microsoft3DViewer" ) foreach ($app in $apps) { Get-AppxPackage -Name $app | Remove-AppxPackage -ErrorAction SilentlyContinue } Show-Message "🧨 Bloatware Removed" }

function Kill-BackgroundServices { $services = @("WSearch", "SysMain", "DiagTrack", "Fax", "PrintSpooler") foreach ($svc in $services) { Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue Set-Service -Name $svc -StartupType Disabled } Show-Message "🔧 Background Services Disabled" }

function Enable-FPSBoost { powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 100 powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMIN 100 powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PERFBOOSTMODE 2 powercfg -setactive SCHEME_CURRENT Show-Message "🎮 FPS Boost Enabled" }

function Optimize-Network { New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name NetworkThrottlingIndex -PropertyType DWord -Value 0xffffffff -Force | Out-Null New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\MSMQ\Parameters" -Name TCPNoDelay -PropertyType DWord -Value 1 -Force | Out-Null Show-Message "📶 Network Tweaks Applied" }

function Disable-WindowsDefender { Set-MpPreference -DisableRealtimeMonitoring $true -ErrorAction SilentlyContinue Show-Message "🛡 Windows Defender Disabled (temp)" }

function Silent-ApplyAll { Create-RestorePoint Enable-UltimatePowerPlan Clean-System Remove-Bloatware Kill-BackgroundServices Enable-FPSBoost Optimize-Network Disable-WindowsDefender Show-Message "✅ All Optimizations Applied" }

[xml]$xaml = @" <Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
Title="Anths Ultimate Commander v2" Height="640" Width="480"
WindowStartupLocation="CenterScreen"> <Window.Resources> <Style TargetType="Button"> <Setter Property="FontSize" Value="15"/> <Setter Property="Margin" Value="5"/> <Setter Property="Height" Value="40"/> </Style> </Window.Resources> <StackPanel Background="#1e1e1e" Margin="15"> <TextBlock Text="Anths Ultimate Commander v2" FontSize="22" Foreground="White" HorizontalAlignment="Center" Margin="10"/> <Button Content="🛡 Create Restore Point" Name="btnRestore"/> <Button Content="⚡ Ultimate Power Plan" Name="btnPower"/> <Button Content="🧹 Clean System Files" Name="btnClean"/> <Button Content="🧨 Remove Bloatware" Name="btnBloat"/> <Button Content="🔧 Disable Background Services" Name="btnServices"/> <Button Content="🎮 Enable FPS Boost Mode" Name="btnFPS"/> <Button Content="📶 Optimize Network" Name="btnNetwork"/> <Button Content="🛡 Disable Defender (Temp)" Name="btnDefender"/> <Button Content="🚀 Apply All Optimizations (Silent)" Name="btnApplyAll"/> <Button Content="❌ Exit" Name="btnExit"/> </StackPanel> </Window> "@

$reader = (New-Object System.Xml.XmlNodeReader $xaml) $window = [Windows.Markup.XamlReader]::Load($reader)

$btnRestore   = $window.FindName("btnRestore") $btnPower     = $window.FindName("btnPower") $btnClean     = $window.FindName("btnClean") $btnBloat     = $window.FindName("btnBloat") $btnServices  = $window.FindName("btnServices") $btnFPS       = $window.FindName("btnFPS") $btnNetwork   = $window.FindName("btnNetwork") $btnDefender  = $window.FindName("btnDefender") $btnApplyAll  = $window.FindName("btnApplyAll") $btnExit      = $window.FindName("btnExit")

$btnRestore.Add_Click({ Create-RestorePoint }) $btnPower.Add_Click({ Enable-UltimatePowerPlan }) $btnClean.Add_Click({ Clean-System }) $btnBloat.Add_Click({ Remove-Bloatware }) $btnServices.Add_Click({ Kill-BackgroundServices }) $btnFPS.Add_Click({ Enable-FPSBoost }) $btnNetwork.Add_Click({ Optimize-Network }) $btnDefender.Add_Click({ Disable-WindowsDefender }) $btnApplyAll.Add_Click({ Silent-ApplyAll }) $btnExit.Add_Click({ $window.Close() })

$window.ShowDialog()

