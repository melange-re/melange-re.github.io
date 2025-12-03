import path from 'path'
import { writeFileSync, mkdirSync } from 'fs'
import { Feed } from 'feed'
import { createContentLoader, type SiteConfig } from 'vitepress'

const baseUrl = `https://melange.re/blog`

export async function genFeed(config: SiteConfig) {
  const feed = new Feed({
    title: 'Sandtracks',
    description: 'The official blog for the Melange project',
    id: baseUrl,
    link: baseUrl,
    language: 'en',
    copyright:
      'Copyright (c) 2021-present, Melange blog contributors'
  })

  const posts = await createContentLoader('blog/posts/*.md', {
    excerpt: true,
    render: true
  }).load()

  posts.sort(
    (a, b) =>
      +new Date(b.frontmatter.date as string) -
      +new Date(a.frontmatter.date as string)
  )

  for (const { url, excerpt, frontmatter, html } of posts) {
    // URL from createContentLoader is like /blog/posts/xxx
    // We want the final URL to be https://melange.re/blog/posts/xxx
    const postUrl = url.startsWith('/blog') ? url : `/blog${url}`
    feed.addItem({
      title: frontmatter.title,
      id: `https://melange.re${postUrl}`,
      link: `https://melange.re${postUrl}`,
      description: excerpt,
      content: html?.replaceAll('&ZeroWidthSpace;', ''),
      author: [
        {
          name: frontmatter.author,
          link: frontmatter.twitter
            ? `https://twitter.com/${frontmatter.twitter}`
            : undefined
        }
      ],
      date: frontmatter.date
    })
  }

  // Write feed.rss to the blog directory within the output
  const blogOutDir = path.join(config.outDir, 'blog')
  mkdirSync(blogOutDir, { recursive: true })
  writeFileSync(path.join(blogOutDir, 'feed.rss'), feed.rss2())
}
