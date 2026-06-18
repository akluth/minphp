# benchmark_new.ps1
# Vergleich: neuer minphp (VM) vs echtes PHP 8.4

$iters = 150
$files = @(
    @{name="bare"; file="test_bare.php"},
    @{name="if"; file="test_if.php"},
    @{name="vars+if"; file="test_vars.php"}
)

Write-Host "=== minphp (full parser + bytecode VM) vs PHP 8.4 ===" -ForegroundColor Cyan

foreach ($f in $files) {
    Write-Host ""
    Write-Host ("--- {0} ---" -f $f.name) -ForegroundColor Yellow

    $min = Measure-Command { for ($i=0; $i -lt $iters; $i++) { .\minphp.exe $f.file > $null } }
    $php = Measure-Command { for ($i=0; $i -lt $iters; $i++) { php $f.file > $null } }

    $m = $min.TotalMilliseconds / $iters
    $p = $php.TotalMilliseconds / $iters

    Write-Host ("minphp VM : {0,6:N2} ms/call" -f $m)
    Write-Host ("php 8.4   : {0,6:N2} ms/call" -f $p)
    Write-Host ("Speedup   : {0,4:N1}x" -f ($p / $m)) -ForegroundColor Green
}

Write-Host ""
Write-Host "Der eigentliche Interpreter (Bytecode-VM) ist winzig und sehr schnell."
Write-Host "Der große Gewinn kommt vom Weglassen des gesamten PHP-Runtime-Overheads."
