# Yoin 範例應用程式

此 repository 集中放置 Yoin 的可執行範例與 Cloudflare Worker，
核心 SDK 則位於 [`Yoin`](https://github.com/Saisai568/Yoin)。

## 內容

- `apps/demo`：Vite + Vanilla/React demo
- `apps/api-test`：瀏覽器 API 覆蓋測試應用程式
- `examples/reference-handover`：使用已封裝 SDK 的 React 範例
- `yoin-worker`：Cloudflare Durable Object WebSocket relay
- `server`：舊版本地 WebSocket 測試伺服器

## 安裝與執行

需求：Node.js >= 18、pnpm >= 9。套件封裝檔位於 `vendor/`，因此不需要
把範例加入核心 repository 的 pnpm workspace。

```bash
pnpm install
```

## 本地開發

開發模式的 demo 使用本地 WebSocket relay：
`ws://localhost:8080`。這個設定位於
`apps/demo/.env.development`，因此本地 demo 不會連到 Production Worker。

請開兩個終端機：

```bash
# 終端機 1：啟動本地 relay server
pnpm dev:local-server

# 終端機 2：啟動 demo
pnpm dev:demo
```

瀏覽器開啟 Vite 顯示的網址，常用網址為
`http://localhost:5173/?room=local-test`。相同 `room` 的本地分頁會
互相同步，但不會與線上 Production 房間同步。

若要切換本地 relay 的位置，修改
`apps/demo/.env.development`：

```env
VITE_YOIN_WORKER_URL=ws://localhost:8080
```

修改環境變數後必須重新啟動 Vite。

## Production 建置

Production Worker 設定位於 `apps/demo/.env.production`：

```env
VITE_YOIN_WORKER_URL=wss://yoin-worker.xxxxxxxx.workers.dev
```

執行以下指令時，Vite 會使用 Production mode：

```bash
pnpm build:demo
```

`pnpm dev:demo` 與 `pnpm build:demo` 使用的 server 不同：

| 指令 | Server |
| --- | --- |
| `pnpm dev:demo` | `ws://localhost:8080` |
| `pnpm build:demo` | `wss://yoin-worker.xxxxxxxx.workers.dev` |

如果要測試 Production Worker，可使用已部署的網站，或明確以
Production mode 啟動 Vite：

```bash
pnpm --filter @yoin/demo exec vite --mode production
```

Worker 可獨立啟動：

```bash
pnpm --filter yoin-worker dev
```

部署前請先在 `yoin-worker` 設定 Cloudflare 帳號與 Durable Object
環境，再執行：

```bash
pnpm --filter yoin-worker deploy
```
