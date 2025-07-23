<template>
  <div class="min-h-screen bg-gray-100">
    <!-- Navigation - 保持与Home页面一致 -->
    <nav class="fixed w-full top-0 z-50 bg-gray-50/95 backdrop-blur-sm border-b border-gray-300">
      <div class="max-w-6xl mx-auto px-6">
        <div class="flex items-center justify-between h-16">
          <!-- Logo -->
          <div class="flex items-center space-x-2 cursor-pointer group" @click="$router.push('/')">
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
            <a href="/#home" class="text-gray-600 hover:text-gray-700 transition-colors duration-200 text-sm">首页</a>
            <a href="/#features" class="text-gray-600 hover:text-gray-700 transition-colors duration-200 text-sm">功能</a>
            <a href="/#pricing" class="text-gray-600 hover:text-gray-700 transition-colors duration-200 text-sm">定价</a>
            <a href="/#about" class="text-gray-600 hover:text-gray-700 transition-colors duration-200 text-sm">关于</a>
          </div>

          <!-- Back to Home Button -->
          <div class="hidden md:flex items-center">
            <button 
              @click="$router.push('/')"
              class="text-gray-600 hover:text-gray-700 transition-colors duration-200 text-sm font-medium"
            >
              返回首页
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
              <button 
                @click="$router.push('/')"
                class="text-gray-600 text-left text-sm"
              >
                返回首页
              </button>
            </div>
          </div>
        </transition>
      </div>
    </nav>

    <!-- Auth Section -->
    <section class="relative overflow-hidden min-h-screen flex items-center pt-16">
      <div class="max-w-7xl mx-auto px-6 py-20 w-full">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
          
          <!-- Left Side - Hero Content (缩小版) -->
          <div class="text-left animate-fade-in-up animation-delay-0">
            <div class="mb-8">
              <h1 class="text-4xl md:text-5xl font-light text-gray-700 leading-tight mb-6">
                <span class="inline-block">欢迎使用</span>
                <br />
                <span class="bg-gradient-to-r from-blue-700 via-violet-700 to-emerald-700 bg-clip-text text-transparent bg-300% animate-gradient-x inline-block">
                  PatPilot
                </span>
              </h1>
            </div>
            
            <p class="text-lg md:text-xl text-slate-600 mb-8 max-w-lg leading-relaxed">
              基于先进的大语言模型技术，自动生成符合规范的专利申请文本
            </p>
            
            <!-- Features -->
            <div class="flex flex-wrap gap-3 animate-fade-in-up animation-delay-400">
              <div class="bg-gray-50/90 backdrop-blur-sm rounded-full px-4 py-2 shadow-sm border border-gray-300 animate-float animation-delay-0">
                <span class="text-gray-700 font-medium text-sm">✨ AI智能生成</span>
              </div>
              <div class="bg-gray-50/90 backdrop-blur-sm rounded-full px-4 py-2 shadow-sm border border-gray-300 animate-float animation-delay-200">
                <span class="text-gray-700 font-medium text-sm">🛡️ 反AI查重</span>
              </div>
              <div class="bg-gray-50/90 backdrop-blur-sm rounded-full px-4 py-2 shadow-sm border border-gray-300 animate-float animation-delay-400">
                <span class="text-gray-700 font-medium text-sm">📄 专利模板</span>
              </div>
            </div>
          </div>

          <!-- Right Side - Auth Form -->
          <div class="animate-fade-in-up animation-delay-600">
            <div class="bg-gray-50/90 backdrop-blur-sm rounded-2xl p-8 shadow-lg border border-gray-300 max-w-md mx-auto">
              <!-- Auth Form Header -->
              <div class="text-center mb-8">
                <h2 class="text-2xl font-light text-gray-700 mb-2">
                  {{ isLogin ? '登录账户' : '创建账户' }}
                </h2>
                <p class="text-gray-600 text-sm">
                  {{ isLogin ? '欢迎回来！请登录您的账户' : '开始您的AI专利生成之旅' }}
                </p>
              </div>

              <!-- Auth Form -->
              <form @submit.prevent="handleSubmit" class="space-y-6">
                <!-- Phone Number Input -->
                <div class="space-y-2">
                  <label class="block text-sm font-medium text-gray-700">
                    手机号码
                  </label>
                  <div class="relative">
                    <input
                      v-model="formData.phone"
                      type="tel"
                      placeholder="请输入手机号码"
                      class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200 bg-white"
                      :class="{ 'border-red-300': errors.phone }"
                      maxlength="11"
                    />
                    <div class="absolute inset-y-0 right-0 flex items-center pr-3">
                      <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"/>
                      </svg>
                    </div>
                  </div>
                  <p v-if="errors.phone" class="text-red-500 text-xs">{{ errors.phone }}</p>
                </div>

                <!-- Verification Code Input -->
                <div class="space-y-2">
                  <label class="block text-sm font-medium text-gray-700">
                    验证码
                  </label>
                  <div class="flex space-x-3">
                    <input
                      v-model="formData.code"
                      type="text"
                      placeholder="请输入验证码"
                      class="flex-1 px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200 bg-white"
                      :class="{ 'border-red-300': errors.code }"
                      maxlength="6"
                    />
                    <button
                      type="button"
                      @click="sendVerificationCode"
                      :disabled="!canSendCode || codeSending"
                      class="px-4 py-3 bg-gradient-to-r from-blue-700 to-violet-700 text-white rounded-lg font-medium hover:from-blue-800 hover:to-violet-800 transition-all duration-200 disabled:opacity-50 disabled:cursor-not-allowed whitespace-nowrap"
                    >
                      {{ codeSending ? '发送中...' : (countdown > 0 ? `${countdown}s` : '获取验证码') }}
                    </button>
                  </div>
                  <p v-if="errors.code" class="text-red-500 text-xs">{{ errors.code }}</p>
                </div>

                <!-- Submit Button -->
                <button
                  type="submit"
                  :disabled="submitting"
                  class="w-full py-3 bg-gradient-to-r from-blue-700 to-violet-700 text-white rounded-lg font-medium hover:from-blue-800 hover:to-violet-800 transition-all duration-200 disabled:opacity-50 disabled:cursor-not-allowed hover:scale-105 transform"
                >
                  {{ submitting ? '处理中...' : (isLogin ? '登录' : '注册') }}
                </button>
              </form>

              <!-- Switch Auth Mode -->
              <div class="mt-6 text-center">
                <p class="text-gray-600 text-sm">
                  {{ isLogin ? '还没有账户？' : '已有账户？' }}
                  <button
                    @click="toggleAuthMode"
                    class="text-blue-700 hover:text-blue-800 font-medium transition-colors duration-200"
                  >
                    {{ isLogin ? '立即注册' : '立即登录' }}
                  </button>
                </p>
              </div>

              <!-- Privacy Policy -->
              <div class="mt-6 text-center">
                <p class="text-xs text-gray-500">
                  {{ isLogin ? '登录' : '注册' }}即表示您同意我们的
                  <a href="#" class="text-blue-700 hover:text-blue-800">服务条款</a>
                  和
                  <a href="#" class="text-blue-700 hover:text-blue-800">隐私政策</a>
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- Background decoration - 与Home页面一致 -->
      <div class="absolute top-0 left-0 w-full h-full pointer-events-none overflow-hidden">
        <!-- Subtle gradient orbs -->
        <div class="absolute top-20 left-10 w-72 h-72 bg-gray-200/40 rounded-full filter blur-xl opacity-30 animate-float-slow"></div>
        <div class="absolute top-40 right-10 w-72 h-72 bg-gray-300/30 rounded-full filter blur-xl opacity-25 animate-float-slow animation-delay-1000"></div>
        <div class="absolute bottom-20 left-1/2 transform -translate-x-1/2 w-64 h-64 bg-gray-100/50 rounded-full filter blur-xl opacity-20 animate-float-slow animation-delay-2000"></div>
        
        <!-- Minimal geometric shapes -->
        <div class="absolute top-1/2 left-8 w-16 h-16 border border-gray-300/25 rounded-lg transform rotate-45 animate-spin-slow opacity-15"></div>
        <div class="absolute top-1/4 right-16 w-12 h-12 border border-gray-400/20 rounded-full animate-bounce opacity-20"></div>
      </div>
    </section>
  </div>
</template>

<script setup>
import { ref, computed, onUnmounted } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

// Mobile menu state
const isMobileMenuOpen = ref(false)

// Auth state
const isLogin = ref(true)
const submitting = ref(false)
const codeSending = ref(false)
const countdown = ref(0)
let countdownTimer = null

// Form data
const formData = ref({
  phone: '',
  code: ''
})

// Form errors
const errors = ref({})

// Computed properties
const canSendCode = computed(() => {
  return formData.value.phone.length === 11 && /^1[3-9]\d{9}$/.test(formData.value.phone) && countdown.value === 0
})

// Methods
const toggleMobileMenu = () => {
  isMobileMenuOpen.value = !isMobileMenuOpen.value
}

const toggleAuthMode = () => {
  isLogin.value = !isLogin.value
  clearErrors()
  resetForm()
}

const resetForm = () => {
  formData.value = {
    phone: '',
    code: ''
  }
}

const clearErrors = () => {
  errors.value = {}
}

const validateForm = () => {
  clearErrors()
  
  // Validate phone number
  if (!formData.value.phone) {
    errors.value.phone = '请输入手机号码'
    return false
  }
  
  if (!/^1[3-9]\d{9}$/.test(formData.value.phone)) {
    errors.value.phone = '请输入正确的手机号码'
    return false
  }
  
  // Validate verification code
  if (!formData.value.code) {
    errors.value.code = '请输入验证码'
    return false
  }
  
  if (formData.value.code.length !== 6) {
    errors.value.code = '请输入6位验证码'
    return false
  }
  
  return true
}

const sendVerificationCode = async () => {
  if (!canSendCode.value) return
  
  try {
    codeSending.value = true
    
    // 模拟发送验证码API调用
    await new Promise(resolve => setTimeout(resolve, 1000))
    
    // 开始倒计时
    countdown.value = 60
    countdownTimer = setInterval(() => {
      countdown.value--
      if (countdown.value <= 0) {
        clearInterval(countdownTimer)
        countdownTimer = null
      }
    }, 1000)
    
    console.log('验证码已发送到:', formData.value.phone)
    
  } catch (error) {
    console.error('发送验证码失败:', error)
  } finally {
    codeSending.value = false
  }
}

const handleSubmit = async () => {
  if (!validateForm()) return
  
  try {
    submitting.value = true
    
    // 模拟登录/注册API调用
    await new Promise(resolve => setTimeout(resolve, 1500))
    
    console.log(isLogin.value ? '登录成功' : '注册成功', formData.value)
    
    // 登录/注册成功后跳转到首页
    router.push('/')
    
  } catch (error) {
    console.error(isLogin.value ? '登录失败:' : '注册失败:', error)
  } finally {
    submitting.value = false
  }
}

// Cleanup
onUnmounted(() => {
  if (countdownTimer) {
    clearInterval(countdownTimer)
  }
})
</script>

<style scoped>
/* 动画关键帧定义 - 与Home页面保持一致 */
@keyframes fade-in-up {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes gradient-x {
  0%, 100% {
    background-position: 0% 50%;
  }
  50% {
    background-position: 100% 50%;
  }
}

@keyframes float {
  0%, 100% {
    transform: translateY(0px);
  }
  50% {
    transform: translateY(-10px);
  }
}

@keyframes float-slow {
  0%, 100% {
    transform: translateY(0px) translateX(0px);
  }
  33% {
    transform: translateY(-20px) translateX(10px);
  }
  66% {
    transform: translateY(-10px) translateX(-10px);
  }
}

@keyframes spin-slow {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

/* 应用动画类 */
.animate-fade-in-up {
  animation: fade-in-up 0.8s ease-out forwards;
}

.animate-gradient-x {
  animation: gradient-x 3s ease infinite;
}

.animate-float {
  animation: float 3s ease-in-out infinite;
}

.animate-float-slow {
  animation: float-slow 6s ease-in-out infinite;
}

.animate-spin-slow {
  animation: spin-slow 20s linear infinite;
}

/* 背景大小 */
.bg-300% {
  background-size: 300% 300%;
}

/* 动画延迟类 */
.animation-delay-0 {
  animation-delay: 0ms;
}

.animation-delay-200 {
  animation-delay: 200ms;
}

.animation-delay-400 {
  animation-delay: 400ms;
}

.animation-delay-600 {
  animation-delay: 600ms;
}

.animation-delay-800 {
  animation-delay: 800ms;
}

.animation-delay-1000 {
  animation-delay: 1000ms;
}

.animation-delay-2000 {
  animation-delay: 2000ms;
}

/* 确保字体渲染平滑 */
.font-light {
  font-weight: 300;
}

/* 自定义滚动行为 */
html {
  scroll-behavior: smooth;
}

/* 输入框聚焦样式优化 */
input:focus {
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}

/* 按钮悬停效果优化 */
button:hover:not(:disabled) {
  transform: translateY(-1px);
}

/* 表单容器额外样式 */
.auth-form-container {
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
}
</style>