$subred = (Get-NetRoute -DestinationPrefix 0.0.0.0/0).NextHop
Write-Host "GATEWAY: " $subred

$portstoscan = @(20,21,22,23,25,50,51,53,80,110,119,135,136,137,138,139,143,161,162,389,443,445,636,1025,1443,3389,5985,5986,8080,10000)
$waittime = 100

$rango = $subred.Substring(0,$subred.IndexOf('.') + 1 + $subred.Substring($subred.IndexOf('.') + 1).IndexOf('.') + 3)
echo $rango

$punto = $rango.EndsWith('.')
if ($punto -like "False")
{
    $rango = $rango + '.'
}

$rango_ip = @(1..254)

foreach ($r in $rango_ip)
{
    $actual = $rango +$r
    $responde = Test-Connection $actual -Quiet -Count 1
    if($responde -eq "True")
    {
        Write-Output ""
        Write-Host "Host responde: " -NoNewline ; Write-Host $actual -ForegroundColor Green

        #####################
        foreach ($p in $portstoscan)
        {
            $TCPObject = new-object System.Net.Sockets.TcpClient
            try{ $resultado = $TCPObject.ConnectAsync($actual,$p).Wait($waittime)}catch{}
            if($resultado -eq "True")
            {
            Write-Host "Puerto abierto: " -NoNewline ; Write-Host $p -ForegroundColor Green
            }   
        }
    



    }
}
