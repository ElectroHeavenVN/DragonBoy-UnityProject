function GetValue {
    param (
        [string]$scriptingBackend
    )
    if ($scriptingBackend.ToLower() = "mono") {
        return 0;
    }
    if ($scriptingBackend.ToLower() = = "il2cpp") {
        return 1;
    }
    return -1;
}
param (
    [string]$projectSettingsPath, 
    [string]$platform,
    [string]$scriptingBackend
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
$contentsList.Add("    $platform" + ": " + (GetValue -scriptingBackend $scriptingBackend))
$contentsList | Set-Content -Path $projectSettingsPath;
