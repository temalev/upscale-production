<template>
  <div class="player-wrapper">
    <video
      ref="video"
      class="plyr__video-embed"
      controls
      playsinline
      preload="metadata"
      :poster="poster"
    ></video>
  </div>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue'
import Plyr from 'plyr'
import 'plyr/dist/plyr.css'
import Hls from 'hls.js'

const props = defineProps({
  src: { type: String, required: true }, // ссылка на master.m3u8
  poster: { type: String, default: '' }
})

const video = ref(null)
let hls = null
let player = null

onMounted(() => {
  if (Hls.isSupported()) {
    hls = new Hls({ maxMaxBufferLength: 30 })
    hls.loadSource(props.src)
    hls.attachMedia(video.value)

    hls.on(Hls.Events.MANIFEST_PARSED, (_, data) => {
      const qualities = data.levels.map(l => l.height)
      const unique = [...new Set(qualities)].sort((a, b) => b - a)

      // Добавляем "Auto" как первый пункт меню
      const qualityOptions = ['Auto', ...unique]

      player = new Plyr(video.value, {
        controls: [
          'play-large', 'play', 'progress', 'current-time', 'mute', 'settings', 'fullscreen'
        ],
        settings: ['quality'],
        ratio: '16:9',
        quality: {
          default: 'Auto',
          options: qualityOptions,
          forced: true,
          onChange: q => {
            if (q === 'Auto') {
              hls.currentLevel = -1 // -1 = автоуровень
            } else {
              const level = hls.levels.findIndex(l => l.height === q)
              hls.currentLevel = level
            }
          }
        }
      })

      // Устанавливаем авто по умолчанию
      hls.currentLevel = -1
    })
  } else if (video.value.canPlayType('application/vnd.apple.mpegurl')) {
    // Safari — HLS поддерживается нативно
    video.value.src = props.src
    player = new Plyr(video.value)
  }
})

onBeforeUnmount(() => {
  hls?.destroy()
  player?.destroy()
})
</script>

<style scoped>
.player-wrapper {
  width: 100%;
  max-width: 100%;
  aspect-ratio: 16 / 9;
  background: #000;
  border-radius: 12px;
  overflow: hidden;
}

/* Растягиваем Plyr на размер контейнера */
:deep(.plyr),
:deep(.plyr__video-wrapper),
:deep(.plyr__video-embed),
:deep(video) {
  width: 100%;
  height: 100%;
}

:deep(video) {
  object-fit: cover;
}
</style>
