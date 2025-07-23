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
          return { success: true }
        } else {
          return { success: false, message: data.message }
        }
      } catch (error) {
        return { success: false, message: '登录失败' }
      }
    }
  }
})