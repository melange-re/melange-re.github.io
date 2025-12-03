#!/usr/bin/env node

/**
 * Post-build script to move blog from /{version}/blog/ to /blog/
 * and rewrite all internal URLs accordingly.
 *
 * Usage: node scripts/fix-blog-paths.js <version>
 * Example: node scripts/fix-blog-paths.js unstable
 */

import { readFileSync, writeFileSync, mkdirSync, readdirSync, statSync, cpSync, rmSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const rootDir = join(__dirname, '..');

const version = process.argv[2] || 'unstable';
const distDir = join(rootDir, 'src', '.vitepress', 'dist');
const versionedBlogDir = join(distDir, 'blog');
const outputBlogDir = join(distDir, '..', 'blog-output');

console.log(`Fixing blog paths for version: ${version}`);
console.log(`Source: ${versionedBlogDir}`);
console.log(`Output: ${outputBlogDir}`);

// Check if blog directory exists in dist
try {
  statSync(versionedBlogDir);
} catch {
  console.log('No blog directory found in dist, skipping...');
  process.exit(0);
}

// Create output directory
mkdirSync(outputBlogDir, { recursive: true });

// Copy blog directory to output
cpSync(versionedBlogDir, outputBlogDir, { recursive: true });

// Function to recursively get all HTML files
function getHtmlFiles(dir) {
  const files = [];
  const items = readdirSync(dir);

  for (const item of items) {
    const fullPath = join(dir, item);
    const stat = statSync(fullPath);

    if (stat.isDirectory()) {
      files.push(...getHtmlFiles(fullPath));
    } else if (item.endsWith('.html')) {
      files.push(fullPath);
    }
  }

  return files;
}

// Get all HTML files in the blog output
const htmlFiles = getHtmlFiles(outputBlogDir);

console.log(`Found ${htmlFiles.length} HTML files to process`);

// Rewrite URLs in each HTML file
for (const file of htmlFiles) {
  let content = readFileSync(file, 'utf-8');

  // Replace versioned blog URLs with root blog URLs
  // e.g., /${version}/blog/ -> /blog/
  const versionedBlogPattern = new RegExp(`/${version}/blog/`, 'g');
  content = content.replace(versionedBlogPattern, '/blog/');

  // Replace versioned asset URLs for blog assets
  // e.g., /${version}/assets/ -> /blog/assets/ (for blog-specific assets)
  // Actually, we need to be careful here - assets might be shared
  // Let's keep the versioned assets path for now and just fix blog URLs

  // Fix the base tag if present
  const baseTagPattern = new RegExp(`<base href="/${version}/"`, 'g');
  content = content.replace(baseTagPattern, '<base href="/blog/"');

  // Fix any remaining /${version}/blog references
  const remainingPattern = new RegExp(`"/${version}/blog`, 'g');
  content = content.replace(remainingPattern, '"/blog');

  // Fix href and src attributes pointing to versioned blog
  const hrefPattern = new RegExp(`href="/${version}/blog/`, 'g');
  content = content.replace(hrefPattern, 'href="/blog/');

  const srcPattern = new RegExp(`src="/${version}/blog/`, 'g');
  content = content.replace(srcPattern, 'src="/blog/');

  writeFileSync(file, content);
}

console.log('Blog paths fixed successfully!');
console.log(`Blog files are now at: ${outputBlogDir}`);
console.log('');
console.log('To deploy:');
console.log(`  1. Deploy src/.vitepress/dist/ to /${version}/`);
console.log(`  2. Deploy blog-output/ to /blog/`);

