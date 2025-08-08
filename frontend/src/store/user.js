import { defineStore } from 'pinia'

export const useUserStore = defineStore('user', {
  state: () => ({
    user: null,
    token: localStorage.getItem('token') || null,
    isAuthenticated: false
  }),
  
  getters: {
    getUserInfo: (state) => state.user,
    getToken: (state) => state.token,
    isLoggedIn: (state) => !!state.token
  },
  
  actions: {
    setUser(userData) {
      this.user = userData
      this.isAuthenticated = true
    },
    
    setToken(token) {
      this.token = token
      localStorage.setItem('token', token)
      this.isAuthenticated = true
    },
    
    logout() {
      this.user = null
      this.token = null
      this.isAuthenticated = false
      localStorage.removeItem('token')
    },
    
    async login(credentials) {
      try {
        // 检查是否是测试账号
        if (credentials.username === 'admin' && credentials.password === 'admin') {
          // 模拟成功登录
          const testUser = {
            id: 1,
            username: 'admin',
            email: 'admin@patpilot.com',
            role: 'admin'
          }
          
          this.setToken('demo-token-' + Date.now())
          this.setUser(testUser)
          return { success: true, user: testUser }
        }
        
        // 尝试真实API登录
        const response = await fetch('/api/auth/login', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify(credentials)
        })
        
        const data = await response.json()
        
        if (response.ok) {
          this.setToken(data.token)
          this.setUser(data.user)
          return { success: true, user: data.user }
        } else {
          return { success: false, message: data.message || '登录失败' }
        }
      } catch (error) {
        console.error('Login error:', error)
        return { success: false, message: '网络连接失败' }
      }
    }
  }
})