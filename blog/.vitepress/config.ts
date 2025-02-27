import { defineConfig } from 'vitepress'
import { genFeed } from './genFeed.js'

export default defineConfig({
  title: 'Sandtracks',
  description: 'The official blog for the Melange project',
  cleanUrls: true,
  base: '/blog/',
  buildEnd: genFeed
})
