<script setup lang="ts">
import { useData } from "vitepress";
import DefaultTheme from "vitepress/theme";
import { nextTick, provide } from "vue";
import Switch from "./Switch.vue";
import './custom.css'

const { Layout } = DefaultTheme;
</script>

<template>
  <Layout>
    <template #sidebar-nav-before>
      <Switch> Hello </Switch>
    </template>
  </Layout>
</template>

<style></style>
