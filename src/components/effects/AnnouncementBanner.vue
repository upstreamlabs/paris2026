<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { supabase } from '../../lib/supabase'

const text = ref('')

async function load() {
  const { data } = await supabase.from('announcements').select('content').eq('active', true).order('created_at', { ascending: false }).limit(1).single()
  text.value = data?.content || ''
}

onMounted(() => {
  load()
  supabase
    .channel('announcement-realtime')
    .on('postgres_changes', { event: '*', schema: 'public', table: 'announcements' }, () => load())
    .subscribe()
})
</script>

<template>
  <div v-if="text" class="fixed top-16 left-0 right-0 z-40 bg-amber-500 text-black text-center text-sm font-semibold py-2 px-4">
    {{ text }}
  </div>
</template>
