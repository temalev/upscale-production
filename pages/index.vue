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
      <video
        src="https://c72c20f3-a52c-42f4-9894-9b4d230ff379.selstorage.ru/Promo%20upscale.mp4"
        class="video-player"
        controls
        type="video/mp4"
        style="max-width: 700px; min-width: 300px; width: 100%;"
        poster="@/public/preview/main.webp"
        loop
      ></video>
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
            :key="i" 
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

    <img src="@/assets/img/1.webp" alt="" class="img-1" />
    <img src="@/assets/img/2.webp" alt="" class="img-2" />
    <img src="@/assets/img/3.webp" alt="" class="img-3" /> 
  </div>
</template>

<script>
import VideoModal from "~/components/VideoModal.vue";

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
          preview: Array.from({ length: 6 }, (_, i) => `/preview/lifestyle/${i + 1}.webp`),
          videos: Array.from({ length: 6 }, (_, i) => `/videos/lifestyle/${i + 1}.mp4`),
        },
        {
          id: 2,
          title: "Рекламный",
          value: "marketing",
          preview: Array.from({ length: 6 }, (_, i) => `/preview/marketing/${i + 1}.webp`),
          videos: Array.from({ length: 6 }, (_, i) => `/videos/marketing/${i + 1}.mp4`),
        },
        {
          id: 3,
          title: "Ивент",
          value: "event",
          preview: Array.from({ length: 6 }, (_, i) => `/preview/event/${i + 1}.webp`),
          videos: Array.from({ length: 6 }, (_, i) => `/videos/event/${i + 1}.mp4`),
        },
        {
          id: 4,
          title: "Анимация",
          value: "animation",
          preview: Array.from({ length: 6 }, (_, i) => `/preview/animation/${i + 1}.webp`),
          videos: Array.from({ length: 6 }, (_, i) => `/videos/animation/${i + 1}.mp4`),
        },
      ],
      selectedCard: null,
    };
  },
  mounted() {

  },
  methods: {
    startAnimation() {
      setInterval(() => {
        this.updatePositions();
      }, 100);
    },
    updatePositions() {
      this.img1Position.x += this.img1Direction.x;
      this.img1Position.y += this.img1Direction.y;

      if (Math.abs(this.img1Position.x - this.img1Initial.x) > 50) {
        this.img1Direction.x *= -1;
        this.img1Position.x =
          this.img1Initial.x +
          50 * Math.sign(this.img1Position.x - this.img1Initial.x);
      }
      if (Math.abs(this.img1Position.y - this.img1Initial.y) > 50) {
        this.img1Direction.y *= -1;
        this.img1Position.y =
          this.img1Initial.y +
          50 * Math.sign(this.img1Position.y - this.img1Initial.y);
      }

      this.img2Position.x += this.img2Direction.x;
      this.img2Position.y += this.img2Direction.y;

      if (Math.abs(this.img2Position.x - this.img2Initial.x) > 50) {
        this.img2Direction.x *= -1;
        this.img2Position.x =
          this.img2Initial.x +
          50 * Math.sign(this.img2Position.x - this.img2Initial.x);
      }
      if (Math.abs(this.img2Position.y - this.img2Initial.y) > 50) {
        this.img2Direction.y *= -1;
        this.img2Position.y =
          this.img2Initial.y +
          50 * Math.sign(this.img2Position.y - this.img2Initial.y);
      }

      this.img3Position.x += this.img3Direction.x;
      this.img3Position.y += this.img3Direction.y;

      if (Math.abs(this.img3Position.x - this.img3Initial.x) > 50) {
        this.img3Direction.x *= -1;
        this.img3Position.x =
          this.img3Initial.x +
          50 * Math.sign(this.img3Position.x - this.img3Initial.x);
      }
      if (Math.abs(this.img3Position.y - this.img3Initial.y) > 50) {
        this.img3Direction.y *= -1;
        this.img3Position.y =
          this.img3Initial.y +
          50 * Math.sign(this.img3Position.y - this.img3Initial.y);
      }
    },
    openModal(card) {
      this.selectedCard = card;
    },
    closeModal() {
      this.selectedCard = null;
    },
  },
};
</script>

<style scoped lang="scss">
.main {
  position: relative;
  height: 100%;
  padding: 20px;
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
  position: absolute;
  top: 45%;
  left: 50%;
  transform: translate(-50%, -50%);
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
  position: absolute;
  bottom: 100px;
  left: 80px;
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  z-index: 3;
  width: calc(100% - 160px);
  
  @media (max-width: 1120px) {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    grid-template-rows: repeat(2, 1fr);
    justify-items: center;
    left: auto;
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
  bottom: 0;
  right: 0;
  z-index: 1;
  width: 500px;
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
