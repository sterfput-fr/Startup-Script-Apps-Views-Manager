# Define the path to the configuration file
$configPath = "$PSScriptRoot\config.json"

# Define the path to the log file
$logPath = "$PSScriptRoot\ssavm.log"

# Function to write to the log file
function Write-Log {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $logPath -Value "$timestamp - $message"
}

# Check if the configuration file exists
if (-Not (Test-Path $configPath)) {
    # Create a default configuration file
    $defaultConfig = @{
        MultiMonitorToolPath = "C:\Tools\MultiMonitorTool.exe"
        Applications = @(
            @{
                Name = "notepad"
                Arguments = ""
                WindowStyle = "Normal"
                Delay = 2
                Monitor = 1
            },
            @{
                Name = "calc"
                Arguments = "/m"
                WindowStyle = "Normal"
                Delay = 2
                Monitor = 2
            }
        )
    } | ConvertTo-Json -Depth 3
    Set-Content -Path $configPath -Value $defaultConfig
    Write-Log "Default configuration file created at: $configPath"
    exit
}

# Read the configuration file
$config = Get-Content -Raw -Path $configPath | ConvertFrom-Json

# Define the path to Multi Monitor Tool
$MultiMonitorToolPath = $config.MultiMonitorToolPath
# Check if MultiMonitorTool.exe exists
if (-Not (Test-Path $MultiMonitorToolPath)) {
    Write-Log "MultiMonitorTool.exe not found at: $MultiMonitorToolPath"
    exit
}

foreach ($app in $config.Applications) {
    $arguments = @{}
    if ($app.Arguments) {
        $arguments["ArgumentList"] = $app.Arguments
    }
    if ($app.WindowStyle) {
        $arguments["WindowStyle"] = $app.WindowStyle
    }
    try {
        # Start the application
        Start-Process $app.Name @arguments
        Start-Sleep -Seconds $app.Delay
        # Move the application window to the specified monitor
        Start-Process $MultiMonitorToolPath -ArgumentList "/MoveWindow", $app.Monitor, "Process", "$($app.Name).exe"
    } catch {
        # Log any errors encountered during the process
        Write-Log "Error starting or moving application $($app.Name): $_"
    }
}
