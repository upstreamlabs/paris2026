import { onMounted } from 'vue'

/**
 * Safari blocks autoplay even with muted+playsinline.
 * This forces .play() and falls back to showing the poster
 * as a background image if the video won't play.
 */
export function useVideoAutoplay() {
  onMounted(() => {
    function handleVideos() {
      document.querySelectorAll('video[autoplay]').forEach((v) => {
        const video = v as HTMLVideoElement

        // Set poster as background so it shows through if video is black/paused
        if (video.poster) {
          video.style.backgroundImage = `url(${video.poster})`
          video.style.backgroundSize = 'cover'
          video.style.backgroundPosition = 'center'
        }

        if (video.paused) {
          video.play().catch(() => {
            // Autoplay blocked — video stays paused, poster background visible
          })
        }
      })
    }

    handleVideos()
    setTimeout(handleVideos, 500)
    setTimeout(handleVideos, 2000)

    // Fallback: play on first user interaction
    const onInteract = () => {
      handleVideos()
      document.removeEventListener('click', onInteract)
      document.removeEventListener('touchstart', onInteract)
      document.removeEventListener('scroll', onInteract)
    }
    document.addEventListener('click', onInteract, { once: true })
    document.addEventListener('touchstart', onInteract, { once: true })
    document.addEventListener('scroll', onInteract, { once: true })
  })
}
