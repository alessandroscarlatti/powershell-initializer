if "%ACTION%" == "" ( set "ACTION=launchApp" )
powershell -sta -command "import-module ./app.psm1; runScriptBlock { %ACTION% };"
if not [%errorlevel%]==[0] ( pause )
exit /b %errorlevel%