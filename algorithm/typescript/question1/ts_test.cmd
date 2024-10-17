@echo off

for /f "tokens=1-5 delims=/-: " %%a in ('date /t') do set current_date=%%c/%%a/%%b
for /f "tokens=1-5 delims=/-: " %%a in ('time /t') do set current_time=%%a
echo %current_date% %current_time%

:: コーディングルールをチェック
npm run lint

for %%i in (1 2 3 4 5) do (
    type .\input\input%%i | ..\node_modules\.bin\ts-node index.ts > .\output

    :: 差分がなければOKを表示
    fc .\expected\expected%%i .\output >nul
    if %ERRORLEVEL% EQU 0 (
        echo テストパターン%%i: OK！
    ) else (
        echo テストパターン%%i: NO！
    )
)

del .\output
