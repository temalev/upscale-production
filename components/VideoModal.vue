<template>
  <div v-if="isOpen" class="modal" @click.self="closeModal">
    <div class="modal-content">
      <button class="close-button" @click="closeModal">&times;</button>
      <h2>{{ title }}</h2>
      <div class="modal-videos">
        <div 
          v-for="(video, i) in images.videos" 
          :key="i" 
          class="video-container"
        >
          <video 
            :ref="`videoPlayer${i}`"
            class="modal-image"
            :poster="images.preview[i]"
          >
            <source :src="video" type="video/mp4">
          </video>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Plyr from 'plyr';

export default {
  name: "VideoModal",
  props: {
    isOpen: {
      type: Boolean,
      default: false,
    },
    title: {
      type: String,
      required: true,
    },
    images: {
      type: Object,
      default: null,
    },
  },
  data() {
    return {
      openVideoIndex: null,
      players: []
    }
  },
  watch: {
    isOpen(newValue) {
      if (newValue) {
        document.body.style.overflow = "hidden";
        this.$nextTick(() => {
          this.initPlyrPlayers();
        });
      } else {
        document.body.style.overflow = "auto";
        this.destroyPlayers();
      }
    },
  },
  beforeDestroy() {
    this.destroyPlayers();
  },
  methods: {
    closeModal() {
      this.$emit("close");
    },
    initPlyrPlayers() {
      if (!this.images || !this.images.videos) return;
      
      this.destroyPlayers();
      
      this.images.videos.forEach((_, index) => {
        const videoElement = this.$refs[`videoPlayer${index}`];
        if (videoElement && videoElement[0]) {
          const player = new Plyr(videoElement[0], {
            controls: [
              'play-large',
              'play',
              'progress',
              'current-time',
              'captions',
              'settings',
              'pip',
              'airplay',
              'fullscreen'
            ],
            settings: ['captions', 'quality', 'speed'],
            speed: { selected: 1, options: [0.5, 0.75, 1, 1.25, 1.5, 2] },
            loop: { active: false },
            autoplay: false,
            muted: false,
            volume: 1,
            hideControls: true,
            resetOnEnd: false,
            keyboard: { focused: true, global: false },
            tooltips: { controls: true, seek: true },
            captions: { active: false, language: 'auto', update: false },
            fullscreen: { enabled: true, fallback: true, iosNative: false },
            quality: { default: 720, options: [4320, 2880, 2160, 1440, 1080, 720, 576, 480, 360, 240] },
            previewThumbnails: false,
            vimeo: { dnt: true },
            youtube: { noCookie: true, rel: 0, showinfo: 0, iv_load_policy: 3 }
          });
          
          // Устанавливаем максимальную громкость
          player.volume = 1;
          
          this.players.push(player);
        }
      });
    },
    destroyPlayers() {
      this.players.forEach(player => {
        if (player) {
          player.destroy();
        }
      });
      this.players = [];
    }
  },
};
</script>

<style scoped lang="scss">
.modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.4);
  backdrop-filter: blur(8px);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.modal-content {
  background: rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(10px);
  padding: 30px;
  border-radius: 40px;
  width: 60%;
  // height: 60vh;
  overflow-y: auto;
  position: relative;
  box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
  @media (max-width: 800px) {
    width: 90%;
  }
}

.close-button {
  position: absolute;
  right: 20px;
  top: 20px;
  background: none;
  border: none;
  font-size: 24px;
  cursor: pointer;
  color: white;
}

h2 {
  color: white;
  margin-bottom: 20px;
}

.modal-videos {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  // grid-template-rows: repeat(2, 1fr);
  gap: 12px;
  @media (max-width: 400px) {
    grid-template-columns: repeat(2, 1fr);
  }
}

.video-container {
  width: 100%;
  height: 100%;
}

.modal-image {
  gap: 20px;
  width: 100%;
  background-color: #2d2d2d;
  border-radius: 12px;
  object-fit: cover;
  height: 100%;
  
  @media (max-width: 800px) {
    object-fit: contain;
  }
}

.image-display {
  width: 100%;
  height: auto;
  border-radius: 10px;
  object-fit: contain;
}

/* Стили для Plyr плеера в модальном окне */
:deep(.plyr) {
  border-radius: 12px;
  overflow: hidden;
}

:deep(.plyr--video) {
  background: transparent;
}

:deep(.plyr__control--overlaid) {
  background: rgba(255, 174, 0, 0.8);
  border: 2px solid rgba(255, 255, 255, 0.2);
}

:deep(.plyr__control--overlaid:hover) {
  background: rgba(255, 174, 0, 1);
}

:deep(.plyr__control) {
  color: #fff;
}

:deep(.plyr__control:hover) {
  background: rgba(255, 255, 255, 0.1);
}

:deep(.plyr__progress__played) {
  background: linear-gradient(90deg, rgb(255, 174, 0), rgb(76, 0, 255));
}

:deep(.plyr__volume__display) {
  background: linear-gradient(90deg, rgb(255, 174, 0), rgb(76, 0, 255));
}

:deep(.plyr__menu__container) {
  background: rgba(0, 0, 0, 0.9);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 8px;
}

:deep(.plyr__menu__container .plyr__control) {
  color: #fff;
}

:deep(.plyr__menu__container .plyr__control:hover) {
  background: rgba(255, 255, 255, 0.1);
}
</style>
