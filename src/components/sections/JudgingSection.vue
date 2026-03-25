<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useI18n } from '../../composables/useI18n'

const { t } = useI18n()

const animated = ref(false)

const colors = ['bg-[#4CAF50]/40', 'bg-[#3BA7D0]/40', 'bg-[#E8D44D]/40', 'bg-[#a855f7]/40', 'bg-[#f59e0b]/40']

const criteria = computed(() =>
  (t('judging.criteria') as any[]).map((c: any, i: number) => ({
    ...c,
    color: colors[i],
    icon: String(i + 1).padStart(2, '0'),
  }))
)

onMounted(() => {
  const observer = new IntersectionObserver(
    ([entry]) => { if (entry.isIntersecting) animated.value = true },
    { threshold: 0.3 }
  )
  const el = document.getElementById('judging')
  if (el) observer.observe(el)
})
</script>

<template>
  <section id="judging" class="relative py-32 bg-bg-secondary overflow-hidden">
    <div class="max-w-4xl mx-auto px-6">
      <div class="text-center mb-16 reveal">
        <h2 class="text-4xl md:text-5xl mt-4">
          {{ t('judging.title') }} <span class="heading-serif accent-text">{{ t('judging.titleAccent') }}</span>
        </h2>
        <p class="text-text-secondary mt-4">{{ t('judging.desc') }}</p>
      </div>

      <div class="space-y-0">
        <div
          v-for="(c, i) in criteria"
          :key="i"
          class="py-3 border-b border-border-subtle flex items-center gap-6 reveal"
          :class="`reveal-delay-${i % 4 + 1}`"
        >
          <span class="text-2xl font-mono font-bold text-text-tertiary shrink-0">{{ c.icon }}</span>
          <div class="flex-1 min-w-0">
            <div class="flex items-center justify-between mb-2">
              <h3 class="font-bold text-text-primary">{{ c.name }}</h3>
              <span class="text-sm font-mono text-text-secondary">20%</span>
            </div>
            <div class="w-full h-1 bg-bg-elevated overflow-hidden">
              <div
                class="h-full transition-all duration-1000 ease-out"
                :class="c.color"
                :style="{ width: animated ? '100%' : '0%', transitionDelay: `${i * 200}ms` }"
              ></div>
            </div>
            <p class="text-text-secondary text-sm mt-2">{{ c.desc }}</p>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>
