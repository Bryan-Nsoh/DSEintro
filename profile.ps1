# Name: Bryan Nsoh
# Fun Fact: I had 2 sets of wisdom teeth.
#
# Virtual Index Card (PowerShell)
# - Prints a brief profile
# - Computes simple word/letter stats from favorite classes
# - Generates a small study plan over N days

param(
    [string[]]$Classes = @(
        'Creative Writing: Fiction',
        'Creative Writing: Comedy',
        'Computer Architecture'
    ),
    [int]$StudyMinutesPerDay = 45,
    [int]$Days = 5,
    [int]$Seed
)

function Get-WordStats {
    param([string[]]$Texts)
    $stop = @('the','and','of','to','a','in','for','on','with','is','at','by','an','be','this','that','from')
    $words = $Texts -join ' ' -replace "[^A-Za-z'\- ]"," " -split '\s+' | Where-Object { $_ -and ($_ -notin $stop) }
    $total = $words.Count
    $freq = $words | Group-Object | Sort-Object Count -Descending
    $top = $freq | Select-Object -First 5 | ForEach-Object { [PSCustomObject]@{ Word=$_.Name; Count=$_.Count } }
    [PSCustomObject]@{
        TotalWords  = $total
        UniqueWords = ($freq.Count)
        TopWords    = $top
    }
}

function Get-LetterFrequency {
    param([string[]]$Texts)
    $letters = ($Texts -join '').ToLower() -replace "[^a-z]",""
    $arr = $letters.ToCharArray() | ForEach-Object { [string]$_ }
    $freq = $arr | Group-Object | Sort-Object Count -Descending
    $freq | Select-Object -First 5 | ForEach-Object { [PSCustomObject]@{ Letter=$_.Name; Count=$_.Count } }
}

function New-StudyPlan {
    param(
        [string[]]$Classes,
        [int]$Days,
        [int]$Minutes,
        [int]$Seed
    )
    if ($Seed) { Get-Random -SetSeed $Seed | Out-Null }
    $today = [DateTime]::Today
    $plan = for ($i=0; $i -lt $Days; $i++) {
        $date = $today.AddDays($i)
        $pick = Get-Random -Minimum 0 -Maximum $Classes.Count
        [PSCustomObject]@{
            Date    = $date.ToString('yyyy-MM-dd (ddd)')
            Class   = $Classes[$pick]
            Minutes = $Minutes
        }
    }
    $plan
}

# Profile object
$profile = [PSCustomObject]@{
    Name           = 'Bryan Nsoh'
    FunFact        = 'I had 2 sets of wisdom teeth.'
    Background     = 'Interested in building data tools and AI-assisted analysis; enjoys creative writing and computer systems.'
    FavoriteClasses= $Classes
}

Write-Host '=== Virtual Index Card ===' -ForegroundColor Cyan
$profile | Format-List | Out-Host

Write-Host "`n=== Text Stats (from favorite classes) ===" -ForegroundColor Cyan
$ws = Get-WordStats -Texts $Classes
"Total words: {0}" -f $ws.TotalWords | Out-Host
"Unique words: {0}" -f $ws.UniqueWords | Out-Host
"Top words:" | Out-Host
$ws.TopWords | Format-Table -AutoSize | Out-Host

Write-Host "`nTop letters:" -ForegroundColor Gray
Get-LetterFrequency -Texts $Classes | Format-Table -AutoSize | Out-Host

Write-Host "`n=== Study Plan ===" -ForegroundColor Cyan
New-StudyPlan -Classes $Classes -Days $Days -Minutes $StudyMinutesPerDay -Seed $Seed | Format-Table -AutoSize | Out-Host

Write-Host "`nTip: Run with -Seed 42 for a repeatable plan." -ForegroundColor DarkGray
