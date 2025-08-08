<template>
  <nav class="fixed w-full top-0 z-40 bg-gray-50/95 backdrop-blur-sm border-b border-gray-300">
    <div class="max-w-6xl mx-auto px-6">
      <div class="flex items-center justify-between h-16">
        <!-- Logo -->
        <div class="flex items-center space-x-2 cursor-pointer group" @click="goHome">
          <div class="w-8 h-8 bg-blue-500 rounded-md flex items-center justify-center group-hover:scale-105 transition-transform duration-200">
            <svg class="w-4 h-4 text-white" fill="currentColor" viewBox="0 0 20 20">
              <path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z"/>
              <path fill-rule="evenodd" d="M4 5a2 2 0 012-2v1a3 3 0 003 3h2a3 3 0 003-3V3a2 2 0 012 2v6a2 2 0 01-2 2H6a2 2 0 01-2-2V5z" clip-rule="evenodd"/>
            </svg>
          </div>
          <span class="font-medium text-gray-700">PatPilot</span>
        </div>

        <!-- Desktop Navigation -->
        <div class="hidden md:flex items-center space-x-8">
          <a href="/#home" class="text-gray-600 hover:text-gray-700 transition-colors duration-200 text-sm">
            首页
          </a>
          <a href="/#features" class="text-gray-600 hover:text-gray-700 transition-colors duration-200 text-sm">
            功能
          </a>
          <a href="/#pricing" class="text-gray-600 hover:text-gray-700 transition-colors duration-200 text-sm">
            定价
          </a>
          <a href="/#about" class="text-gray-600 hover:text-gray-700 transition-colors duration-200 text-sm">
            关于
          </a>
        </div>

        <!-- Auth Buttons -->
        <div class="hidden md:flex items-center space-x-4">
          <button 
            @click="handleStartExperience"
            class="text-gray-600 hover:text-gray-700 transition-colors duration-200 text-sm font-medium"
          >
            登录
          </button>
          <button 
            @click="handleStartExperience"
            class="bg-blue-600 text-white px-5 py-2 rounded-lg text-sm font-medium hover:bg-blue-700 transition-all duration-200 hover:scale-105"
          >
            开始使用
          </button>
        </div>

        <!-- Mobile Menu Button -->
        <button 
          @click="toggleMobileMenu"
          class="md:hidden p-2 rounded-md hover:bg-stone-200 transition-colors duration-200"
        >
          <svg v-if="!isMobileMenuOpen" class="w-5 h-5 text-slate-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
          </svg>
          <svg v-else class="w-5 h-5 text-slate-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
          </svg>
        </button>
      </div>

      <!-- Mobile Menu -->
      <transition
        enter-active-class="transition duration-200 ease-out"
        enter-from-class="transform scale-95 opacity-0"
        enter-to-class="transform scale-100 opacity-100"
        leave-active-class="transition duration-75 ease-in"
        leave-from-class="transform scale-100 opacity-100"
        leave-to-class="transform scale-95 opacity-0"
      >
        <div v-if="isMobileMenuOpen" class="md:hidden py-4 border-t border-gray-300">
          <div class="flex flex-col space-y-4">
            <a href="/#home" class="text-gray-600 hover:text-gray-700 transition-colors duration-200 text-sm">首页</a>
            <a href="/#features" class="text-gray-600 hover:text-gray-700 transition-colors duration-200 text-sm">功能</a>
            <a href="/#pricing" class="text-gray-600 hover:text-gray-700 transition-colors duration-200 text-sm">定价</a>
            <a href="/#about" class="text-gray-600 hover:text-gray-700 transition-colors duration-200 text-sm">关于</a>
            <div class="flex flex-col space-y-3 pt-4">
              <button 
                @click="handleStartExperience"
                class="text-gray-600 text-left text-sm"
              >
                登录
              </button>
              <button 
                @click="handleStartExperience"
                class="bg-gray-600 text-white px-4 py-2 rounded-lg text-sm font-medium"
              >
                开始使用
              </button>
            </div>
          </div>
        </div>
      </transition>
    </div>
  </nav>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '@/store/user'
import { ElMessage } from 'element-plus'

const router = useRouter()
const userStore = useUserStore()
const isMobileMenuOpen = ref(false)

const toggleMobileMenu = () => {
  isMobileMenuOpen.value = !isMobileMenuOpen.value
}

const goHome = () => {
  router.push('/')
}

const handleStartExperience = async () => {
  try {
    const result = await userStore.login({ username: 'admin', password: 'admin' })
    if (result.success) {
      ElMessage.success('登录成功，欢迎体验！')
      router.push('/patent/generate')
      return
    }
    userStore.setUser({ username: 'admin', id: 1 })
    userStore.setToken('demo-token')
    ElMessage.success('欢迎体验 PatPilot！')
    router.push('/patent/generate')
  } catch {
    userStore.setUser({ username: 'admin', id: 1 })
    userStore.setToken('demo-token')
    ElMessage.success('欢迎体验 PatPilot！')
    router.push('/patent/generate')
  }
}
</script>

<style scoped>
</style>


