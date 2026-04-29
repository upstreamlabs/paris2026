<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { supabase } from '../../lib/supabase'

const text = ref('')

async function load() {
  const { data } = await supabase.from('admin_config').select('value').eq('key', 'announcement').single()
  text.value = data?.value || ''
}

onMounted(() => {
  load()
  supabase
    .channel('announcement-realtime')
    .on('postgres_changes', { event: 'UPDATE', schema: 'public', table: 'admin_config', filter: "key=eq.announcement" }, (payload: any) => {
      text.value = payload.new?.value || ''
    })
    .subscribe()
})
</script>

<template>
  <div v-if="text" class="fixed top-16 left-0 right-0 z-40 bg-amber-500 text-black text-center text-sm font-semibold py-2 px-4">
    {{ text }}
  </div>
</template>
