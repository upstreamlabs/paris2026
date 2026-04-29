<script setup lang="ts">
import { ref, computed, watch } from 'vue'
import { useAuth } from '../../composables/useAuth'
import { supabase } from '../../lib/supabase'

const { user, isLoggedIn } = useAuth()

const show = ref(false)
const saving = ref(false)
const saved = ref(false)

const alreadyAnswered = computed(() =>
  user.value && (user.value as any).confirmedAttendance != null
)

watch([isLoggedIn, () => user.value], ([loggedIn, u]) => {
  if (loggedIn && u && !(u as any).confirmedAttendance) {
    show.value = true
  }
}, { immediate: true })

async function respond(answer: 'yes' | 'no') {
  if (!user.value || saving.value) return
  saving.value = true
  const { error } = await supabase.from('profiles').update({ confirmed_attendance: answer }).eq('id', user.value.id)
  saving.value = false
  if (!error) {
    ;(user.value as any).confirmedAttendance = answer
    saved.value = true
    setTimeout(() => { show.value = false }, 1500)
  }
}
</script>

<template>
  <Teleport to="body">
    <Transition enter-active-class="transition duration-300" enter-from-class="opacity-0" leave-active-class="transition duration-150" leave-to-class="opacity-0">
      <div v-if="show && isLoggedIn && !alreadyAnswered" class="fixed inset-0 z-[210] flex items-center justify-center p-4">
        <div class="absolute inset-0 bg-black/85 backdrop-blur-sm" />
        <div class="relative w-full max-w-md bg-bg-primary border border-emerald-500/40 shadow-2xl p-6">
          <div class="text-center mb-5">
            <div class="inline-block px-3 py-1 bg-emerald-500/20 text-emerald-400 text-[10px] font-bold tracking-widest uppercase rounded mb-3">RSVP</div>
            <h2 class="text-xl font-bold text-text-primary mb-2">Can you attend in person?</h2>
            <p class="text-sm text-text-secondary leading-relaxed">
              GOSIM Agentic Hackathon at <strong class="text-text-primary">STATION F, Paris</strong> on <strong class="text-text-primary">May 5–6, 2026</strong>. Please confirm so we can finalize seating and logistics.
            </p>
          </div>

          <div v-if="saved" class="text-center py-4">
            <p class="text-emerald-400 font-bold">Thanks for confirming!</p>
          </div>
          <div v-else class="space-y-3">
            <button @click="respond('yes')" :disabled="saving"
              class="w-full py-3 bg-emerald-600 hover:bg-emerald-500 text-white text-sm font-bold uppercase tracking-widest disabled:opacity-50 transition-colors">
              {{ saving ? 'Saving...' : "Yes, I'll be there" }}
            </button>
            <button @click="respond('no')" :disabled="saving"
              class="w-full py-3 bg-bg-secondary border border-border hover:bg-bg-elevated text-text-secondary text-sm font-bold uppercase tracking-widest disabled:opacity-50 transition-colors">
              I can't make it
            </button>
          </div>

          <p class="text-[11px] text-text-muted text-center mt-4">You can change your answer later from your profile.</p>
        </div>
      </div>
    </Transition>
  </Teleport>
</template>
