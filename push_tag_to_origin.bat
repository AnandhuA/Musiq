@echo off
setlocal enabledelayedexpansion

:: Read pubspec.yaml and extract the full version number (e.g., 1.2.7)
for /f "tokens=2 delims= " %%A in ('findstr /r "^version: [0-9]\+\.[0-9]\+\.[0-9]\+" pubspec.yaml') do (
    set "VERSION=%%A"
)

:: Check if version was found
if "%VERSION%"=="" (
    echo Version not found in pubspec.yaml
    pause
    exit /b 1
)

:: Ensure we are capturing the exact version number by trimming any trailing carriage return or extra space
for /f %%A in ('echo %VERSION%') do set VERSION=%%A

:: Confirm the detected version before tagging
echo Detected version: v%VERSION%

:: Create a tag with the version number
git tag -a v%VERSION% -m "Version %VERSION%"

:: Push only the tag to the origin
git push origin v%VERSION%

echo Version %VERSION% tagged and pushed to origin
