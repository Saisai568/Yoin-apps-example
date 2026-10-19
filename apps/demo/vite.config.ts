// apps/demo/vite.config.ts
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import { yoinViteConfig, yoinVitePlugin } from '@yoin/client/vite';
import { resolve } from 'path';

export default defineConfig({
  ...yoinViteConfig(),
  plugins: [
    ...yoinVitePlugin(),
    react()
  ],
  build: {
    target: 'esnext',
    rollupOptions: {
      input: {
        index: resolve(__dirname, 'index.html'),
        react: resolve(__dirname, 'react.html'),
      },
    },
  },
});