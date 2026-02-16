@echo off
echo Starting the Magic Garden Local Server...
echo.
echo Make sure you have Python installed!
echo.
start "" "http://localhost:8000"
python -m http.server 8000
pause
