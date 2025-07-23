<template>
  <div class="min-h-screen bg-gradient-to-br from-gray-50 via-white to-gray-100">
    <!-- Navigation -->
    <nav class="relative z-50 bg-white/80 backdrop-blur-md border-b border-gray-200/60 shadow-sm">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center py-4">
          <div class="flex items-center space-x-2">
            <div class="w-10 h-10 bg-gradient-to-r from-blue-500 to-cyan-500 rounded-lg flex items-center justify-center">
              <el-icon class="w-6 h-6 text-white"><Document /></el-icon>
            </div>
            <span class="text-2xl font-bold text-gray-800">PatPilot</span>
          </div>
          
          <div class="hidden md:flex items-center space-x-8">
            <a href="#home" class="text-gray-600 hover:text-gray-900 transition-colors font-medium">首页</a>
            <a href="#features" class="text-gray-600 hover:text-gray-900 transition-colors font-medium">功能特色</a>
            <a href="#pricing" class="text-gray-600 hover:text-gray-900 transition-colors font-medium">定价</a>
            <a href="#solutions" class="text-gray-600 hover:text-gray-900 transition-colors font-medium">解决方案</a>
            <a href="#about" class="text-gray-600 hover:text-gray-900 transition-colors font-medium">关于我们</a>
            <div class="flex items-center space-x-3 ml-8">
              <button 
                class="text-gray-600 hover:text-gray-900 px-4 py-2 rounded-lg transition-all font-medium"
                @click="$router.push('/login')"
              >
                登录
              </button>
              <button class="bg-gradient-to-r from-blue-500 to-cyan-500 hover:from-blue-600 hover:to-cyan-600 text-white px-6 py-2 rounded-lg transition-all transform hover:scale-105 font-medium shadow-md">
                注册
              </button>
            </div>
          </div>

          <button 
            class="md:hidden text-gray-700"
            @click="toggleMobileMenu"
          >
            <el-icon class="w-6 h-6">
              <component :is="isMenuOpen ? 'Close' : 'Menu'" />
            </el-icon>
          </button>
        </div>
      </div>

      <!-- Mobile menu -->
      <div v-if="isMenuOpen" class="md:hidden absolute top-full left-0 right-0 bg-white/95 backdrop-blur-md border-b border-gray-200/60 shadow-lg">
        <div class="px-4 py-6 space-y-4">
          <a href="#home" class="block text-gray-600 hover:text-gray-900 font-medium">首页</a>
          <a href="#features" class="block text-gray-600 hover:text-gray-900 font-medium">功能特色</a>
          <a href="#pricing" class="block text-gray-600 hover:text-gray-900 font-medium">定价</a>
          <a href="#solutions" class="block text-gray-600 hover:text-gray-900 font-medium">解决方案</a>
          <a href="#about" class="block text-gray-600 hover:text-gray-900 font-medium">关于我们</a>
          <div class="space-y-2 pt-4 border-t border-gray-200">
            <button 
              class="w-full text-gray-600 hover:text-gray-900 px-4 py-2 rounded-lg font-medium"
              @click="$router.push('/login')"
            >
              登录
            </button>
            <button class="w-full bg-gradient-to-r from-blue-500 to-cyan-500 text-white px-4 py-2 rounded-lg font-medium">注册</button>
          </div>
        </div>
      </div>
    </nav>

    <!-- Hero Section -->
    <section id="home" class="relative overflow-hidden py-20 lg:py-32 bg-gradient-to-br from-blue-50 to-cyan-50">
      <div class="absolute inset-0 bg-gradient-to-r from-blue-100/30 to-cyan-100/30"></div>
      <div class="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center">
          <h1 class="text-5xl lg:text-7xl font-bold text-gray-900 mb-6">
            AI驱动的
            <span class="bg-gradient-to-r from-blue-600 to-cyan-600 bg-clip-text text-transparent">
              专利生成
            </span>
            系统
          </h1>
          <p class="text-xl lg:text-2xl text-gray-600 mb-8 max-w-4xl mx-auto">
            结合大语言模型与反查重技术，为您提供高质量、原创性强的专利申请文本生成服务
          </p>
          <div class="flex flex-col sm:flex-row gap-4 justify-center items-center">
            <button class="group bg-gradient-to-r from-blue-500 to-cyan-500 hover:from-blue-600 hover:to-cyan-600 text-white px-8 py-4 rounded-xl text-lg font-semibold transition-all transform hover:scale-105 flex items-center shadow-lg">
              立即开始
              <el-icon class="ml-2 w-5 h-5 group-hover:translate-x-1 transition-transform"><ArrowRight /></el-icon>
            </button>
            <button class="bg-white hover:bg-gray-50 text-gray-700 px-8 py-4 rounded-xl text-lg font-semibold border border-gray-200 transition-all shadow-md">
              观看演示
            </button>
          </div>
        </div>

        <!-- Stats -->
        <div class="mt-20 grid grid-cols-2 lg:grid-cols-4 gap-8">
          <div v-for="(stat, index) in stats" :key="index" class="text-center">
            <div class="inline-flex items-center justify-center w-12 h-12 bg-white/80 rounded-lg mb-4 shadow-sm border border-gray-100">
              <el-icon class="w-6 h-6 text-blue-500">
                <component :is="stat.icon" />
              </el-icon>
            </div>
            <div class="text-3xl font-bold text-gray-900 mb-2">{{ stat.number }}</div>
            <div class="text-gray-600">{{ stat.label }}</div>
          </div>
        </div>
      </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="py-20 bg-slate-800/50">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-16">
          <h2 class="text-4xl font-bold text-white mb-4">核心功能特色</h2>
          <p class="text-xl text-white/70">强大的AI技术栈，为专利生成提供全方位支撑</p>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-16">
          <div 
            v-for="(feature, index) in features" 
            :key="index"
            :class="[
              'group p-8 rounded-2xl border border-white/10 transition-all duration-300 hover:border-white/30',
              activeFeature === index ? 'bg-white/5 border-white/30' : 'bg-white/5'
            ]"
            @mouseenter="setActiveFeature(index)"
          >
            <div :class="['inline-flex p-4 rounded-xl bg-gradient-to-r mb-6', feature.color]">
              <el-icon class="w-8 h-8 text-white">
                <component :is="feature.icon" />
              </el-icon>
            </div>
            <h3 class="text-2xl font-semibold text-white mb-4">{{ feature.title }}</h3>
            <p class="text-white/70 text-lg leading-relaxed">{{ feature.description }}</p>
          </div>
        </div>

        <!-- Technology Stack -->
        <div class="bg-gradient-to-r from-slate-800/50 to-slate-700/50 rounded-2xl p-8 border border-white/10">
          <h3 class="text-2xl font-semibold text-white mb-6 text-center">技术架构概览</h3>
          <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div class="text-center">
              <div class="w-16 h-16 bg-gradient-to-r from-green-500 to-emerald-500 rounded-full flex items-center justify-center mx-auto mb-4">
                <span class="text-white font-bold">FE</span>
              </div>
              <h4 class="text-lg font-semibold text-white mb-2">前端技术</h4>
              <p class="text-white/60">Vue 3 + Element Plus + Vite</p>
            </div>
            <div class="text-center">
              <div class="w-16 h-16 bg-gradient-to-r from-blue-500 to-cyan-500 rounded-full flex items-center justify-center mx-auto mb-4">
                <span class="text-white font-bold">BE</span>
              </div>
              <h4 class="text-lg font-semibold text-white mb-2">后端服务</h4>
              <p class="text-white/60">Spring Boot + MySQL + Redis</p>
            </div>
            <div class="text-center">
              <div class="w-16 h-16 bg-gradient-to-r from-purple-500 to-pink-500 rounded-full flex items-center justify-center mx-auto mb-4">
                <span class="text-white font-bold">AI</span>
              </div>
              <h4 class="text-lg font-semibold text-white mb-2">AI引擎</h4>
              <p class="text-white/60">GPT + BERT + 反查重算法</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Pricing Section -->
    <section id="pricing" class="py-20">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-16">
          <h2 class="text-4xl font-bold text-white mb-4">选择适合的方案</h2>
          <p class="text-xl text-white/70">灵活的定价模式，满足不同规模的需求</p>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
          <div 
            v-for="(plan, index) in pricingPlans" 
            :key="index"
            :class="[
              'relative p-8 rounded-2xl border transition-all duration-300',
              plan.popular 
                ? 'border-blue-500 bg-gradient-to-b from-blue-500/10 to-cyan-500/10 scale-105' 
                : 'border-white/20 bg-white/5 hover:border-white/30'
            ]"
          >
            <div v-if="plan.popular" class="absolute -top-4 left-1/2 transform -translate-x-1/2">
              <span class="bg-gradient-to-r from-blue-500 to-cyan-500 text-white px-4 py-1 rounded-full text-sm font-semibold flex items-center">
                <el-icon class="w-4 h-4 mr-1"><Star /></el-icon>
                最受欢迎
              </span>
            </div>
            
            <div class="text-center mb-8">
              <h3 class="text-2xl font-semibold text-white mb-2">{{ plan.name }}</h3>
              <div class="text-4xl font-bold text-white mb-2">{{ plan.price }}</div>
              <p class="text-white/60">{{ plan.description }}</p>
            </div>

            <ul class="space-y-4 mb-8">
              <li v-for="(feature, featureIndex) in plan.features" :key="featureIndex" class="flex items-center text-white/80">
                <el-icon class="w-5 h-5 text-green-400 mr-3 flex-shrink-0"><Check /></el-icon>
                {{ feature }}
              </li>
            </ul>

            <button 
              :class="[
                'w-full py-3 rounded-lg font-semibold transition-all',
                plan.popular
                  ? 'bg-gradient-to-r from-blue-500 to-cyan-500 hover:from-blue-600 hover:to-cyan-600 text-white'
                  : 'bg-white/10 hover:bg-white/20 text-white border border-white/20'
              ]"
            >
              {{ plan.buttonText }}
            </button>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA Section -->
    <section class="py-20 bg-gradient-to-r from-blue-600/20 to-cyan-600/20">
      <div class="max-w-4xl mx-auto text-center px-4 sm:px-6 lg:px-8">
        <h2 class="text-4xl font-bold text-white mb-6">准备开始您的专利生成之旅？</h2>
        <p class="text-xl text-white/80 mb-8">
          加入我们，体验AI驱动的专利生成服务，让创新想法快速转化为专利申请
        </p>
        <div class="flex flex-col sm:flex-row gap-4 justify-center">
          <button class="bg-gradient-to-r from-blue-500 to-cyan-500 hover:from-blue-600 hover:to-cyan-600 text-white px-8 py-4 rounded-xl text-lg font-semibold transition-all transform hover:scale-105">
            免费试用
          </button>
          <button class="bg-white/10 hover:bg-white/20 text-white px-8 py-4 rounded-xl text-lg font-semibold border border-white/20 transition-all">
            联系我们
          </button>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer class="bg-slate-900 border-t border-white/10 py-12">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
          <div>
            <div class="flex items-center space-x-2 mb-4">
              <div class="w-8 h-8 bg-gradient-to-r from-blue-500 to-cyan-500 rounded-md flex items-center justify-center">
                <el-icon class="w-5 h-5 text-white"><Document /></el-icon>
              </div>
              <span class="text-xl font-bold text-white">PatPilot</span>
            </div>
            <p class="text-white/60">
              AI专利生成系统，让创新想法快速转化为专利申请
            </p>
          </div>
          
          <div>
            <h3 class="text-white font-semibold mb-4">产品</h3>
            <ul class="space-y-2 text-white/60">
              <li><a href="#" class="hover:text-white transition-colors">功能特色</a></li>
              <li><a href="#" class="hover:text-white transition-colors">价格方案</a></li>
              <li><a href="#" class="hover:text-white transition-colors">API文档</a></li>
            </ul>
          </div>
          
          <div>
            <h3 class="text-white font-semibold mb-4">支持</h3>
            <ul class="space-y-2 text-white/60">
              <li><a href="#" class="hover:text-white transition-colors">帮助中心</a></li>
              <li><a href="#" class="hover:text-white transition-colors">用户指南</a></li>
              <li><a href="#" class="hover:text-white transition-colors">联系我们</a></li>
            </ul>
          </div>
          
          <div>
            <h3 class="text-white font-semibold mb-4">公司</h3>
            <ul class="space-y-2 text-white/60">
              <li><a href="#" class="hover:text-white transition-colors">关于我们</a></li>
              <li><a href="#" class="hover:text-white transition-colors">隐私政策</a></li>
              <li><a href="#" class="hover:text-white transition-colors">服务条款</a></li>
            </ul>
          </div>
        </div>
        
        <div class="border-t border-white/10 mt-12 pt-8 text-center text-white/60">
          <p>&copy; 2024 PatPilot. All rights reserved.</p>
        </div>
      </div>
    </footer>
  </div>
</template>

<script>
import { ref, onMounted, onUnmounted } from 'vue'
import { 
  Document, 
  Menu, 
  Close, 
  ArrowRight, 
  Files, 
  Lock, 
  User, 
  TrendCharts, 
  Cpu,
  Search, 
  Star, 
  Check 
} from '@element-plus/icons-vue'

export default {
  name: 'Home',
  components: {
    Document,
    Menu,
    Close,
    ArrowRight,
    Files,
    Lock,
    User,
    TrendCharts,
    Cpu,
    Search,
    Star,
    Check
  },
  setup() {
    const isMenuOpen = ref(false)
    const activeFeature = ref(0)
    let featureInterval = null

    const toggleMobileMenu = () => {
      isMenuOpen.value = !isMenuOpen.value
    }

    const setActiveFeature = (index) => {
      activeFeature.value = index
    }

    const features = ref([
      {
        icon: 'Cpu',
        title: "AI智能生成",
        description: "基于大语言模型的专利文本智能生成，支持多种专利类型",
        color: "from-blue-500 to-cyan-500"
      },
      {
        icon: 'Lock',
        title: "反查重技术",
        description: "多层次改写策略，确保生成内容的原创性和独特性",
        color: "from-purple-500 to-pink-500"
      },
      {
        icon: 'Search',
        title: "智能检索",
        description: "全文检索和语义相似度搜索，快速定位相关专利",
        color: "from-green-500 to-emerald-500"
      },
      {
        icon: 'Files',
        title: "文档管理",
        description: "版本控制、协作编辑，支持多种格式导出",
        color: "from-orange-500 to-red-500"
      }
    ])

    const stats = ref([
      { number: "10,000+", label: "生成专利数量", icon: "Files" },
      { number: "95%", label: "原创度保证", icon: "Lock" },
      { number: "500+", label: "活跃用户", icon: "User" },
      { number: "99.9%", label: "系统稳定性", icon: "TrendCharts" }
    ])

    const pricingPlans = ref([
      {
        name: "基础版",
        price: "免费",
        description: "个人用户和小型团队",
        features: ["每月5次生成", "基础模板", "标准查重", "邮件支持"],
        buttonText: "开始使用",
        popular: false
      },
      {
        name: "专业版",
        price: "¥299/月",
        description: "中小企业专业需求",
        features: ["无限次生成", "高级模板", "智能查重", "优先支持", "API访问"],
        buttonText: "立即购买",
        popular: true
      },
      {
        name: "企业版",
        price: "定制价格",
        description: "大型企业解决方案",
        features: ["企业定制", "私有部署", "专属客服", "培训服务", "SLA保障"],
        buttonText: "联系销售",
        popular: false
      }
    ])

    onMounted(() => {
      featureInterval = setInterval(() => {
        activeFeature.value = (activeFeature.value + 1) % 4
      }, 3000)
    })

    onUnmounted(() => {
      if (featureInterval) {
        clearInterval(featureInterval)
      }
    })

    return {
      isMenuOpen,
      activeFeature,
      toggleMobileMenu,
      setActiveFeature,
      features,
      stats,
      pricingPlans
    }
  }
}
</script>

<style scoped>
/* Tailwind CSS will handle most styling */
.group:hover .group-hover\:translate-x-1 {
  transform: translateX(0.25rem);
}

.bg-clip-text {
  -webkit-background-clip: text;
  background-clip: text;
}

.text-transparent {
  color: transparent;
}

/* Custom gradients and effects */
.backdrop-blur-md {
  backdrop-filter: blur(12px);
}

/* Ensure proper hover states */
@media (hover: hover) {
  .hover\:scale-105:hover {
    transform: scale(1.05);
  }
}
</style>