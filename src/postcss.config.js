import tailwind from 'tailwindcss'
import tailwindTypography from '@tailwindcss/typography'

export default {
  plugins: [
    tailwind({
      content: ['./.vitepress/theme/**/*.vue', './.vitepress/theme/**/*.ts'],
      darkMode: 'class',
      plugins: [tailwindTypography]
    })
  ]
}

