<script setup lang="ts">
import { data as posts } from './posts.data.js'
import { useData, withBase } from 'vitepress'

const { frontmatter } = useData()

function formatDate(date: { time: number; string: string }) {
  return date.string
}
</script>

<template>
  <div class="blog-home">
    <div class="blog-divider"></div>
    <div class="blog-home-header">
      <h1 class="blog-home-title">{{ frontmatter.title }}</h1>
      <p class="blog-home-subtext">{{ frontmatter.subtext }}</p>
    </div>
    <ul class="blog-posts-list">
      <li class="blog-post-item" v-for="{ title, url, date, excerpt } of posts" :key="url">
        <article class="blog-post-article">
          <dl class="blog-date">
            <dt class="blog-author-label">Published on</dt>
            <dd>{{ formatDate(date) }}</dd>
          </dl>
          <div class="blog-post-content">
            <h2 class="blog-post-title">
              <a :href="withBase(url)">{{ title }}</a>
            </h2>
            <div v-if="excerpt" class="blog-post-excerpt" v-html="excerpt"></div>
            <div>
              <a class="blog-read-more" aria-label="read more" :href="withBase(url)">Read more →</a>
            </div>
          </div>
        </article>
      </li>
    </ul>
  </div>
</template>

<style scoped>
.blog-home-header {
  padding: 1.5rem 0 2rem 0;
  border-bottom: 1px solid var(--blog-border);
}
</style>
