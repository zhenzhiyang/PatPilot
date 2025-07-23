import { createRouter, createWebHistory } from 'vue-router'
import Home from '@/views/Home.vue'
import Login from '@/views/Login.vue'
import Dashboard from '@/views/Dashboard.vue'
import PatentGenerate from '@/views/PatentGenerate.vue'
import PatentManage from '@/views/PatentManage.vue'
import TemplateManage from '@/views/TemplateManage.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/login',
    name: 'Login',
    component: Login
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    component: Dashboard,
    meta: { requiresAuth: true }
  },
  {
    path: '/patent/generate',
    name: 'PatentGenerate',
    component: PatentGenerate,
    meta: { requiresAuth: true }
  },
  {
    path: '/patent/manage',
    name: 'PatentManage',
    component: PatentManage,
    meta: { requiresAuth: true }
  },
  {
    path: '/template/manage',
    name: 'TemplateManage',
    component: TemplateManage,
    meta: { requiresAuth: true }
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

router.beforeEach((to, from, next) => {
  const token = localStorage.getItem('token')
  
  if (to.meta.requiresAuth && !token) {
    next('/login')
  } else {
    next()
  }
})

export default router