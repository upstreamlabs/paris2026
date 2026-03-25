<script setup lang="ts">
import { useI18n } from '../../composables/useI18n'

const { t } = useI18n()
</script>

<template>
  <section id="awards" class="relative py-32 bg-bg-primary particles overflow-hidden">
    <div class="max-w-7xl mx-auto px-6">
      <div class="text-center mb-16 reveal">
        <h2 class="text-4xl md:text-5xl">
          <span class="heading-serif accent-text">{{ t('awards.title') }}</span>
        </h2>
      </div>

      <!-- Main prize -->
      <div class="max-w-3xl mx-auto mb-12 reveal">
        <div class="relative gradient-border prize-pulse p-10 text-center overflow-hidden group hover:scale-[1.02] transition-transform">
          <div class="absolute inset-0 bg-gradient-to-br from-amber-500/8 via-transparent to-amber-600/8 animate-glow-pulse"></div>
          <div class="relative">
            <div class="text-sm text-amber-600 uppercase tracking-wider mb-4 font-semibold">{{ t('awards.mainLabel') }}</div>
            <h3 class="text-2xl font-bold text-gray-900 mb-2">{{ t('awards.mainTitle') }}</h3>
            <p class="text-text-secondary mb-6">{{ t('awards.mainDesc') }}</p>
          </div>
        </div>
      </div>

      <!-- Sponsor prizes -->
      <div class="grid md:grid-cols-3 gap-6 max-w-4xl mx-auto reveal reveal-delay-2">
        <div class="glass-card p-8 text-center hover:scale-105 transition-all group">
          <svg class="w-12 h-12 mx-auto mb-4 text-blue-600" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path d="M10 14.66v1.626a2 2 0 0 1-.976 1.696A5 5 0 0 0 7 21.978" /><path d="M14 14.66v1.626a2 2 0 0 0 .976 1.696A5 5 0 0 1 17 21.978" /><path d="M18 9h1.5a1 1 0 0 0 0-5H18" /><path d="M4 22h16" /><path d="M6 9a6 6 0 0 0 12 0V3a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1z" /><path d="M6 9H4.5a1 1 0 0 1 0-5H6" /></svg>
          <h3 class="font-bold text-gray-900 text-lg mb-1">{{ t('awards.zhipu') }}</h3>
          <p class="text-text-secondary text-sm">{{ t('awards.zhipuBy') }}</p>
        </div>
        <div class="glass-card p-8 text-center hover:scale-105 transition-all group">
          <svg class="w-12 h-12 mx-auto mb-4 text-rose-500" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path d="M10 14.66v1.626a2 2 0 0 1-.976 1.696A5 5 0 0 0 7 21.978" /><path d="M14 14.66v1.626a2 2 0 0 0 .976 1.696A5 5 0 0 1 17 21.978" /><path d="M18 9h1.5a1 1 0 0 0 0-5H18" /><path d="M4 22h16" /><path d="M6 9a6 6 0 0 0 12 0V3a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1z" /><path d="M6 9H4.5a1 1 0 0 1 0-5H6" /></svg>
          <h3 class="font-bold text-gray-900 text-lg mb-1">{{ t('awards.minimax') }}</h3>
          <p class="text-text-secondary text-sm">{{ t('awards.minimaxBy') }}</p>
        </div>
        <div class="glass-card p-8 text-center hover:scale-105 transition-all group">
          <svg class="w-12 h-12 mx-auto mb-4 text-gray-800" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path d="M10 14.66v1.626a2 2 0 0 1-.976 1.696A5 5 0 0 0 7 21.978" /><path d="M14 14.66v1.626a2 2 0 0 0 .976 1.696A5 5 0 0 1 17 21.978" /><path d="M18 9h1.5a1 1 0 0 0 0-5H18" /><path d="M4 22h16" /><path d="M6 9a6 6 0 0 0 12 0V3a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1z" /><path d="M6 9H4.5a1 1 0 0 1 0-5H6" /></svg>
          <h3 class="font-bold text-gray-900 text-lg mb-1">{{ t('awards.moonshot') }}</h3>
          <p class="text-text-secondary text-sm">{{ t('awards.moonshotBy') }}</p>
        </div>
      </div>

      <p class="text-center text-text-secondary text-sm mt-12 reveal">
        {{ t('awards.allParticipants') }} <span class="text-amber-600 font-semibold">{{ t('awards.apiCredits') }}</span> {{ t('awards.fromSponsors') }}
      </p>
    </div>
  </section>
</template>
