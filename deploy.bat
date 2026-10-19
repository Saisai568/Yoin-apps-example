@echo off
echo === Yoin Examples Deploy ===
echo.

echo [1/3] Deploying Cloudflare Worker (Durable Objects)...
call pnpm --filter yoin-worker run deploy
if %errorlevel% neq 0 exit /b %errorlevel%

echo [2/3] Building Demo App (Vite)...
call pnpm --filter @yoin/demo build
if %errorlevel% neq 0 exit /b %errorlevel%

echo [3/3] Deploying to Cloudflare Pages...
call pnpm --filter @yoin/demo run deploy
if %errorlevel% neq 0 exit /b %errorlevel%

echo.
echo === Deploy Complete ===
pause