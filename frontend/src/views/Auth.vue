<template>
  <div class="min-h-screen bg-gray-100">
    <!-- Navigation -->
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
              @click="$router.push('/auth')"
              class="text-gray-600 hover:text-gray-700 transition-colors duration-200 text-sm font-medium"
            >
              登录
            </button>
            <button 
              @click="scrollToForm"
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
                  @click="$router.push('/auth')"
                  class="text-gray-600 text-left text-sm"
                >
                  登录
                </button>
                <button 
                  @click="scrollToForm"
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

    <!-- Auth Section -->
    <section class="relative overflow-hidden min-h-screen flex items-center pt-16">
      <div class="max-w-7xl mx-auto px-6 py-20 w-full">
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 items-center">
          
          <!-- Left Side - Complete Hero Content -->
          <div class="lg:col-span-2 text-left animate-fade-in-up animation-delay-0">
            <!-- Animated Title -->
            <div class="mb-8">
              <h1 class="text-5xl md:text-6xl font-light text-gray-700 leading-tight">
                <span class="inline-block animate-fade-in-up animation-delay-0">AI 驱动的</span>
                <br />
                <span class="bg-gradient-to-r from-blue-700 via-violet-700 to-emerald-700 bg-clip-text text-transparent bg-300% animate-gradient-x inline-block animate-fade-in-up animation-delay-200">
                  智能专利生成
                </span>
              </h1>
            </div>
            
            <!-- Animated Description -->
            <p class="text-xl md:text-2xl text-slate-600 mb-10 max-w-3xl leading-relaxed animate-fade-in-up animation-delay-400">
              基于先进的大语言模型技术，自动生成符合规范的专利申请文本，
              <br class="hidden md:block" />
              结合反AI查重技术确保内容原创性，让专利申请变得
              <span class="text-transparent bg-clip-text bg-gradient-to-r from-blue-700 to-violet-700 font-medium animate-pulse">
                简单高效
              </span>
            </p>
            
            <!-- Animated Buttons -->
            <div class="flex flex-col sm:flex-row gap-6 justify-start animate-fade-in-up animation-delay-600 mb-12">
              <button 
                @click="$router.push('/')"
                class="group bg-gradient-to-r from-blue-700 to-violet-700 text-stone-50 px-8 py-3 rounded-xl text-lg font-medium hover:from-blue-800 hover:to-violet-800 transition-all duration-300 shadow-lg hover:shadow-2xl hover:scale-105 flex items-center justify-center relative overflow-hidden"
              >
                <span class="absolute inset-0 bg-gradient-to-r from-stone-50/20 to-transparent transform -skew-x-12 -translate-x-full group-hover:translate-x-full transition-transform duration-700"></span>
                <span class="relative">查看演示</span>
                <svg class="ml-2 w-5 h-5 group-hover:translate-x-1 transition-transform duration-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                </svg>
              </button>
              <button 
                class="group border-2 border-stone-300 text-slate-700 px-8 py-3 rounded-xl text-lg font-medium hover:border-blue-700 hover:bg-gradient-to-r hover:from-blue-50 hover:to-violet-50 hover:text-blue-700 transition-all duration-300 hover:scale-105"
              >
                <span class="group-hover:animate-pulse">了解更多</span>
              </button>
            </div>

            <!-- Floating Features -->
            <div class="flex flex-wrap gap-3 animate-fade-in-up animation-delay-800">
              <div class="bg-gray-50/90 backdrop-blur-sm rounded-full px-4 py-2 shadow-sm border border-gray-300 animate-float animation-delay-0">
                <span class="text-gray-700 font-medium text-sm">✨ AI智能生成</span>
              </div>
              <div class="bg-gray-50/90 backdrop-blur-sm rounded-full px-4 py-2 shadow-sm border border-gray-300 animate-float animation-delay-200">
                <span class="text-gray-700 font-medium text-sm">🛡️ 反AI查重</span>
              </div>
              <div class="bg-gray-50/90 backdrop-blur-sm rounded-full px-4 py-2 shadow-sm border border-gray-300 animate-float animation-delay-400">
                <span class="text-gray-700 font-medium text-sm">📄 专利模板</span>
              </div>
              <div class="bg-gray-50/90 backdrop-blur-sm rounded-full px-4 py-2 shadow-sm border border-gray-300 animate-float animation-delay-600">
                <span class="text-gray-700 font-medium text-sm">👥 协作编辑</span>
              </div>
            </div>
          </div>

          <!-- Right Side - Compact Auth Form -->
          <div class="lg:col-span-1 animate-fade-in-up animation-delay-600">
            <div class="auth-form-container bg-gray-50/90 backdrop-blur-sm rounded-2xl p-6 shadow-lg border border-gray-300 max-w-sm mx-auto">
              <!-- Auth Form Header -->
              <div class="text-center mb-6">
                <h2 class="text-xl font-light text-gray-700 mb-2">
                  手机号一键登录
                </h2>
                <p class="text-gray-600 text-xs">
                  新用户自动注册，老用户直接登录
                </p>
              </div>

              <!-- Auth Form -->
              <form @submit.prevent="handleSubmit" class="space-y-4">
                <!-- Phone Number Input -->
                <div class="space-y-1">
                  <label class="block text-xs font-medium text-gray-700">
                    手机号码
                  </label>
                  <div class="relative">
                    <input
                      v-model="formData.phone"
                      type="tel"
                      placeholder="请输入手机号码"
                      class="w-full px-3 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200 bg-white text-sm"
                      :class="{ 'border-red-300': errors.phone }"
                      maxlength="11"
                    />
                    <div class="absolute inset-y-0 right-0 flex items-center pr-3">
                      <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"/>
                      </svg>
                    </div>
                  </div>
                  <p v-if="errors.phone" class="text-red-500 text-xs">{{ errors.phone }}</p>
                </div>

                <!-- Verification Code Input -->
                <div class="space-y-1">
                  <label class="block text-xs font-medium text-gray-700">
                    验证码
                  </label>
                  <div class="flex space-x-2">
                    <input
                      v-model="formData.code"
                      type="text"
                      placeholder="请输入验证码"
                      class="flex-1 px-3 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200 bg-white text-sm"
                      :class="{ 'border-red-300': errors.code }"
                      maxlength="6"
                    />
                    <button
                      type="button"
                      @click="sendVerificationCode"
                      :disabled="!canSendCode || codeSending"
                      class="px-3 py-2.5 bg-gradient-to-r from-blue-700 to-violet-700 text-white rounded-lg font-medium hover:from-blue-800 hover:to-violet-800 transition-all duration-200 disabled:opacity-50 disabled:cursor-not-allowed whitespace-nowrap text-xs"
                    >
                      {{ codeSending ? '发送中' : (countdown > 0 ? `${countdown}s` : '获取验证码') }}
                    </button>
                  </div>
                  <p v-if="errors.code" class="text-red-500 text-xs">{{ errors.code }}</p>
                </div>

                <!-- Submit Button -->
                <button
                  type="submit"
                  :disabled="submitting"
                  class="w-full py-2.5 bg-gradient-to-r from-blue-700 to-violet-700 text-white rounded-lg font-medium hover:from-blue-800 hover:to-violet-800 transition-all duration-200 disabled:opacity-50 disabled:cursor-not-allowed hover:scale-105 transform text-sm"
                >
                  {{ submitting ? '处理中...' : '一键登录/注册' }}
                </button>
              </form>

              <!-- 分隔线 -->
              <div class="my-6 flex items-center">
                <div class="flex-1 border-t border-gray-300"></div>
                <span class="px-3 text-xs text-gray-500 bg-gray-50">或使用第三方登录</span>
                <div class="flex-1 border-t border-gray-300"></div>
              </div>

              <!-- 第三方登录按钮 -->
              <div class="flex justify-center space-x-6">
                <!-- Github登录 -->
                <button
                  @click="handleThirdPartyLogin('github')"
                  class="w-12 h-12 flex items-center justify-center rounded-full hover:bg-gray-100 transition-all duration-200 hover:scale-110 group"
                  title="GitHub登录"
                >
                  <svg class="w-7 h-7 text-gray-600 group-hover:text-gray-800" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/>
                  </svg>
                </button>

                <!-- 微信登录 -->
                <button
                  @click="handleThirdPartyLogin('wechat')"
                  class="w-12 h-12 flex items-center justify-center rounded-full hover:bg-green-50 transition-all duration-200 hover:scale-110 group"
                  title="微信登录"
                >
                  <svg class="w-7 h-7 text-green-500 group-hover:text-green-600" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M8.691 2.188C3.891 2.188 0 5.476 0 9.53c0 2.212 1.099 4.19 2.815 5.498L2.007 17.93l2.933-1.467c.747.16 1.547.24 2.386.24.246 0 .487-.016.728-.033-.154-.53-.246-1.083-.246-1.659 0-3.656 3.129-6.621 6.996-6.621.338 0 .67.027.99.073C15.009 4.15 12.168 2.188 8.691 2.188zm-2.79 2.997c.746 0 1.354.6 1.354 1.346 0 .746-.608 1.346-1.354 1.346-.747 0-1.346-.6-1.346-1.346 0-.746.599-1.346 1.346-1.346zm5.569 0c.747 0 1.354.6 1.354 1.346 0 .746-.607 1.346-1.354 1.346-.746 0-1.346-.6-1.346-1.346 0-.746.6-1.346 1.346-1.346z"/>
                    <path d="M15.724 9.22c-3.425 0-6.202 2.32-6.202 5.186 0 1.655.747 3.151 1.958 4.204l-.617 1.853 2.131-1.064c.617.123 1.265.185 1.938.185 3.425 0 6.202-2.319 6.202-5.178 0-2.859-2.777-5.186-6.202-5.186zm-2.776 2.651c.462 0 .84.37.84.84 0 .462-.378.84-.84.84-.463 0-.84-.378-.84-.84 0-.47.377-.84.84-.84zm5.552 0c.462 0 .84.37.84.84 0 .462-.378.84-.84.84-.462 0-.84-.378-.84-.84 0-.47.378-.84.84-.84z"/>
                  </svg>
                </button>

                <!-- Google登录 -->
                <button
                  @click="handleThirdPartyLogin('google')"
                  class="w-12 h-12 flex items-center justify-center rounded-full hover:bg-gray-50 transition-all duration-200 hover:scale-110 group"
                  title="Google登录"
                >
                  <svg class="w-7 h-7" viewBox="0 0 24 24">
                    <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
                    <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
                    <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>
                    <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/>
                  </svg>
                </button>
              </div>



              <!-- Privacy Policy -->
              <div class="mt-4 text-center">
                <p class="text-xs text-gray-500">
                  登录即表示您同意我们的
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

const scrollToForm = () => {
  // 关闭移动菜单（如果打开的话）
  isMobileMenuOpen.value = false
  
  // 平滑滚动到表单区域
  const formElement = document.querySelector('.auth-form-container')
  if (formElement) {
    formElement.scrollIntoView({ 
      behavior: 'smooth',
      block: 'center'
    })
  }
}

const resetForm = () => {
  formData.value = {
    phone: '',
    code: ''
  }
}

// 第三方登录处理方法
const handleThirdPartyLogin = async (provider) => {
  try {
    console.log(`开始 ${provider} 登录...`)
    
    // 根据不同的提供商处理登录逻辑
    switch (provider) {
      case 'github':
        await handleGithubLogin()
        break
      case 'wechat':
        await handleWechatLogin()
        break
      case 'google':
        await handleGoogleLogin()
        break
      default:
        console.error('未支持的登录提供商:', provider)
    }
  } catch (error) {
    console.error(`${provider} 登录失败:`, error)
    // 这里可以显示错误提示
  }
}

// GitHub登录
const handleGithubLogin = async () => {
  // 实际应用中，这里会重定向到GitHub OAuth授权页面
  // window.location.href = '/api/auth/github'
  console.log('GitHub登录 - 跳转到GitHub OAuth授权页面')
  // 临时提示
  alert('GitHub登录功能开发中，将会跳转到GitHub进行授权')
}

// 微信登录  
const handleWechatLogin = async () => {
  // 实际应用中，这里会调用微信登录SDK或跳转到微信授权页面
  console.log('微信登录 - 调用微信登录SDK')
  // 临时提示
  alert('微信登录功能开发中，将会调用微信登录SDK')
}

// Google登录
const handleGoogleLogin = async () => {
  // 实际应用中，这里会调用Google登录SDK
  console.log('Google登录 - 调用Google登录SDK')
  // 临时提示  
  alert('Google登录功能开发中，将会调用Google登录SDK')
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
    
    // 模拟一键登录注册API调用
    await new Promise(resolve => setTimeout(resolve, 1500))
    
    console.log('一键登录注册成功', formData.value)
    
    // 成功后跳转到控制台页面
    router.push('/dashboard')
    
  } catch (error) {
    console.error('一键登录注册失败:', error)
    // 这里可以显示具体的错误信息
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