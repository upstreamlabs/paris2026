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

      <p class="text-center text-text-secondary mb-16 reveal">{{ t('awards.subtitle') }}</p>

      <!-- 5 Awards: top row 3, bottom row 2 centered -->
      <div class="grid md:grid-cols-3 gap-10 max-w-4xl mx-auto mb-10 reveal reveal-delay-1">
        <!-- Zhipu -->
        <div class="flex flex-col items-center text-center">
          <div class="medal mb-4" style="--medal-color: #3b82f6;">
            <div class="medal-ribbon"></div>
            <div class="medal-circle">
              <img src="/sponsors/zhipu-v2.png" alt="Zhipu" class="w-10 h-10 rounded-lg object-contain" />
            </div>
          </div>
          <h3 class="heading-serif text-xl text-text-primary mb-1">{{ t('awards.zhipu') }}</h3>
          <p class="text-text-secondary text-sm">{{ t('awards.zhipuBy') }}</p>
        </div>
        <!-- MiniMax -->
        <div class="flex flex-col items-center text-center">
          <div class="medal mb-4" style="--medal-color: #f43f5e;">
            <div class="medal-ribbon"></div>
            <div class="medal-circle">
              <img src="/sponsors/minimax.png" alt="MiniMax" class="w-10 h-10 rounded-lg object-contain" />
            </div>
          </div>
          <h3 class="heading-serif text-xl text-text-primary mb-1">{{ t('awards.minimax') }}</h3>
          <p class="text-text-secondary text-sm">{{ t('awards.minimaxBy') }}</p>
        </div>
        <!-- Moonshot -->
        <div class="flex flex-col items-center text-center">
          <div class="medal mb-4" style="--medal-color: #a855f7;">
            <div class="medal-ribbon"></div>
            <div class="medal-circle">
              <img src="/sponsors/kimi.png" alt="Moonshot" class="w-10 h-10 rounded-lg object-contain" />
            </div>
          </div>
          <h3 class="heading-serif text-xl text-text-primary mb-1">{{ t('awards.moonshot') }}</h3>
          <p class="text-text-secondary text-sm">{{ t('awards.moonshotBy') }}</p>
        </div>
      </div>
      <div class="grid md:grid-cols-2 gap-10 max-w-2xl mx-auto reveal reveal-delay-2">
        <!-- Upstream I -->
        <div class="flex flex-col items-center text-center">
          <div class="medal mb-4" style="--medal-color: #E8D44D;">
            <div class="medal-ribbon"></div>
            <div class="medal-circle">
              <span class="text-xl font-bold" style="color: #b8960c;">U</span>
            </div>
          </div>
          <h3 class="heading-serif text-xl text-text-primary mb-1">{{ t('awards.upstream1') }}</h3>
          <p class="text-text-secondary text-sm">{{ t('awards.upstream1By') }}</p>
        </div>
        <!-- Upstream II -->
        <div class="flex flex-col items-center text-center">
          <div class="medal mb-4" style="--medal-color: #E8D44D;">
            <div class="medal-ribbon"></div>
            <div class="medal-circle">
              <span class="text-xl font-bold" style="color: #b8960c;">U</span>
            </div>
          </div>
          <h3 class="heading-serif text-xl text-text-primary mb-1">{{ t('awards.upstream2') }}</h3>
          <p class="text-text-secondary text-sm">{{ t('awards.upstream2By') }}</p>
        </div>
      </div>

      <p class="text-center text-text-secondary text-sm mt-12 reveal">
        {{ t('awards.allParticipants') }} <span class="text-amber-600 font-semibold">{{ t('awards.apiCredits') }}</span> {{ t('awards.fromSponsors') }}
      </p>
    </div>
  </section>
</template>
