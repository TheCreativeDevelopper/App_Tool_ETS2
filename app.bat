@echo off
:: ------------------------------------------------------------------------------------------------
set LogPath=%cd%\Logs
set DataPath=%cd%\Data
set ExportPath=%cd%\Exported Files

set AppPathEXE=%DataPath%\Apps\EXE
set AppPathCMD=%DataPath%\Apps\CMD

set DefaultPath=%ProgramFiles(x86)%\Steam\steamapps\common\Euro Truck Simulator 2
:: ------------------------------------------------------------------------------------------------

if not EXIST "%LogPath%\" mkdir "%LogPath%"
if not EXIST "%ExportPath%\Games Files\" mkdir "%ExportPath%\Games Files\"


goto :Main

goto:eof
:Main
    cls
    Title ETS 2 Modding Tools ^| Version Alpha
    call %DataPath%\Misc\func.bat :PrintLogo

    echo.
    call %DataPath%\Misc\func.bat :PrintTitleCat "Outils Principales"
    echo 1. SXC Extractor
    echo 2. Converter Pix
    call %DataPath%\Misc\func.bat :PrintLine
    echo.
    choice /C 123 /N /M "Quelle outil, souhaitez-vous lancer :"
    if %errorlevel% == 1 goto :MenuSXCextractor
    if %errorlevel% == 3 goto :MenuConverterPix
goto:eof
:: ------------------------------------------------------------------------------------------------
goto:eof
:MenuSXCextractor
    cls
    call %DataPath%\Misc\func.bat :PrintLogo
    Title ETS 2 Modding Tools ^| Version Alpha ^| Extracteur

    echo Pour utiliser cette outil, vous devez possŠder le jeu.
    echo Recherche dossier par d‚fault: %DefaultPath%
    echo.

    if exist %DefaultPath% (
        echo Dossier ETS trouv‚: %DefaultPath%
        echo.
    ) else (
        choice /C YN /M "PossŠdez-vous le jeu dans un autre dossier ?"
        if %errorlevel% == 1 set /p %DefaultPath%=Glissez-d‚poser le dossier dans la fenetre : 

        if not exist "%DefaultPath%\base.scs" (
            echo Le dossier fourni est invalide ^!
        ) else (
            echo Le dossier est valide, vous pouvez utiliser l'outil ^!
            echo.
        )
    )
    call %DataPath%\Misc\func.bat :PrintTitleCat Actions
    echo.
    echo 1. Extraire la base
    echo 2. Extraire un fichier SCS
    echo 3. Retourner au menu Pr‚cedent

    choice /C 123 /N /M "Que voulez-faire ?"
    if %errorlevel% == 1 goto :SXC_Extract_ALL
    if %errorlevel% == 2 goto :SXC_Extract_SCS
    if %errorlevel% == 3 goto :Main
goto:eof

goto:eof
:RebackMenuSXC
    cls
    call %DataPath%\Misc\func.bat :PrintLogo
    Title ETS 2 Modding Tools ^| Version Alpha ^| Extracteur

    call %DataPath%\Misc\func.bat :PrintTitleCat Actions
    echo.
    echo 1. Extraire la base
    echo 2. Extraire un fichier SCS
    echo 3. Retourner au menu Pr‚cedent

    choice /C 123 /N /M "Que voulez-faire ?"
    if %errorlevel% == 1 goto :SXC_Extract_ALL
    if %errorlevel% == 2 goto :SXC_Extract_SCS
    if %errorlevel% == 3 goto :Main
goto:eof

goto:eof
:SXC_Extract_ALL
    cls
    Title ETS 2 Modding Tools ^| Version Alpha ^| SXC Extracting Files
    call %DataPath%\Misc\func.bat :PrintLogo
    call %DataPath%\Misc\func.bat :PrintTitleCat Extraction de la "base.scs"
    if not EXIST "%ExportPath%\Games Files\Base\" mkdir "%ExportPath%\Games Files\Base\"
    "%AppPathCMD%\sxc\sxc64.exe" -o "%ExportPath%\Games Files\Base" "%DefaultPath%\base.scs" >> %LogPath%\Extract%DATE:~6,4%_%DATE:~3,2%_%DATE:~0,2%__%TIME:~0,2%_%TIME:~3,2%_%TIME:~6,2%.log
    goto :RebackMenuSXC
goto:eof

goto:eof
:SXC_Extract_SCS
    cls
    Title ETS 2 Modding Tools ^| Version Alpha ^| SXC Extracting Files
    call %DataPath%\Misc\func.bat :PrintLogo
    call %DataPath%\Misc\func.bat :PrintTitleCat Extraction de la "base.scs"
    
    set /p NameFolder=Quel sera le nom du dossier d'extraction ?: 
    set ExportFolder=%ExportPath%\Others Files\%NameFolder%
    if not exist "%ExportFolder%" mkdir "%ExportFolder%\"
    echo.
    echo Une fenetre de selection du fichier, va apparaitre !
    pause "test"
    "%AppPathCMD%\sxc\sxc64.exe" -i -o "%ExportFolder%" >> %LogPath%\Extract-%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%.log
    goto :RebackMenuSXC
goto:eof
:: ------------------------------------------------------------------------------------------------
goto:eof
:MenuConverterPix
    cls
    call %DataPath%\Misc\func.bat :PrintLogo
    echo.
    echo Pour utiliser cette outil, vous devez avoir 2 dossiers:
    echo.   1. Un dossier Base, contenant les fichiers du jeu extrait provenant du fichier "base.scs"
    echo.   2. Un dossier d'export, ou ce chargera l'outil d'exporter les fichiers que vous pourrez ensuite utiliser.
    echo.
    echo. Glissez-d‚posez le dossier dans l'application, pour r‚cuperer votre dossier extrait "base":
    set /p DossierBase=
    echo.
    echo. Enfin glissez-d‚poser votre dossiers ou sera extrait, vos fichiers export‚es :
    set /p DossierExtraction=
    echo.
    echo. Veuillez renseigner le nom du Projet (nom utilis‚e pour le dossier d'extraction [Exemple: base_exp])
    set /p NomProjet=
    echo.
    echo. %DossierBase% et %DossierExtraction%
    pause
    cmd /k "%AppPathCMD%\converter_pix -b %DossierBase% -e %DossierExtraction%\%NomProjet%"
    pause
goto:eof


