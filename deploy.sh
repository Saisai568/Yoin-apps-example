#!/bin/bash

# 遇到任何指令失敗時立即停止執行腳本
set -e

echo "=== Yoin Examples Deploy ==="
echo ""

echo "[1/3] Deploying Cloudflare Worker (Durable Objects)..."
pnpm --filter yoin-worker run deploy

echo "[2/3] Building Demo App (Vite)..."
pnpm --filter @yoin/demo build

echo "[3/3] Deploying to Cloudflare Pages..."
pnpm --filter @yoin/demo run deploy

echo ""
echo "=== Deploy Complete ==="
