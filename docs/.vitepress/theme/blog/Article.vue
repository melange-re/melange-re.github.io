<script setup lang="ts">
import { computed } from 'vue'
import { useData, useRoute, withBase } from 'vitepress'
import { data as posts } from './posts.data.js'

const { frontmatter: data } = useData()
const route = useRoute()

function findCurrentIndex() {
  const currentPath = route.path
  return posts.findIndex((p) => withBase(p.url) === currentPath)
}

const date = computed(() => posts[findCurrentIndex()]?.date)
const nextPost = computed(() => posts[findCurrentIndex() - 1])
const prevPost = computed(() => posts[findCurrentIndex() + 1])

function formatDate(d: { time: number; string: string } | undefined) {
  return d?.string || ''
}
</script>

<template>
  <article class="blog-article">
    <header class="blog-article-header">
      <dl class="blog-date">
        <dt class="blog-author-label">Published on</dt>
        <dd>{{ formatDate(date) }}</dd>
      </dl>
      <h1 class="blog-article-title">{{ data.title }}</h1>
    </header>

    <div class="blog-article-body">
      <!-- Author section -->
      <dl class="blog-author">
        <dt class="blog-author-label">Authors</dt>
        <dd>
          <ul class="blog-author-list">
            <li class="blog-author-item">
              <img
                v-if="data.gravatar"
                :src="'https://gravatar.com/avatar/' + data.gravatar"
                alt="author image"
                class="blog-author-avatar"
              />
              <img
                v-else-if="data.avatar"
                :src="data.avatar"
                alt="author image"
                class="blog-author-avatar"
              />
              <dl class="blog-author-info">
                <dt class="blog-author-label">Name</dt>
                <dd class="blog-author-name">{{ data.author }}</dd>
                <template v-if="data.twitter">
                  <dt class="blog-author-label">Twitter</dt>
                  <dd>
                    <a
                      :href="'https://twitter.com/' + data.twitter"
                      target="_blank"
                      rel="noopener noreferrer"
                      class="blog-author-twitter"
                    >{{ data.twitter }}</a>
                  </dd>
                </template>
              </dl>
            </li>
          </ul>
        </dd>
      </dl>

      <!-- Article content -->
      <div class="blog-article-content">
        <Content class="blog-prose" />
      </div>

      <!-- Footer navigation -->
      <footer class="blog-article-footer">
        <div v-if="nextPost" class="blog-nav-section">
          <h2 class="blog-nav-label">Next Article</h2>
          <a class="blog-nav-link" :href="withBase(nextPost.url)">{{ nextPost.title }}</a>
        </div>
        <div v-if="prevPost" class="blog-nav-section">
          <h2 class="blog-nav-label">Previous Article</h2>
          <a class="blog-nav-link" :href="withBase(prevPost.url)">{{ prevPost.title }}</a>
        </div>
        <div class="blog-back-link">
          <a class="blog-nav-link" :href="withBase('/blog/')">← Back to the blog</a>
        </div>
      </footer>
    </div>
  </article>
</template>
