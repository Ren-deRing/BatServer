@echo off

set bver=3.0.0.0

title BatServer %bver%

chcp 65001
cls

:: Folder Name Error Check
echo ->>%~dp0\FolderTest.txt
if not exist "%~dp0\FolderTest.txt" goto foldererror
del %~dp0\FolderTest.txt

:: BatchGotAdmin
:-------------------------------------
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    echo Starting BatServer...
    echo BatServer는 관리자 권한이 필요합니다.
    echo 관리자 권한을 허용해 주세요.
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

chcp 65001
cls

:LoadMain
cls
echo ######     ##     #######            ######  #######  ######   ##   ##  #######  ######
echo ###  ##   ####    #######           #####    ##  ###  ##  ###  ##   ##  ##  ###  ##  ###
echo ###  ##  ##  ##     ###             ##       ##   ##  ###  ##   ##  ##  ##   ##  ###  ##
echo ##  ##   #######    ###              #####   ###      ######    ## ##   ###      ######
echo ##   ##  ##  ###    ###                 ###  ####     ## ##     ## ##   ####     ## ##
echo ###  ##  ### ###    ####            ###  ##  ##   ##  ### ##    #####   ##   ##  ### ##
echo ######   ### ###    ####            ######   #######  ###  ##    ###    #######  ###  ##
cd %~dp0
echo Made By Render    Copyright 2021-2022. Render All rights reserved
echo.
%~dp0\Bat-Pl\cmdclr.exe 0F
<NUL set /p=Preparing.
setlocal
<NUL set /p=.
set reqgo=%~dp0\bin\req4bat-go.exe
<NUL set /p=.
setlocal enabledelayedexpansion
<NUL set /p=.
for /f "delims=" %%a in ('"%reqgo% --url https://dummyjson.com/test --slice-json status" 2^>^&1') do (set result=%%a)
if !result! neq ok (
    set err_detail=req4bat-go test failed.
    goto error
)
<NUL set /p=.
<NUL set /p=.ok
echo.
<NUL set /p=Checking Folders..
<NUL set /p=['/'
if not exist %appdata%\BatServer (
    mkdir %appdata%\BatServer
)
<NUL set /p=, '/jar']
if not exist %appdata%\BatServer\jar (
    mkdir %appdata%\BatServer\jar
)
<NUL set /p=...ok
echo.
<NUL set /p=Loading java/bukkit version information...
for /f "delims=" %%a in ('"%reqgo% --url https://api.papermc.io/v2/projects/paper --slice-json versions" 2^>^&1') do (set result=%%a)
if !result! equ error (
    set err_detail=req4bat-go fetch data failed.
    goto error
)
echo.ok
timeout /t 1
goto main

:: Error that cannot be ignore handling function, parameter: var err_detail: string
:error
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo                                                  Error occurred!!
echo                                           ---------------------------
echo                                      처리할 수 없는 오류가 발생하였습니다.
echo                                    Erorr Detail: %err_detail%
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
pause
exit

:foldererror
cd "%~dp0"
cd..
del *.
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo                                                  실행할 수 없음
echo                                           ---------------------------
echo                                BatServer 폴더 명에 공백이 포함되어 있습니다.
echo                                     공백을 제거하고, 다시 시도하여 주세요.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
pause
exit

:: Variable Reset Function, If it end, then goto :mainr
:reset
set non1=0
set non2=0
set non3=0
set non4=0
set non5=0
set non6=0
set selmain=0
set seleula=0
set selver=0
set ram=0
set selre=0
goto mainr

:main
goto reset
:mainr
cls
echo.
echo.
if %non1%==0 echo.
if %non1%==1 echo                                         1부터 5의 숫자를 입력해 주세요.
echo.
echo.
echo.
echo.
echo                                                - BatServer 2.1¹-
echo                                           ---------------------------
echo.
echo                                        ① 서버 만들기       ② 월드 백업
echo.
echo                                        ③ 월드 복원         ④ 서버 설정
echo.
echo                                                             ⑤ 문제 해결
echo.
echo.
echo.
echo.
echo.
echo.
echo.
set /p selmain=INPUT : 
if %selmain%==1 goto mkserver
if %selmain%==2 goto bkworld
if %selmain%==3 goto reworld
if %selmain%==4 goto setserver
if %selmain%==5 goto errorrepo

set non1=1
goto mainr





:mkserver
cls
java -version
if errorlevel 1 goto javae
cls
echo.
echo.
if %non2%==0 echo.
if %non2%==1 echo                                            Y 또는 n으로 입력하여 주세요.
echo.
echo.
echo                                                      -EULA-
echo                                           ---------------------------
echo.
echo                              Mojang사의 정책에 따라, EULA에 동의하셔야 합니다.
echo                             동의하지 않으실 경우 서버 만들기를 진행할 수 없습니다.
echo.
echo                                            동의하시겠습니까? (Y/n)
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
set /p seleula=INPUT : 
if %seleula%==n goto main
if %seleula%==N goto main
if %seleula%==y goto mks
if %seleula%==Y goto mks
set non2=1
goto mkserver 

:mks
cls
echo.
echo.
if %non3%==0 echo.
if %non3%==1 echo                                       표시되어 있는 버전을 입력해 주세요.
echo.
echo.
echo.
echo.
echo                                                 -Select version-
echo                                           ---------------------------
echo.
echo                                    1.19.3           1.18.2           1.17.1
echo.
echo                                    1.16.5           1.15.2           1.14.4
echo.
echo                                    1.13.2           1.12.2           1.11.2
echo.
echo                                    1.10.2            1.9.4            1.8.8
echo.
echo.
echo.
echo.
echo.
echo.
echo.
set /p selver= INPUT : 
if %selver%==1.19.3 goto mkserver2
if %selver%==1.18.2 goto mkserver2
if %selver%==1.17.1 goto mkserver2
if %selver%==1.16.5 goto mkserver2
if %selver%==1.15.2 goto mkserver2
if %selver%==1.14.4 goto mkserver2
if %selver%==1.13.2 goto mkserver2
if %selver%==1.12.2 goto mkserver2
if %selver%==1.10.2 goto mkserver2
if %selver%==1.9.4 goto mkserver2
if %selver%==1.8.8 goto mkserver2
set non3=1
goto mks

:mkserver2
cls
echo.
echo.
if %non4%==0 echo.
if %non4%==1 echo                                       최대 입력 가능 범위는 64Gb입니다.
echo.
echo.
echo                                                -Select Memory-
echo                                           ---------------------------
echo.
echo                           1Gb ~ 64Gb 까지, 서버에 사용할 최대 RAM 용량을 입력하세요.
echo                          만약 사용자의 RAM의 총 용량보다 크거나, Java/OS가 32Bit인 경우,
echo                            RAM이 부족하거나 4Gb 이상으로 사용할 수 없을 수 있습니다.
echo.
echo                                  단위를 입력하지 마시고 숫자로 입력하여 주세요.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
set /p ram= INPUT : 
if %ram% geq 1 if %ram% leq 64 goto mkserver3
set non4=1
goto mkserver2



:mkserver3
cls
if %selver%==1.21 set vvvv=21
if %selver%==1.20.6 set vvvv=20
if %selver%==1.19.4 set vvvv=19
if %selver%==1.18.2 set vvvv=18
if %selver%==1.17.1 set vvvv=17
if %selver%==1.16.5 set vvvv=16
if %selver%==1.15.2 set vvvv=15
if %selver%==1.14.4 set vvvv=14
if %selver%==1.13.2 set vvvv=13
if %selver%==1.12.2 set vvvv=12
if %selver%==1.11.2 set vvvv=11
if %selver%==1.10.2 set vvvv=10
if %selver%==1.9.4 set vvvv=9
if %selver%==1.8.8 set vvvv=8
echo.
echo.
echo.
echo.
echo                                               -Creating a server-
echo                                           ---------------------------
echo.
echo                               서버를 생성하고 있습니다. 잠시만 기다려 주세요.
echo.
if exist %appdata%\BatServer\Jars\Paper%vvvv%.jar goto aldown
echo                                         서버를 다운로드하고 있습니다...
goto downp
:downpend

echo.
echo                                         서버 파일을 생성 중입니다...
copy %appdata%\BatServer\Jars\Paper%vvvv%.jar %~dp0\
goto mkserverend
:aldown
cls
echo.
echo.
echo.
echo.
echo                                               -Creating a server-
echo                                           ---------------------------
echo.
echo                             서버를 생성하고 있습니다. 잠시만 기다려 주세요.
echo.
echo                             이미 다운로드되어 있는 서버를 불러오는 중입니다...

copy %appdata%\BatServer\Jars\Paper%vvvv%.jar %~dp0\

echo.
echo                                          서버 파일을 생성 중입니다...
goto mkserverend

:downp
if %selver%==1.19.3 powershell "(New-Object System.Net.WebClient).DownloadFile('https://api.papermc.io/v2/projects/paper/versions/1.19.3/builds/360/downloads/paper-1.19.3-360.jar','%appdata%\BatServer\Jars\Paper19.jar')"
if %selver%==1.18.2 powershell "(New-Object System.Net.WebClient).DownloadFile('https://api.papermc.io/v2/projects/paper/versions/1.18.2/builds/386/downloads/paper-1.18.2-386.jar','%appdata%\BatServer\Jars\Paper18.jar')"
if %selver%==1.17.1 powershell "(New-Object System.Net.WebClient).DownloadFile('https://papermc.io/api/v2/projects/paper/versions/1.17.1/builds/408/downloads/paper-1.17.1-408.jar','%appdata%\BatServer\Jars\Paper17.jar')"
if %selver%==1.16.5 powershell "(New-Object System.Net.WebClient).DownloadFile('https://papermc.io/api/v2/projects/paper/versions/1.16.5/builds/794/downloads/paper-1.16.5-794.jar','%appdata%\BatServer\Jars\Paper16.jar')"
if %selver%==1.15.2 powershell "(New-Object System.Net.WebClient).DownloadFile('https://papermc.io/api/v2/projects/paper/versions/1.15.2/builds/393/downloads/paper-1.15.2-393.jar','%appdata%\BatServer\Jars\Paper15.jar')"
if %selver%==1.14.4 powershell "(New-Object System.Net.WebClient).DownloadFile('https://papermc.io/api/v2/projects/paper/versions/1.14.4/builds/245/downloads/paper-1.14.4-245.jar','%appdata%\BatServer\Jars\Paper14.jar')"
if %selver%==1.13.2 powershell "(New-Object System.Net.WebClient).DownloadFile('https://papermc.io/api/v2/projects/paper/versions/1.13.2/builds/657/downloads/paper-1.13.2-657.jar','%appdata%\BatServer\Jars\Paper13.jar')"
if %selver%==1.12.2 powershell "(New-Object System.Net.WebClient).DownloadFile('https://papermc.io/api/v2/projects/paper/versions/1.12.2/builds/1620/downloads/paper-1.12.2-1620.jar','%appdata%\BatServer\Jars\Paper12.jar')"
if %selver%==1.11.2 powershell "(New-Object System.Net.WebClient).DownloadFile('https://papermc.io/api/v2/projects/paper/versions/1.11.2/builds/1106/downloads/paper-1.11.2-1106.jar','%appdata%\BatServer\Jars\Paper11.jar')"
if %selver%==1.10.2 powershell "(New-Object System.Net.WebClient).DownloadFile('https://papermc.io/api/v2/projects/paper/versions/1.10.2/builds/918/downloads/paper-1.10.2-918.jar','%appdata%\BatServer\Jars\Paper10.jar')"
if %selver%==1.9.4 powershell "(New-Object System.Net.WebClient).DownloadFile('https://papermc.io/api/v2/projects/paper/versions/1.9.4/builds/775/downloads/paper-1.9.4-775.jar','%appdata%\BatServer\Jars\Paper9.jar')"
if %selver%==1.8.8 powershell "(New-Object System.Net.WebClient).DownloadFile('https://papermc.io/api/v2/projects/paper/versions/1.8.8/builds/445/downloads/paper-1.8.8-445.jar','%appdata%\BatServer\Jars\Paper8.jar')"
goto downpend



:mkserverend
del Start-Server.bat
echo @echo off>> Start-Server.bat
echo echo Starting Server...>> Start-Server.bat
echo java -jar -Xmx%ram%G Paper%vvvv%.jar>> Start-Server.bat
echo pause>> Start-Server.bat
echo exit>> Start-Server.bat
echo eula=true>> eula.txt
cls
echo.
echo.
echo.
echo.
echo                                               -Server is created!-
echo                                           ---------------------------
echo.
echo                                          서버 만들기가 완료되었습니다.
echo                         서버 폴더의 [ Start-Server.bat ] 으로 서버를 실행할 수 있습니다.
timeout /t 10 > NUL
goto main




:bkworld
cls
set bakdic=%~dp0\BackUp\
if not exist %~dp0\BackUp\ mkdir %~dp0\BackUp\
echo.
echo.
if exist %~dp0\world echo.
if not exist %~dp0\world echo                                       월드 폴더가 존재하지 않습니다.
if not exist %~dp0\world timeout /t 3
if not exist %~dp0\world goto main
echo.
echo.
echo                                                     -Backup-
echo                                           ---------------------------
echo.
echo               월드를 압축하고 있습니다... 월드 용량에 따라, 시간이 많이 걸릴 수 있습니다.
%~dp0\Bat-Pl\zip -9vrq backup.zip world
%~dp0\Bat-Pl\zip -9vrq backuphell.zip world_nether
%~dp0\Bat-Pl\zip -9vrq backupend.zip world_the_end
echo.
echo                                          압축 파일을 후처리 중입니다...
rename backup.zip %date:~10,4%.%date:~4,2%.%date:~7,2%_Backup_world.zip
rename backuphell.zip %date:~10,4%.%date:~4,2%.%date:~7,2%_Backup_nether.zip
rename backupend.zip %date:~10,4%.%date:~4,2%.%date:~7,2%_Backup_the_end.zip
if %bakdic%==%~dp0\BackUp if not exist %~dp0\BackUp mkdir %~dp0\BackUp
mkdir %bakdic%\%date:~10,4%.%date:~4,2%.%date:~7,2%_BackUp
move %date:~10,4%.%date:~4,2%.%date:~7,2%*.zip %bakdic%\%date:~10,4%.%date:~4,2%.%date:~7,2%_BackUp
echo.
echo                                              월드를 백업했습니다.
start %bakdic%\%date:~10,4%.%date:~4,2%.%date:~7,2%_BackUp
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
pause
goto main




:reworld
cls
echo.
echo.
if %non5%==0 echo.
if %non5%==1 echo                                           Y 또는 n으로 입력하여 주세요.
echo.
echo.
echo                                                    -Restore-
echo                                           ---------------------------
echo.
echo                                                      경고!
echo                       월드를 불러올 경우, 기존에 존재하던 기존 월드 파일이 삭제됩니다.
echo.
echo                                            불러오시겠습니까? (Y/n)
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
set /p selre=INPUT : 
if %selre%==n goto main
if %selre%==N goto main
if %selre%==y goto reworld2
if %selre%==Y goto reworld2
set non5=1
goto reworld

:reworld2
cls
echo.
echo.
if %non6%==0 echo.
if %non6%==1 echo                                         불러올 월드가 존재하지 않습니다.
if %non6%==1 echo.
if %non6%==1 echo.
if %non6%==1 echo.
if %non6%==1 echo.
if %non6%==1 pause
if %non6%==1 goto main
echo.
echo.
echo                                                    -Restore-
echo                                           ---------------------------
echo.
echo                                     불러올 월드명을 입력하여 주세요.
echo.
echo                                             ex) 2022.xx.xx_BackUp
echo.
echo.
echo.
echo.

dir %~dp0\BackUp\%Ren%

echo.
echo.
echo.
set /p ren=INPUT : 
if exist %~dp0\BackUp\%ren% goto reworld3
set non6=1
goto reworld2


:reworld3
echo.
echo.
echo.
echo.
echo                                                    -Restore-
echo                                           ---------------------------
echo.
echo                                        월드 파일을 정리하고 있습니다...
copy %~dp0\BackUp\%ren%\*.zip %~dp0\
rename %ren%_world.zip world.zip
rename %ren%_nether.zip world_nether.zip
rename %ren%_the_end.zip world_the_end.zip
echo.
echo                                         기존 월드를 제거하고 있습니다...
rd %~dp0\world /s /q
rd %~dp0\world_nether /s /q
rd %~dp0\world_the_end /s /q
echo.
echo          월드의 압축을 풀고 있습니다... 월드의 용량에 따라 시간이 오래 걸릴 수 있습니다.
%~dp0\Bat-Pl\unzip world.zip
%~dp0\Bat-Pl\unzip world_nether.zip
%~dp0\Bat-Pl\unzip world_the_end.zip
echo.
echo                                          압축 파일을 제거하고 있습니다...
del %~dp0\world*.zip /s /q
echo.
echo                                            월드 복원을 성공했습니다.
echo.
echo.
echo.
echo.
pause
goto main



:errorrepo
cls
echo.
echo.
echo.
echo.
echo               -Error FAQ-
echo       ---------------------------
echo.
echo       겪으시는 문제 중에 이런 문제가 있나요?
echo.
echo       ① 'java'은(는) 내부 또는 외부 명령, 실행할 수 있는 프로그램, 또는 배치 파일이 아닙니다.
echo.
echo       ② Minecraft 1.1x requires running the server with Java 1x or above. [ 생략 ]
echo.
echo       ③ Error occurred during initialization of VM            Could not reserve enough space for object heap
echo.
echo       ④ Error: Unable to access jarfile xxxxxxx.jar
echo.
echo       ⑤ Unrecognized option: -xxxxxx
echo.
echo       ⑥ xxx xx, 202x x:xx:xx xM org.bukkit.craftbukkit.Main main           심각: 'xxxxx' is not a recognized option
echo.
echo       [ 존재하지 않는 숫자를 입력하여 나가기 ]
echo.
echo.
echo.
echo.
set /p errors= INPUT : 
echo.
echo.
echo.
if %errors%==1 echo     ① 이 에러는 java가 컴퓨터에 설치되지 않았거나, 시스템 PATH에 지정되지 않았을 때 발생합니다.
if %errors%==1 echo         java를 설치하시거나, 시스템 PATH에 java를 등록하여 주세요.
if %errors%==1 echo.
if %errors%==1 echo.
if %errors%==1 echo.
if %errors%==1 pause
if %errors%==2 echo     ② 이 에러는 java 버전이 마인크래프트 버전에서 쓰이는 java 버전과 다른 경우에 발생합니다.
if %errors%==2 echo         java 버전을 잘 확인하여 주세요.
if %errors%==2 echo.
if %errors%==2 echo.
if %errors%==2 echo.
if %errors%==2 pause
if %errors%==3 echo     ③ 이 에러는 서버에 지정된 Ram이 사용자의 컴퓨터에 장착된 용량보다 크거나, 32Bit에서 4Gb
if %errors%==3 echo         이상으로 지정되었을 때 발생합니다.
if %errors%==3 echo         지정된 Ram 용량을 조금만 줄여 주세요.
if %errors%==3 echo.
if %errors%==3 echo.
if %errors%==3 echo.
if %errors%==3 pause
if %errors%==4 echo     ④ 이 에러는 버킷이 실행 파일과 다른 경우에 발생합니다.
if %errors%==4 echo         버킷 파일 이름과 실행 파일에 있는 버킷 파일 이름을 맞춰 주세요.
if %errors%==4 echo.
if %errors%==4 echo.
if %errors%==4 echo.
if %errors%==4 pause
if %errors%==5 echo     ⑤ 이 에러는 java 실행 옵션이 존재하지 않을 경우에 발생합니다.
if %errors%==5 echo         의심되는 실행 옵션을 지워주세요.
if %errors%==5 echo.
if %errors%==5 echo.
if %errors%==5 echo.
if %errors%==5 pause
if %errors%==6 echo     ⑥ 이 에러는 버킷 실행 옵션이 존재하지 않을 경우에 발생합니다.
if %errors%==6 echo         의심되는 실행 옵션을 지워주세요.
if %errors%==6 echo.
if %errors%==6 echo.
if %errors%==6 echo.
if %errors%==6 echo.
if %errors%==6 pause
goto main

:javae
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo                                            만들기를 진행할 수 없음
echo                                           ---------------------------
echo.
echo                             사용자의 컴퓨터에 자바가 설치되어 있지 않습니다.
echo                                   자바를 설치하고, 다시 시도하여 주세요.
echo.
echo                       1.17의 경우엔, Java 16, 1.18~의 경우엔 Java 17이 필요합니다.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
pause
goto main

:setserver
cls
goto main
echo.
echo.
if %non1%==0 echo.
if %non1%==1 echo                                         1부터 4의 숫자를 입력해 주세요.
echo.
echo.
echo.
echo.
echo                                                - Setting Menu-
echo                                           ---------------------------
echo.
echo                                        ① 서버 설정         ② 플러그인
echo.
echo                                        ③ 상세 설정         ④ 도움말
echo.
echo.
echo.
echo.
echo.
echo.
echo.
set /p selset=INPUT : 
if %selset%==1 goto proto
if %selset%==2 goto plugin
if %selset%==3 goto moreset
if %selset%==4 goto info