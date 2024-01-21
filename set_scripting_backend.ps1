param (
    [string]$projectSettingsPath, 
    [string]$platform,
    [int]$num
)
if ($platform -like "Standalone*") {
    $platform = "Standalone";
}
$contents = Get-Content -Path $projectSettingsPath;
$contentsList = [System.Collections.ArrayList]@($contents);
for ($i = 0; $i -lt $contentsList.Count; $i++) { 
    if ($contentsList[$i] -match "scriptingBackend:") {
        $contentsList.RemoveAt($i); 
        while ($i -lt $contentsList.Count -and $contentsList[$i] -match "^\s{4}") {
            $contentsList.RemoveAt($i);
        }
        break;
    } 
}
$contentsList.Add("  scriptingBackend:")
$contentsList.Add("    $platform" + ": $num")
$contentsList | Set-Content -Path $projectSettingsPath;
