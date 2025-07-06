<template>
  <div class="main">
    <h1 class="gradient-text">UPSCALE PRODUCTION</h1>
     <div class="glass-effect">
      <div class="text-block">
        <p> Благодаря использованию передовых технологий и креативных решений, мы
        создаём уникальные видео, которые не просто впечатляют, но и заставляют
        действовать. </p>
        <p>
        Наша команда профессионалов готова адаптироваться под ваши
        нужды, обеспечивая максимальную гибкость и качество. 
        </p>
        <p>
        Позвольте нам рассказать вашу историю с помощью видео, которое оставит неизгладимое
        впечатление!
        </p>
      </div>
      <div class="plyr-container">
        <video
          ref="videoPlayer"
          class="video-player"
          style="max-width: 700px; min-width: 300px; width: 100%;"
          loop
        >
          <source
            src="https://c72c20f3-a52c-42f4-9894-9b4d230ff379.selstorage.ru/Promo%20upscale.mp4"
            type="video/mp4"
          />
        </video>
      </div>
    </div>

    <div class="video-cards-block">
      <div
        v-for="videoCard in videoCards"
        :key="videoCard.id"
        class="video-card"
        @click="openModal(videoCard)"
      >
        <h3 class="video-card-title">{{ videoCard.title }}</h3>
        <div class="video-container">
          <div 
            v-for="(video, i) in videoCard.preview" 
            :key="video" 
            class="video"
            :style="{ backgroundImage: `url(${video})`, backgroundSize: 'cover' }"
          ></div>
        </div>
      </div>
    </div>

    <VideoModal
      :is-open="selectedCard !== null"
      :title="selectedCard?.title || ''"
      :images="selectedCard"
      @close="closeModal"
    />

    <img ref="img1" src="@/assets/img/1.webp" alt="" class="img-1" />
    <img ref="img2" src="@/assets/img/2.webp" alt="" class="img-2" />
    <img ref="img3" src="@/assets/img/3.webp" alt="" class="img-3" /> 
  </div>
</template>

<script>
import VideoModal from "~/components/VideoModal.vue";
import Plyr from 'plyr';
import { gsap } from 'gsap';

export default {
  components: {
    VideoModal,
  },
  data() {
    return {
      videoCards: [
        {
          id: 1,
          title: "Имиджевые",
          value: "lifestyle",
          preview: Array.from({ length: 6 }, (_, i) => `https://c72c20f3-a52c-42f4-9894-9b4d230ff379.selstorage.ru/preview%2Flifestyle%2Flifestyle_${i + 1}.webp`),
          videos: Array.from({ length: 6 }, (_, i) => `https://c72c20f3-a52c-42f4-9894-9b4d230ff379.selstorage.ru/lifestyle%2F${i + 1}.mp4`),
        },
        {
          id: 2,
          title: "Презентационные",
          value: "marketing",
          preview: Array.from({ length: 6 }, (_, i) => `https://c72c20f3-a52c-42f4-9894-9b4d230ff379.selstorage.ru/preview%2Fmarketing%2Fmarketing_${i + 1}.webp`),
          videos: Array.from({ length: 6 }, (_, i) => `https://c72c20f3-a52c-42f4-9894-9b4d230ff379.selstorage.ru/marketing%2F${i + 1}.mp4`),
        },
        {
          id: 3,
          title: "Ивент",
          value: "event",
          preview: Array.from({ length: 6 }, (_, i) => `https://c72c20f3-a52c-42f4-9894-9b4d230ff379.selstorage.ru/preview%2Fevent%2Fevent_${i + 1}.webp`),
          videos: Array.from({ length: 6 }, (_, i) => `https://c72c20f3-a52c-42f4-9894-9b4d230ff379.selstorage.ru/event%2F${i + 1}.mp4`),
        },
        {
          id: 4,
          title: "Анимация",
          value: "animation",
          preview: Array.from({ length: 6 }, (_, i) => `https://c72c20f3-a52c-42f4-9894-9b4d230ff379.selstorage.ru/preview%2Fanimation%2Fanimation_${i + 1}.webp`),
          videos: Array.from({ length: 6 }, (_, i) => `https://c72c20f3-a52c-42f4-9894-9b4d230ff379.selstorage.ru/animation%2F${i + 1}.mp4`),
        },
      ],
      selectedCard: null,
      player: null,
    };
  },
  mounted() {
    this.sortArrays();
    this.initPlyr();
    this.initPageAnimations();
    this.initImageAnimations();
    this.initMouseTracking();
  },
  beforeDestroy() {
    if (this.player) {
      this.player.destroy();
    }
    // Очищаем анимации GSAP
    gsap.killTweensOf([this.$refs.img1, this.$refs.img2, this.$refs.img3]);
    // Удаляем обработчик движения мыши
    window.removeEventListener('mousemove', this.onMouseMove);
  },
  methods: {
    initPlyr() {
      this.$nextTick(() => {
        if (this.$refs.videoPlayer) {
          this.player = new Plyr(this.$refs.videoPlayer, {
            controls: [
              'play-large',
              'play',
              'progress',
              'current-time',
              'mute',
              'volume',
              'captions',
              'settings',
              'pip',
              'airplay',
              'fullscreen'
            ],
            settings: ['captions', 'quality', 'speed'],
            speed: { selected: 1, options: [0.5, 0.75, 1, 1.25, 1.5, 2] },
            loop: { active: true },
            autoplay: false,
            muted: false,
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
        }
      });
    },
    
    initImageAnimations() {
      this.$nextTick(() => {
        // Анимация для первого изображения - плавающий эффект
        gsap.to(this.$refs.img1, {
          y: -8,
          rotation: 2,
          duration: 4,
          ease: "power2.inOut",
          repeat: -1,
          yoyo: true,
          delay: 2.5
        });

        // Анимация для второго изображения - более медленное плавание
        gsap.to(this.$refs.img2, {
          y: -12,
          rotation: -2,
          duration: 6,
          ease: "power2.inOut",
          repeat: -1,
          yoyo: true,
          delay: 3.5
        });

        // Анимация для третьего изображения - вращение и плавание
        gsap.to(this.$refs.img3, {
          y: -10,
          rotation: 3,
          duration: 5,
          ease: "power2.inOut",
          repeat: -1,
          yoyo: true,
          delay: 4.5
        });

        // Добавляем эффект пульсации для всех изображений
        gsap.to([this.$refs.img1, this.$refs.img2, this.$refs.img3], {
          scale: 1.01,
          duration: 3,
          ease: "power2.inOut",
          repeat: -1,
          yoyo: true,
          stagger: 0.5,
          delay: 3
        });
      });
    },

    initPageAnimations() {
      this.$nextTick(() => {
        // Создаем timeline для последовательной анимации
        const tl = gsap.timeline();

        // Анимация заголовка
        tl.to('.gradient-text', {
          opacity: 1,
          y: 0,
          duration: 1,
          ease: "power2.out"
        }, 0.2);

        // Анимация основного блока
        tl.to('.glass-effect', {
          opacity: 1,
          y: 0,
          scale: 1,
          duration: 1.2,
          ease: "power2.out"
        }, 0.4);

        // Анимация блока с карточками
        tl.to('.video-cards-block', {
          opacity: 1,
          y: 0,
          duration: 1,
          ease: "power2.out"
        }, 0.6);

        // Анимация карточек по очереди
        tl.to('.video-card', {
          opacity: 1,
          y: 0,
          scale: 1,
          duration: 0.8,
          ease: "power2.out",
          stagger: 0.1
        }, 0.8);

        // Анимация изображений
        tl.to([this.$refs.img1, this.$refs.img2, this.$refs.img3], {
          opacity: 1,
          scale: 1,
          duration: 1,
          ease: "power2.out",
          stagger: 0.2
        }, 1.2);
      });
    },

    initMouseTracking() {
      this.$nextTick(() => {
        window.addEventListener('mousemove', this.onMouseMove);
      });
    },

    onMouseMove(event) {
      const mouseX = event.clientX;
      const mouseY = event.clientY;
      const windowWidth = window.innerWidth;
      const windowHeight = window.innerHeight;

      // Нормализуем позицию мыши от -1 до 1
      const normalizedX = (mouseX / windowWidth) * 2 - 1;
      const normalizedY = (mouseY / windowHeight) * 2 - 1;

      // Анимация для первого изображения (правый нижний угол) - очень ограниченное движение
      if (this.$refs.img1) {
        gsap.to(this.$refs.img1, {
          x: normalizedX * 3,
          y: normalizedY * 3,
          rotation: normalizedX * 1,
          duration: 0.8,
          ease: "power2.out"
        });
      }

      // Анимация для второго изображения (левый верхний угол) - очень ограниченное движение
      if (this.$refs.img2) {
        gsap.to(this.$refs.img2, {
          x: -normalizedX * 4,
          y: -normalizedY * 4,
          rotation: -normalizedX * 1,
          duration: 0.8,
          ease: "power2.out"
        });
      }

      // Анимация для третьего изображения (правый верхний угол) - очень ограниченное движение
      if (this.$refs.img3) {
        gsap.to(this.$refs.img3, {
          x: normalizedX * 2,
          y: -normalizedY * 2,
          rotation: normalizedY * 0.5,
          duration: 0.8,
          ease: "power2.out"
        });
      }
    },

    openModal(card) {
      this.selectedCard = card;
    },
    closeModal() {
      this.selectedCard = null;
    },
    sortArrays() {
      this.videoCards.forEach(card => {
        // Создаем пары preview-video для сортировки
        const pairs = card.preview.map((preview, index) => ({
          preview,
          video: card.videos[index]
        }));
        
        // Сортируем по номеру файла в preview
        pairs.sort((a, b) => {
          const numA = parseInt(a.preview.match(/(\d+)\.webp$/)?.[1] || '0');
          const numB = parseInt(b.preview.match(/(\d+)\.webp$/)?.[1] || '0');
          return numA - numB;
        });
        
        // Обновляем массивы
        card.preview = pairs.map(pair => pair.preview);
        card.videos = pairs.map(pair => pair.video);
      });
    },
  },
};
</script>

<style scoped lang="scss">
/* Глобальные стили для исключения скролла */
:global(html), :global(body) {
  overflow: hidden;
  height: 100%;
  margin: 0;
  padding: 0;
}

/* Начальные стили для скрытия элементов */
.gradient-text {
  opacity: 0;
  transform: translateY(-50px);
}

.glass-effect {
  opacity: 0;
  transform: translateY(50px) scale(0.9);
}

.video-cards-block {
  opacity: 0;
  transform: translateY(30px);
}

.video-card {
  opacity: 0;
  transform: translateY(20px) scale(0.8);
}

.img-1, .img-2, .img-3 {
  opacity: 0;
  transform: scale(0.8);
}

.main {
  position: relative;
  height: 100%;
  padding: 20px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-around;
  overflow: hidden;
}

.glass-effect {
  background: rgba(255, 255, 255, 0.022); /* Полупрозрачный фон */
  backdrop-filter: blur(14px); /* Эффект размытия фона */
  border-radius: 40px; /* Закругленные углы */
  padding: 20px; /* Отступы внутри div */
  box-shadow: 0 4px 30px rgba(0, 0, 0, 0.53); /* Тень */
  // height: 60%;
  padding: 60px 120px;
  display: flex;
  align-items: center; 
  justify-content: center;
  flex-direction: column;
  gap: 30px;
  z-index: 2;
  width: fit-content;
  border: 2px solid rgba(255, 255, 255, 0.048);

  @media (max-width: 500px) {
    top: 35%;
    padding: 28px;
    border-radius: 20px;
  }
}
.text-block {
  font-size: 14px;
  color: #dfdfdf;
  display: flex;
  flex-direction: column;
  gap: 10px;
  text-align: center;
  width: 100%;
  & p {
      text-align: left;
      font-size: 12px;
    }
}
.gradient-text {
  background: linear-gradient(
    90deg,
    rgb(255, 174, 0),
    rgb(76, 0, 255) 100%
  ); /* Увеличен синий цвет в градиенте */
  -webkit-background-clip: text; /* Обрезка фона по тексту */
  -webkit-text-fill-color: transparent; /* Прозрачный цвет текста */
  font-size: 60px;
  text-align: center;
  @media (max-width: 500px) {
    font-size: 26px;
  }
}

.video-cards-block {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  z-index: 3;
  // width: calc(100% - 160px);
  
  @media (max-width: 1120px) {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    grid-template-rows: repeat(2, 1fr);
    justify-items: center;
    bottom: 50px;
  }

  @media (min-width: 1121px) {
    flex-wrap: nowrap;
    justify-content: center;
  }

  @media (max-width: 500px) {
    gap: 12px;
  }
}

.video-card {
  background: rgba(255, 255, 255, 0.022); /* Полупрозрачный фон */
  border: 1px solid rgba(255, 255, 255, 0.048);
  backdrop-filter: blur(10px); /* Эффект размытия фона */
  border-radius: 40px; /* Закругленные углы */
  padding: 20px; /* Отступы внутри div */
  box-shadow: 0 4px 30px rgba(0, 0, 0, 0.53); /* Тень */
  transition: all 0.3s ease;
  max-width: 240px;
  &:hover {
    background: rgba(255, 255, 255, 0.451); /* Полупрозрачный фон */
    cursor: pointer;
  }
  @media (max-width: 500px) {
    border-radius: 20px; 
    padding: 18px;
  }
  @media (max-width: 400px) {
    padding: 12px;
  }
}

.video-card-title {
  color: #fff;
  margin-bottom: 12px;
  text-align: center;
  @media (max-width: 660px) {
    font-size: 14px;
  }
}

.video-container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-template-rows: repeat(2, 1fr);
  gap: 10px;
  @media (max-width: 400px) {
    gap: 4px;
  }
}

.video {
  width: 60px;
  height: 40px;
  background-color: #2d2d2d;
  border-radius: 12px;
  @media (max-width: 660px) {
    width: 40px;
    height: 25px;
    border-radius: 8px;
  }
}

.img-1 {
  position: absolute;
  bottom: 100px;
  right: 50px;
  z-index: 1;
  width: 400px;
  @media (max-width: 800px) {
    width: 200px;
  }
}
.img-2 {
  position: absolute;
  top: 200px;
  left: 200px;
  z-index: 1;
  transform: rotate(30deg);
  width: 400px;
  @media (max-width: 800px) {
    width: 200px;
    left: 200px;
  }
}
.img-3 {
  position: absolute;
  top: 50px;
  right: 360px;
  z-index: 1;
  transform: rotate(-30deg);
  width: 300px;
  @media (max-width: 800px) {
    width: 200px;
    right: 260px;
    top: 40px;
  }
}
.video-player {
  border-radius: 20px;
}

.plyr-container {
  width: 100%;
  max-width: 700px;
  min-width: 300px;
}

/* Стили для Plyr плеера */
:deep(.plyr) {
  border-radius: 20px;
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

@media (min-width: 1350px) {
  .glass-effect {
    flex-direction: row;
  }
  
  .text-block {
    position: absolute;
    top: 0;
    right: -300px;
    text-align: left;
    width: 280px;
    & p {
      font-size: 16px;
    }
  }
}
</style>
