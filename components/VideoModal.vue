<template>
  <div v-if="isOpen" class="modal" @click.self="closeModal">
    <div class="modal-content">
      <button class="close-button" @click="closeModal">&times;</button>
      <h2>{{ title }}</h2>
      <div class="modal-videos">
        <video v-for="(image, i) in images.videos"
        :key="i" class="modal-image" controls
        :poster="images.preview[i]"
        >
        <source :src="image" type="video/mp4">
      </video>
      </div>
    </div>
  </div>
</template>

<script>
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
      openVideoIndex: null
    }
  },
  watch: {
    isOpen(newValue) {
      if (newValue) {
        document.body.style.overflow = "hidden";
      } else {
        document.body.style.overflow = "auto";
      }
    },
  },
  methods: {
    closeModal() {
      this.$emit("close");
    },
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
}

.modal-videos {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  // grid-template-rows: repeat(2, 1fr);
  gap: 10px;
  @media (max-width: 400px) {
    grid-template-columns: repeat(2, 1fr);
  }
}

.modal-image {
  gap: 20px;
  margin-top: 20px;
  width: 100%;
  height: -webkit-fill-available;
  background-color: #2d2d2d;
  border-radius: 12px;
  object-fit: cover;
  
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
</style>
