<template>
  <div class="min-h-screen bg-gray-50">
    <!-- Navigation -->
    <nav class="fixed w-full top-0 z-50 bg-white/90 backdrop-blur-sm border-b border-gray-200">
      <div class="max-w-6xl mx-auto px-6">
        <div class="flex items-center justify-between h-16">
          <!-- Logo -->
          <div class="flex items-center space-x-2 cursor-pointer group">
            <div class="w-8 h-8 bg-slate-800 rounded-md flex items-center justify-center group-hover:scale-105 transition-transform duration-200">
              <svg class="w-4 h-4 text-stone-50" fill="currentColor" viewBox="0 0 20 20">
                <path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z"/>
                <path fill-rule="evenodd" d="M4 5a2 2 0 012-2v1a3 3 0 003 3h2a3 3 0 003-3V3a2 2 0 012 2v6a2 2 0 01-2 2H6a2 2 0 01-2-2V5z" clip-rule="evenodd"/>
              </svg>
            </div>
            <span class="font-medium text-slate-800">PatPilot</span>
          </div>

          <!-- Desktop Navigation -->
          <div class="hidden md:flex items-center space-x-8">
            <a href="#home" class="text-slate-600 hover:text-slate-800 transition-colors duration-200 text-sm">
              首页
            </a>
            <a href="#features" class="text-slate-600 hover:text-slate-800 transition-colors duration-200 text-sm">
              功能
            </a>
            <a href="#pricing" class="text-slate-600 hover:text-slate-800 transition-colors duration-200 text-sm">
              定价
            </a>
            <a href="#about" class="text-slate-600 hover:text-slate-800 transition-colors duration-200 text-sm">
              关于
            </a>
          </div>

          <!-- Auth Buttons -->
          <div class="hidden md:flex items-center space-x-4">
            <button class="text-slate-600 hover:text-slate-800 transition-colors duration-200 text-sm font-medium">
              登录
            </button>
            <button class="bg-slate-800 text-stone-50 px-5 py-2 rounded-lg text-sm font-medium hover:bg-slate-700 transition-all duration-200 hover:scale-105">
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
          <div v-if="isMobileMenuOpen" class="md:hidden py-4 border-t border-gray-200">
            <div class="flex flex-col space-y-4">
              <a href="#home" class="text-slate-600 hover:text-slate-800 transition-colors duration-200 text-sm">首页</a>
              <a href="#features" class="text-slate-600 hover:text-slate-800 transition-colors duration-200 text-sm">功能</a>
              <a href="#pricing" class="text-slate-600 hover:text-slate-800 transition-colors duration-200 text-sm">定价</a>
              <a href="#about" class="text-slate-600 hover:text-slate-800 transition-colors duration-200 text-sm">关于</a>
              <div class="flex flex-col space-y-3 pt-4">
                <button class="text-slate-600 text-left text-sm">登录</button>
                <button class="bg-slate-800 text-stone-50 px-4 py-2 rounded-lg text-sm font-medium">开始使用</button>
              </div>
            </div>
          </div>
        </transition>
      </div>
    </nav>

    <!-- Hero Section -->
    <section id="home" class="relative overflow-hidden min-h-screen flex items-center">
      <div class="max-w-6xl mx-auto px-6 py-20 w-full">
        <div class="text-center">
          <!-- Animated Title -->
          <div class="mb-8">
            <h1 class="text-5xl md:text-7xl font-light text-slate-800 leading-tight">
              <span class="inline-block animate-fade-in-up animation-delay-0">AI 驱动的</span>
              <br />
              <span class="bg-gradient-to-r from-blue-700 via-violet-700 to-emerald-700 bg-clip-text text-transparent bg-300% animate-gradient-x inline-block animate-fade-in-up animation-delay-200">
                智能专利生成
              </span>
            </h1>
          </div>
          
          <!-- Animated Description -->
          <p class="text-xl md:text-2xl text-slate-600 mb-10 max-w-4xl mx-auto leading-relaxed animate-fade-in-up animation-delay-400">
            基于先进的大语言模型技术，自动生成符合规范的专利申请文本，
            <br class="hidden md:block" />
            结合反AI查重技术确保内容原创性，让专利申请变得
            <span class="text-transparent bg-clip-text bg-gradient-to-r from-blue-700 to-violet-700 font-medium animate-pulse">
              简单高效
            </span>
          </p>
          
          <!-- Animated Buttons -->
          <div class="flex flex-col sm:flex-row gap-6 justify-center animate-fade-in-up animation-delay-600 mb-16">
            <button class="group bg-gradient-to-r from-blue-700 to-violet-700 text-stone-50 px-10 py-4 rounded-xl text-lg font-medium hover:from-blue-800 hover:to-violet-800 transition-all duration-300 shadow-lg hover:shadow-2xl hover:scale-105 flex items-center justify-center relative overflow-hidden">
              <span class="absolute inset-0 bg-gradient-to-r from-stone-50/20 to-transparent transform -skew-x-12 -translate-x-full group-hover:translate-x-full transition-transform duration-700"></span>
              <span class="relative">开始免费体验</span>
              <svg class="ml-2 w-5 h-5 group-hover:translate-x-1 transition-transform duration-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
              </svg>
            </button>
            <button class="group border-2 border-stone-300 text-slate-700 px-10 py-4 rounded-xl text-lg font-medium hover:border-blue-700 hover:bg-gradient-to-r hover:from-blue-50 hover:to-violet-50 hover:text-blue-700 transition-all duration-300 hover:scale-105">
              <span class="group-hover:animate-pulse">查看演示</span>
            </button>
          </div>

                     <!-- Floating Features -->
           <div class="flex flex-wrap justify-center gap-4 animate-fade-in-up animation-delay-800">
             <div class="bg-white/80 backdrop-blur-sm rounded-full px-6 py-3 shadow-sm border border-gray-200 animate-float animation-delay-0">
               <span class="text-gray-700 font-medium">✨ AI智能生成</span>
             </div>
             <div class="bg-white/80 backdrop-blur-sm rounded-full px-6 py-3 shadow-sm border border-gray-200 animate-float animation-delay-200">
               <span class="text-gray-700 font-medium">🛡️ 反AI查重</span>
             </div>
             <div class="bg-white/80 backdrop-blur-sm rounded-full px-6 py-3 shadow-sm border border-gray-200 animate-float animation-delay-400">
               <span class="text-gray-700 font-medium">📄 专利模板</span>
             </div>
             <div class="bg-white/80 backdrop-blur-sm rounded-full px-6 py-3 shadow-sm border border-gray-200 animate-float animation-delay-600">
               <span class="text-gray-700 font-medium">👥 协作编辑</span>
             </div>
           </div>
        </div>
      </div>
      
             <!-- Subtle Background decoration -->
       <div class="absolute top-0 left-0 w-full h-full pointer-events-none overflow-hidden">
         <!-- Subtle gradient orbs -->
         <div class="absolute top-20 left-10 w-72 h-72 bg-gray-100/30 rounded-full filter blur-xl opacity-40 animate-float-slow"></div>
         <div class="absolute top-40 right-10 w-72 h-72 bg-gray-200/20 rounded-full filter blur-xl opacity-30 animate-float-slow animation-delay-1000"></div>
         <div class="absolute bottom-20 left-1/2 transform -translate-x-1/2 w-64 h-64 bg-white/40 rounded-full filter blur-xl opacity-20 animate-float-slow animation-delay-2000"></div>
         
         <!-- Minimal geometric shapes -->
         <div class="absolute top-1/2 left-8 w-16 h-16 border border-gray-200/20 rounded-lg transform rotate-45 animate-spin-slow opacity-10"></div>
         <div class="absolute top-1/4 right-16 w-12 h-12 border border-gray-300/15 rounded-full animate-bounce opacity-15"></div>
       </div>

      <!-- Scrolling indicator -->
      <div class="absolute bottom-8 left-1/2 transform -translate-x-1/2 animate-bounce">
        <div class="w-6 h-10 border-2 border-slate-400 rounded-full flex justify-center">
          <div class="w-1 h-3 bg-slate-400 rounded-full mt-2 animate-pulse"></div>
        </div>
      </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="py-20 bg-stone-50">
      <div class="max-w-6xl mx-auto px-6">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-light text-slate-800 mb-4">
            核心功能
          </h2>
          <p class="text-lg text-slate-600 max-w-2xl mx-auto">
            简洁高效的专利生成解决方案
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <!-- Feature 1 -->
          <div class="group hover:scale-105 transition-transform duration-300">
            <div class="bg-stone-25 border border-stone-200 rounded-2xl p-8 hover:shadow-lg transition-shadow duration-300">
              <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center mb-6 group-hover:bg-blue-200 transition-colors duration-300">
                <svg class="w-6 h-6 text-blue-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"/>
                </svg>
              </div>
              <h3 class="text-xl font-medium text-slate-800 mb-4">AI 智能生成</h3>
              <p class="text-slate-600 leading-relaxed">
                基于大语言模型自动生成专业的专利申请文本
              </p>
            </div>
          </div>

          <!-- Feature 2 -->
          <div class="group hover:scale-105 transition-transform duration-300">
            <div class="bg-stone-25 border border-stone-200 rounded-2xl p-8 hover:shadow-lg transition-shadow duration-300">
              <div class="w-12 h-12 bg-emerald-100 rounded-xl flex items-center justify-center mb-6 group-hover:bg-emerald-200 transition-colors duration-300">
                <svg class="w-6 h-6 text-emerald-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                </svg>
              </div>
              <h3 class="text-xl font-medium text-slate-800 mb-4">原创保障</h3>
              <p class="text-slate-600 leading-relaxed">
                反AI查重技术确保生成内容的原创性
              </p>
            </div>
          </div>

          <!-- Feature 3 -->
          <div class="group hover:scale-105 transition-transform duration-300">
            <div class="bg-stone-25 border border-stone-200 rounded-2xl p-8 hover:shadow-lg transition-shadow duration-300">
              <div class="w-12 h-12 bg-violet-100 rounded-xl flex items-center justify-center mb-6 group-hover:bg-violet-200 transition-colors duration-300">
                <svg class="w-6 h-6 text-violet-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 17V7m0 10a2 2 0 01-2 2H5a2 2 0 01-2-2V7a2 2 0 012-2h2a2 2 0 012 2m0 10a2 2 0 002 2h2a2 2 0 002-2M9 7a2 2 0 012-2h2a2 2 0 012 2m0 0v10a2 2 0 002 2h2a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2z"/>
                </svg>
              </div>
              <h3 class="text-xl font-medium text-slate-800 mb-4">模板管理</h3>
              <p class="text-slate-600 leading-relaxed">
                多种专利类型模板，支持自定义创建
              </p>
            </div>
          </div>

          <!-- Feature 4 -->
          <div class="group hover:scale-105 transition-transform duration-300">
            <div class="bg-stone-25 border border-stone-200 rounded-2xl p-8 hover:shadow-lg transition-shadow duration-300">
              <div class="w-12 h-12 bg-amber-100 rounded-xl flex items-center justify-center mb-6 group-hover:bg-amber-200 transition-colors duration-300">
                <svg class="w-6 h-6 text-amber-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                </svg>
              </div>
              <h3 class="text-xl font-medium text-slate-800 mb-4">协作编辑</h3>
              <p class="text-slate-600 leading-relaxed">
                支持多人协作编辑，实时同步修改内容
              </p>
            </div>
          </div>

          <!-- Feature 5 -->
          <div class="group hover:scale-105 transition-transform duration-300">
            <div class="bg-stone-25 border border-stone-200 rounded-2xl p-8 hover:shadow-lg transition-shadow duration-300">
              <div class="w-12 h-12 bg-indigo-100 rounded-xl flex items-center justify-center mb-6 group-hover:bg-indigo-200 transition-colors duration-300">
                <svg class="w-6 h-6 text-indigo-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                </svg>
              </div>
              <h3 class="text-xl font-medium text-slate-800 mb-4">智能检索</h3>
              <p class="text-slate-600 leading-relaxed">
                全文检索和语义相似度搜索功能
              </p>
            </div>
          </div>

          <!-- Feature 6 -->
          <div class="group hover:scale-105 transition-transform duration-300">
            <div class="bg-stone-25 border border-stone-200 rounded-2xl p-8 hover:shadow-lg transition-shadow duration-300">
              <div class="w-12 h-12 bg-rose-100 rounded-xl flex items-center justify-center mb-6 group-hover:bg-rose-200 transition-colors duration-300">
                <svg class="w-6 h-6 text-rose-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"/>
                </svg>
              </div>
              <h3 class="text-xl font-medium text-slate-800 mb-4">文档管理</h3>
              <p class="text-slate-600 leading-relaxed">
                完整的版本管理和多格式导出功能
              </p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Pricing Section -->
    <section id="pricing" class="py-20 bg-stone-100">
      <div class="max-w-6xl mx-auto px-6">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-light text-slate-800 mb-4">
            简单透明的定价
          </h2>
          <p class="text-lg text-slate-600 max-w-2xl mx-auto">
            选择适合您需求的方案
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 max-w-5xl mx-auto">
          <!-- Basic Plan -->
          <div class="bg-stone-25 rounded-2xl p-8 border border-stone-200 hover:shadow-lg transition-shadow duration-300">
            <div class="text-center mb-8">
              <h3 class="text-xl font-medium text-slate-800 mb-2">基础版</h3>
              <div class="text-3xl font-light text-slate-800 mb-2">
                ¥99
                <span class="text-base font-normal text-slate-600">/月</span>
              </div>
              <p class="text-slate-600">适合个人用户</p>
            </div>
            <ul class="space-y-4 mb-8">
              <li class="flex items-center text-slate-700">
                <svg class="w-4 h-4 text-emerald-600 mr-3" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                </svg>
                10篇专利/月
              </li>
              <li class="flex items-center text-slate-700">
                <svg class="w-4 h-4 text-emerald-600 mr-3" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                </svg>
                基础模板库
              </li>
              <li class="flex items-center text-slate-700">
                <svg class="w-4 h-4 text-emerald-600 mr-3" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                </svg>
                邮件支持
              </li>
            </ul>
            <button class="w-full bg-stone-200 text-slate-800 py-3 rounded-lg font-medium hover:bg-stone-300 transition-colors duration-200">
              选择基础版
            </button>
          </div>

          <!-- Pro Plan -->
          <div class="bg-stone-25 rounded-2xl p-8 border-2 border-blue-300 hover:shadow-lg transition-shadow duration-300 relative">
            <div class="absolute -top-3 left-1/2 transform -translate-x-1/2">
              <span class="bg-blue-700 text-stone-50 px-3 py-1 rounded-full text-sm font-medium">推荐</span>
            </div>
            <div class="text-center mb-8">
              <h3 class="text-xl font-medium text-slate-800 mb-2">专业版</h3>
              <div class="text-3xl font-light text-slate-800 mb-2">
                ¥299
                <span class="text-base font-normal text-slate-600">/月</span>
              </div>
              <p class="text-slate-600">适合专业用户</p>
            </div>
            <ul class="space-y-4 mb-8">
              <li class="flex items-center text-slate-700">
                <svg class="w-4 h-4 text-emerald-600 mr-3" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                </svg>
                50篇专利/月
              </li>
              <li class="flex items-center text-slate-700">
                <svg class="w-4 h-4 text-emerald-600 mr-3" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                </svg>
                高级模板 + 自定义
              </li>
              <li class="flex items-center text-slate-700">
                <svg class="w-4 h-4 text-emerald-600 mr-3" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                </svg>
                协作功能
              </li>
              <li class="flex items-center text-slate-700">
                <svg class="w-4 h-4 text-emerald-600 mr-3" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                </svg>
                优先支持
              </li>
            </ul>
            <button class="w-full bg-blue-700 text-stone-50 py-3 rounded-lg font-medium hover:bg-blue-800 transition-colors duration-200">
              选择专业版
            </button>
          </div>

          <!-- Enterprise Plan -->
          <div class="bg-stone-25 rounded-2xl p-8 border border-stone-200 hover:shadow-lg transition-shadow duration-300">
            <div class="text-center mb-8">
              <h3 class="text-xl font-medium text-slate-800 mb-2">企业版</h3>
              <div class="text-3xl font-light text-slate-800 mb-2">
                定制
                <span class="text-base font-normal text-slate-600">报价</span>
              </div>
              <p class="text-slate-600">适合企业团队</p>
            </div>
            <ul class="space-y-4 mb-8">
              <li class="flex items-center text-slate-700">
                <svg class="w-4 h-4 text-emerald-600 mr-3" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                </svg>
                无限专利生成
              </li>
              <li class="flex items-center text-slate-700">
                <svg class="w-4 h-4 text-emerald-600 mr-3" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                </svg>
                私有化部署
              </li>
              <li class="flex items-center text-slate-700">
                <svg class="w-4 h-4 text-emerald-600 mr-3" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                </svg>
                专属客户经理
              </li>
            </ul>
            <button class="w-full bg-slate-800 text-stone-50 py-3 rounded-lg font-medium hover:bg-slate-700 transition-colors duration-200">
              联系销售
            </button>
          </div>
        </div>
      </div>
    </section>

    <!-- About Section -->
    <section id="about" class="py-20 bg-stone-50">
      <div class="max-w-6xl mx-auto px-6">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-light text-slate-800 mb-4">
            关于 PatPilot
          </h2>
          <p class="text-lg text-slate-600 max-w-3xl mx-auto leading-relaxed">
            PatPilot 是一个基于AI技术的智能专利生成与管理系统，通过大语言模型生成专利文本，
            并结合先进的反查重技术确保内容原创性。我们致力于让专利申请变得更加简单、高效、智能。
          </p>
        </div>

        <div class="bg-stone-200 rounded-3xl p-12">
          <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
            <div class="space-y-8">
              <h3 class="text-2xl font-light text-slate-800">我们的优势</h3>
              <div class="space-y-6">
                <div class="flex items-start space-x-4">
                  <div class="w-2 h-2 bg-blue-700 rounded-full mt-3"></div>
                  <div>
                    <h4 class="font-medium text-slate-800 mb-2">技术领先</h4>
                    <p class="text-slate-600">采用最新的GPT等大语言模型技术</p>
                  </div>
                </div>
                <div class="flex items-start space-x-4">
                  <div class="w-2 h-2 bg-emerald-700 rounded-full mt-3"></div>
                  <div>
                    <h4 class="font-medium text-slate-800 mb-2">原创保证</h4>
                    <p class="text-slate-600">多层次反AI查重技术确保内容原创性</p>
                  </div>
                </div>
                <div class="flex items-start space-x-4">
                  <div class="w-2 h-2 bg-violet-700 rounded-full mt-3"></div>
                  <div>
                    <h4 class="font-medium text-slate-800 mb-2">专业服务</h4>
                    <p class="text-slate-600">专业团队提供全方位技术支持</p>
                  </div>
                </div>
              </div>
            </div>
            <div class="bg-stone-25 rounded-2xl p-8 text-center">
              <div class="space-y-6">
                <div>
                  <div class="text-3xl font-light text-slate-800">15周</div>
                  <div class="text-slate-600">开发周期</div>
                </div>
                <div class="grid grid-cols-2 gap-6">
                  <div>
                    <div class="text-2xl font-medium text-blue-700">8</div>
                    <div class="text-sm text-slate-600">开发阶段</div>
                  </div>
                  <div>
                    <div class="text-2xl font-medium text-emerald-700">2</div>
                    <div class="text-sm text-slate-600">核心开发者</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer class="bg-slate-800 text-stone-50 py-12">
      <div class="max-w-6xl mx-auto px-6">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
          <div>
            <div class="flex items-center space-x-2 mb-4">
              <div class="w-8 h-8 bg-stone-50 rounded-md flex items-center justify-center">
                <svg class="w-4 h-4 text-slate-800" fill="currentColor" viewBox="0 0 20 20">
                  <path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z"/>
                  <path fill-rule="evenodd" d="M4 5a2 2 0 012-2v1a3 3 0 003 3h2a3 3 0 003-3V3a2 2 0 012 2v6a2 2 0 01-2 2H6a2 2 0 01-2-2V5z" clip-rule="evenodd"/>
                </svg>
              </div>
              <span class="font-medium">PatPilot</span>
            </div>
            <p class="text-stone-300 text-sm">
              AI驱动的智能专利生成与管理系统
            </p>
          </div>
          <div>
            <h4 class="font-medium mb-4">产品</h4>
            <ul class="space-y-2 text-stone-300 text-sm">
              <li><a href="#" class="hover:text-stone-50 transition-colors">功能特色</a></li>
              <li><a href="#" class="hover:text-stone-50 transition-colors">定价方案</a></li>
              <li><a href="#" class="hover:text-stone-50 transition-colors">API文档</a></li>
            </ul>
          </div>
          <div>
            <h4 class="font-medium mb-4">支持</h4>
            <ul class="space-y-2 text-stone-300 text-sm">
              <li><a href="#" class="hover:text-stone-50 transition-colors">帮助中心</a></li>
              <li><a href="#" class="hover:text-stone-50 transition-colors">联系我们</a></li>
              <li><a href="#" class="hover:text-stone-50 transition-colors">技术支持</a></li>
            </ul>
          </div>
          <div>
            <h4 class="font-medium mb-4">联系方式</h4>
            <div class="text-stone-300 text-sm space-y-2">
              <p>邮箱：hello@patpilot.com</p>
              <p>项目：github.com/zhenzhiyang/PatPilot</p>
            </div>
          </div>
        </div>
        <div class="border-t border-slate-700 mt-12 pt-8 text-center text-stone-300 text-sm">
          <p>&copy; 2024 PatPilot. All rights reserved.</p>
        </div>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const isMobileMenuOpen = ref(false)

const toggleMobileMenu = () => {
  isMobileMenuOpen.value = !isMobileMenuOpen.value
}
</script>

<style scoped>
/* 动画关键帧定义 */
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

.animation-delay-1500 {
  animation-delay: 1500ms;
}

.animation-delay-2000 {
  animation-delay: 2000ms;
}

.animation-delay-2500 {
  animation-delay: 2500ms;
}

.animation-delay-500 {
  animation-delay: 500ms;
}

/* 确保字体渲染平滑 */
.font-light {
  font-weight: 300;
}

/* 自定义滚动行为 */
html {
  scroll-behavior: smooth;
}
</style>