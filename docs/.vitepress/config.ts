import { defineConfig } from '@cordisjs/vitepress'
import UnoCSS from 'unocss/vite'
import sidebar from "./config/sidebar.json"
import configjson from "./config/config.json"

const config = {
  ...configjson,
  vite: {
    plugins: [UnoCSS()],
    optimizeDeps: {
      exclude: ['@cordisjs/vitepress'],
    },
  },
  themeConfig: {
    ...configjson.themeConfig,
    sidebar: sidebar,
  },
}

export default defineConfig(config as any)
