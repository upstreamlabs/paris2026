<script setup lang="ts">
import { ref, computed } from 'vue'
import { supabase } from '../lib/supabase'

const authed = ref(false)
const passInput = ref('')
const search = ref('')
const profiles = ref<any[]>([])
const loading = ref(false)
const toast = ref('')

async function sha256hex(str: string): Promise<string> {
  const buf = await crypto.subtle.digest('SHA-256', new TextEncoder().encode(str))
  return Array.from(new Uint8Array(buf)).map(b => b.toString(16).padStart(2, '0')).join('')
}

async function checkPass() {
  const hash = await sha256hex(passInput.value)
  const { data } = await supabase.from('admin_config').select('value').eq('key', 'checkin_pass_hash').single()
  if (data && data.value === hash) {
    authed.value = true
    await loadProfiles()
  } else {
    alert('Wrong password')
  }
}

async function loadProfiles() {
  loading.value = true
  const { data } = await supabase.from('profiles').select('id, name, email, role, team_id, checked_in, avatar, github_id')
  profiles.value = (data || []).sort((a: any, b: any) => (a.name || '').localeCompare(b.name || ''))
  loading.value = false
}

const filtered = computed(() => {
  if (!search.value.trim()) return profiles.value
  const q = search.value.toLowerCase()
  return profiles.value.filter((p: any) =>
    (p.name || '').toLowerCase().includes(q) || (p.email || '').toLowerCase().includes(q)
  )
})

const checkedInCount = computed(() => profiles.value.filter((p: any) => p.checked_in).length)

async function toggleCheckIn(p: any) {
  const newVal = !p.checked_in
  await supabase.from('profiles').update({ checked_in: newVal }).eq('id', p.id)
  p.checked_in = newVal
  toast.value = `${p.name} — ${newVal ? 'checked in ✓' : 'unchecked'}`
  setTimeout(() => (toast.value = ''), 2000)
}

function avatarUrl(p: any): string {
  if (p.avatar) return p.avatar
  if (p.github_id) return `https://avatars.githubusercontent.com/${p.github_id}`
  return `https://ui-avatars.com/api/?name=${encodeURIComponent(p.name || '?')}&background=1f2937&color=fff&size=64`
}
</script>

<template>
  <div class="min-h-screen bg-gray-950 text-white">
    <div v-if="!authed" class="flex items-center justify-center min-h-screen px-4">
      <div class="w-full max-w-sm">
        <h1 class="text-2xl font-bold mb-2 text-center">Check-in</h1>
        <p class="text-sm text-gray-500 text-center mb-6">For volunteers and staff</p>
        <form @submit.prevent="checkPass" class="space-y-4">
          <input v-model="passInput" type="password" placeholder="Password" autofocus
            class="w-full px-4 py-3 bg-gray-900 border border-gray-700 text-white placeholder-gray-500 focus:border-amber-500 focus:outline-none text-lg text-center tracking-widest" />
          <button type="submit" class="w-full py-3 bg-gray-800 text-white font-bold uppercase tracking-widest hover:bg-gray-700 transition-colors">Enter</button>
        </form>
      </div>
    </div>

    <div v-else class="max-w-2xl mx-auto px-4 py-8">
      <div class="flex items-center justify-between mb-4">
        <div>
          <h1 class="text-xl font-bold">Check-in</h1>
          <p class="text-sm text-gray-500">{{ checkedInCount }} / {{ profiles.length }} checked in</p>
        </div>
        <button @click="loadProfiles" class="text-xs text-gray-500 hover:text-white px-3 py-1 border border-gray-700">Refresh</button>
      </div>

      <input v-model="search" type="text" placeholder="Search by name or email..."
        class="w-full px-4 py-3 mb-4 bg-gray-900 border border-gray-700 text-white placeholder-gray-500 focus:border-amber-500 focus:outline-none text-base" autofocus />

      <div v-if="toast" class="mb-4 p-3 bg-emerald-900/30 border border-emerald-500/30 text-emerald-400 text-sm text-center">
        {{ toast }}
      </div>

      <div v-if="loading" class="text-center text-gray-500 py-12">Loading...</div>
      <div v-else class="space-y-1">
        <button v-for="p in filtered" :key="p.id" @click="toggleCheckIn(p)"
          class="w-full flex items-center gap-3 px-4 py-3 rounded transition-colors text-left"
          :class="p.checked_in ? 'bg-emerald-900/30 border border-emerald-500/30' : 'bg-gray-900/50 border border-gray-800 hover:border-gray-600'">
          <div class="w-8 h-8 rounded-full border-2 flex items-center justify-center shrink-0 transition-colors"
            :class="p.checked_in ? 'bg-emerald-600 border-emerald-600' : 'border-gray-600'">
            <svg v-if="p.checked_in" class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M5 13l4 4L19 7"/></svg>
          </div>
          <img :src="avatarUrl(p)" class="w-8 h-8 rounded-full object-cover shrink-0" />
          <div class="min-w-0 flex-1">
            <p class="font-semibold text-sm truncate">{{ p.name || '(no name)' }}</p>
            <p class="text-xs text-gray-500 truncate">{{ p.email }}</p>
          </div>
          <span v-if="p.checked_in" class="text-xs text-emerald-400 font-bold shrink-0">IN</span>
        </button>
      </div>
    </div>
  </div>
</template>
