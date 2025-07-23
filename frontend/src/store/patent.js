import { defineStore } from 'pinia'

export const usePatentStore = defineStore('patent', {
  state: () => ({
    patents: [],
    currentPatent: null,
    templates: [],
    isGenerating: false,
    generationProgress: 0
  }),
  
  getters: {
    getPatents: (state) => state.patents,
    getCurrentPatent: (state) => state.currentPatent,
    getTemplates: (state) => state.templates,
    isPatentGenerating: (state) => state.isGenerating
  },
  
  actions: {
    setPatents(patents) {
      this.patents = patents
    },
    
    setCurrentPatent(patent) {
      this.currentPatent = patent
    },
    
    setTemplates(templates) {
      this.templates = templates
    },
    
    setGenerating(status) {
      this.isGenerating = status
    },
    
    setGenerationProgress(progress) {
      this.generationProgress = progress
    },
    
    async fetchPatents() {
      try {
        const response = await fetch('/api/patents', {
          headers: {
            'Authorization': `Bearer ${this.token}`
          }
        })
        const data = await response.json()
        this.setPatents(data)
      } catch (error) {
        console.error('获取专利列表失败:', error)
      }
    },
    
    async generatePatent(patentData) {
      this.setGenerating(true)
      this.setGenerationProgress(0)
      
      try {
        const response = await fetch('/api/patents/generate', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${this.token}`
          },
          body: JSON.stringify(patentData)
        })
        
        const data = await response.json()
        
        if (response.ok) {
          this.setCurrentPatent(data)
          this.setGenerationProgress(100)
          return { success: true, patent: data }
        } else {
          return { success: false, message: data.message }
        }
      } catch (error) {
        return { success: false, message: '专利生成失败' }
      } finally {
        this.setGenerating(false)
      }
    }
  }
})