#Set environment variables
$env:VIRTUAL_ENV_DISABLE_PROMPT = 1

### OhMyPosh Init
oh-my-posh init pwsh --config 'C:\Users\Dmitry\AppData\Local\Programs\oh-my-posh\themes\takuya.omp.copy.json' | Invoke-Expression

### Modules
# Icons
Import-Module Terminal-Icons
# PSReadLine
Import-Module PSReadLine
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

### Functions
function md5 { Get-FileHash -Algorithm MD5 $args }
function sha1 { Get-FileHash -Algorithm SHA1 $args }
function sha256 { Get-FileHash -Algorithm SHA256 $args }

function dirs {
    if ($args.Count -gt 0)
    {
        Get-ChildItem -Recurse -Include "$args" | Foreach-Object FullName
    }
    else
    {
        Get-ChildItem -Recurse | Foreach-Object FullName
    }
}

function ll {
    Get-ChildItem -Path $pwd -File
}

function whereis ($name) {
	Get-Command $name | Format-Table Path, Name
}

function Get-PubIP {
    (Invoke-WebRequest http://ifconfig.me/ip ).Content
}

function uptime {
    Get-WmiObject win32_operatingsystem | select csname, @{LABEL='LastBootUpTime';
    EXPRESSION={$_.ConverttoDateTime($_.lastbootuptime)}}
}

function reload-profile {
    & $profile
}

function find-file($name) {
    ls -recurse -filter "*${name}*" --ErrorAction SilentlyContinue | foreach {
        $place_path = $_.directory
        echo "${place_path}\${_}"
    }
}

function grep ($regex, $dir) {
    if ( $dir ) {
        ls $dir | select-string $regex
        return
    }
    $input | select-string $regex
}

function touch($file) {
    "" | Out-File $file -Encoding ASCII
}

function df {
    get-volume
}

function export($name, $value) {
    set-item -force -path "env:$name" -value $value;
}

function pkil($name) {
    ps $name -ErrorAction SilentlyContinue | kill
}

function pgrep($name) {
    ps $name
}

function which ($name) {
	Get-Command $name -ErrorAction SilentlyContinue |
	Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function .. {
	cd..
}

function lz {
    eza -lF
}

function la {
    eza -la
}

function ffp ($FileName) {
    ffprobe -hide_banner $FileName
}

function cm-cd {
    cd $(chezmoi source-path)
}

### Aliases
Set-Alias g git
Set-Alias aria aria2c
Set-Alias cm chezmoi
