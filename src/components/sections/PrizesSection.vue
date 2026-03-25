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
            <h3 class="text-2xl font-bold text-amber-600 mb-2 inline-flex items-center gap-3">
              <svg class="w-7 h-7" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path d="M10 14.66v1.626a2 2 0 0 1-.976 1.696A5 5 0 0 0 7 21.978" /><path d="M14 14.66v1.626a2 2 0 0 0 .976 1.696A5 5 0 0 1 17 21.978" /><path d="M18 9h1.5a1 1 0 0 0 0-5H18" /><path d="M4 22h16" /><path d="M6 9a6 6 0 0 0 12 0V3a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1z" /><path d="M6 9H4.5a1 1 0 0 1 0-5H6" /></svg>
              {{ t('awards.mainTitle') }}
            </h3>
            <p class="text-text-secondary mb-6">{{ t('awards.mainDesc') }}</p>
          </div>
        </div>
      </div>

      <!-- Sponsor prizes -->
      <div class="grid md:grid-cols-3 gap-10 max-w-4xl mx-auto reveal reveal-delay-2">
        <div class="relative pl-6 border-l-2 border-transparent" style="border-image: linear-gradient(to bottom, #3b82f6, transparent) 1;">
          <svg class="absolute -top-2 -left-2 w-12 h-12 text-blue-500 opacity-10" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path d="M10 14.66v1.626a2 2 0 0 1-.976 1.696A5 5 0 0 0 7 21.978" /><path d="M14 14.66v1.626a2 2 0 0 0 .976 1.696A5 5 0 0 1 17 21.978" /><path d="M18 9h1.5a1 1 0 0 0 0-5H18" /><path d="M4 22h16" /><path d="M6 9a6 6 0 0 0 12 0V3a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1z" /><path d="M6 9H4.5a1 1 0 0 1 0-5H6" /></svg>
          <img src="/sponsors/zhipu-v2.png" alt="Zhipu" class="w-8 h-8 rounded-[10px] mb-3 relative" />
          <h3 class="heading-serif text-xl text-text-primary mb-2 relative">{{ t('awards.zhipu') }}</h3>
          <p class="text-text-secondary text-sm relative">{{ t('awards.zhipuBy') }}</p>
        </div>
        <div class="relative pl-6 border-l-2 border-transparent" style="border-image: linear-gradient(to bottom, #f43f5e, transparent) 1;">
          <svg class="absolute -top-2 -left-2 w-12 h-12 text-rose-500 opacity-10" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path d="M10 14.66v1.626a2 2 0 0 1-.976 1.696A5 5 0 0 0 7 21.978" /><path d="M14 14.66v1.626a2 2 0 0 0 .976 1.696A5 5 0 0 1 17 21.978" /><path d="M18 9h1.5a1 1 0 0 0 0-5H18" /><path d="M4 22h16" /><path d="M6 9a6 6 0 0 0 12 0V3a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1z" /><path d="M6 9H4.5a1 1 0 0 1 0-5H6" /></svg>
          <img src="/sponsors/minimax.png" alt="MiniMax" class="w-8 h-8 rounded-[10px] mb-3 relative" />
          <h3 class="heading-serif text-xl text-text-primary mb-2 relative">{{ t('awards.minimax') }}</h3>
          <p class="text-text-secondary text-sm relative">{{ t('awards.minimaxBy') }}</p>
        </div>
        <div class="relative pl-6 border-l-2 border-transparent" style="border-image: linear-gradient(to bottom, #a855f7, transparent) 1;">
          <svg class="absolute -top-2 -left-2 w-12 h-12 text-purple-500 opacity-10" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path d="M10 14.66v1.626a2 2 0 0 1-.976 1.696A5 5 0 0 0 7 21.978" /><path d="M14 14.66v1.626a2 2 0 0 0 .976 1.696A5 5 0 0 1 17 21.978" /><path d="M18 9h1.5a1 1 0 0 0 0-5H18" /><path d="M4 22h16" /><path d="M6 9a6 6 0 0 0 12 0V3a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1z" /><path d="M6 9H4.5a1 1 0 0 1 0-5H6" /></svg>
          <img src="/sponsors/kimi.png" alt="Moonshot" class="w-8 h-8 rounded-[10px] mb-3 relative" />
          <h3 class="heading-serif text-xl text-text-primary mb-2 relative">{{ t('awards.moonshot') }}</h3>
          <p class="text-text-secondary text-sm relative">{{ t('awards.moonshotBy') }}</p>
        </div>
      </div>

      <p class="text-center text-text-secondary text-sm mt-12 reveal">
        {{ t('awards.allParticipants') }} <span class="text-amber-600 font-semibold">{{ t('awards.apiCredits') }}</span> {{ t('awards.fromSponsors') }}
      </p>
    </div>
  </section>
</template>
