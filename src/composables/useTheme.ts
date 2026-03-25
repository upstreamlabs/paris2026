import { ref, computed, provide, inject, onMounted, type InjectionKey, type Ref } from 'vue'

type Theme = 'dark' | 'light'

const THEME_KEY: InjectionKey<{
  theme: Ref<Theme>
  isDark: Ref<boolean>
  toggleTheme: () => void
}> = Symbol('theme')

export function provideTheme() {
  const theme = ref<Theme>('dark')
  const isDark = computed(() => theme.value === 'dark')

  function applyTheme(t: Theme) {
    const el = document.documentElement
    if (t === 'light') {
      el.classList.add('light')
    } else {
      el.classList.remove('light')
    }
  }

  function toggleTheme() {
    theme.value = theme.value === 'dark' ? 'light' : 'dark'
    localStorage.setItem('theme', theme.value)
    applyTheme(theme.value)
  }

  onMounted(() => {
    const saved = localStorage.getItem('theme') as Theme | null
    if (saved === 'light' || saved === 'dark') {
      theme.value = saved
    }
    applyTheme(theme.value)
  })

  provide(THEME_KEY, { theme, isDark, toggleTheme })
  return { theme, isDark, toggleTheme }
}

export function useTheme() {
  const t = inject(THEME_KEY)
  if (!t) throw new Error('useTheme() called without provideTheme()')
  return t
}
