### <application>
###   <name>CPing</name>
###   <version>1.0.0</version>
###   <date>October 7, 2013</date>
###   <author>Johan Cyprich<author>
###   <author_email>jcyprich@live.com</author_email>
###   <license URL="http://opensource.org/licenses/mit-license.php">
###   The MIT License (MIT)
###
###   Copyright (c) 2013 Johan Cyprich. All rights reserved.
###
###   Permission is hereby granted, free of charge, to any person obtaining a copy 
###   of this software and associated documentation files (the "Software"), to deal
###   in the Software without restriction, including without limitation the rights
###   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
###   copies of the Software, and to permit persons to whom the Software is
###   furnished to do so, subject to the following conditions:
###
###   The above copyright notice and this permission notice shall be included in
###   all copies or substantial portions of the Software.
###
###   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
###   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
###   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
###   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
###   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
###   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
###   THE SOFTWARE.
###   </license>
### </application>
###
### <summary>
### Pings an IP continuously and returns the result. User must press the break key
### to exit the program.
### </summary>

param
(
  [string] $ip               # IP to be pinged
)

[int] $delay = 1             # the number of seconds paused between a ping

while (1)
{ 
  $PingStatus = Gwmi Win32_PingStatus -Filter "Address ='$ip'" | Select-Object StatusCode 

  [string] $currentDate = Get-Date
  
  # Display help screen if no IP is specified in command line.
  
  if ($ip -eq "")
  {
    Write-Host ""
    Write-Host "CPing 1.0.0" -ForegroundColor White -BackgroundColor Black
    Write-Host "Copyright (c) 2013 Johan Cyprich. All rights reserved."
    Write-Host "Licensed under The MIT License (MIT)."
    Write-Host ""
    Write-Host "Usage: ping [IP]"
    Write-Host "Example: ping 192.168.0.1"
    Write-Host ""
    Write-Host "Press the break key (Ctrl-C) to exit the program."
    Write-Host ""
  
    break  
  }
  
  # Send a ping to the IP and display the result.
  
  if ($PingStatus.StatusCode -eq 0)
  {
    Write-Host "Reply from $ip at $currentDate" -ForegroundColor DarkGreen
  }
  
  else 
  {
    Write-Host "Request timed out on $ip at $currentDate" -BackgroundColor DarkRed -ForegroundColor White 
  }
  
  Start-Sleep -Seconds $delay
} # while (1)