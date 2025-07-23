import api from './index'

export const authAPI = {
  login: (credentials) => api.post('/auth/login', credentials),
  register: (userData) => api.post('/auth/register', userData),
  logout: () => api.post('/auth/logout'),
  refreshToken: () => api.post('/auth/refresh'),
  getUserProfile: () => api.get('/auth/profile')
}

export const patentAPI = {
  getPatents: (params) => api.get('/patents', { params }),
  getPatentById: (id) => api.get(`/patents/${id}`),
  createPatent: (data) => api.post('/patents', data),
  updatePatent: (id, data) => api.put(`/patents/${id}`, data),
  deletePatent: (id) => api.delete(`/patents/${id}`),
  generatePatent: (data) => api.post('/patents/generate', data),
  exportPatent: (id, format) => api.get(`/patents/${id}/export?format=${format}`, { responseType: 'blob' })
}

export const templateAPI = {
  getTemplates: (params) => api.get('/templates', { params }),
  getTemplateById: (id) => api.get(`/templates/${id}`),
  createTemplate: (data) => api.post('/templates', data),
  updateTemplate: (id, data) => api.put(`/templates/${id}`, data),
  deleteTemplate: (id) => api.delete(`/templates/${id}`)
}

export const aiAPI = {
  generateText: (data) => api.post('/ai/generate', data),
  checkPlagiarism: (text) => api.post('/ai/check-plagiarism', { text }),
  rewriteText: (text, options) => api.post('/ai/rewrite', { text, options }),
  analyzeText: (text) => api.post('/ai/analyze', { text })
}