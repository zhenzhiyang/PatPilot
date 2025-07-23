<template>
  <div class="dashboard">
    <el-container class="dashboard-container">
      <el-aside width="250px" class="sidebar">
        <div class="logo">
          <h3>AI专利系统</h3>
        </div>
        
        <el-menu
          default-active="dashboard"
          class="sidebar-menu"
          :router="true"
        >
          <el-menu-item index="/dashboard">
            <el-icon><Odometer /></el-icon>
            <span>仪表盘</span>
          </el-menu-item>
          
          <el-menu-item index="/patent/generate">
            <el-icon><DocumentAdd /></el-icon>
            <span>专利生成</span>
          </el-menu-item>
          
          <el-menu-item index="/patent/manage">
            <el-icon><Document /></el-icon>
            <span>专利管理</span>
          </el-menu-item>
          
          <el-menu-item index="/template/manage">
            <el-icon><Collection /></el-icon>
            <span>模板管理</span>
          </el-menu-item>
        </el-menu>
      </el-aside>
      
      <el-container>
        <el-header class="header">
          <div class="header-content">
            <el-breadcrumb separator="/">
              <el-breadcrumb-item>仪表盘</el-breadcrumb-item>
            </el-breadcrumb>
            
            <div class="user-menu">
              <el-dropdown>
                <span class="user-name">
                  {{ userStore.user?.username || '用户' }}
                  <el-icon><ArrowDown /></el-icon>
                </span>
                <template #dropdown>
                  <el-dropdown-menu>
                    <el-dropdown-item>个人设置</el-dropdown-item>
                    <el-dropdown-item @click="handleLogout">退出登录</el-dropdown-item>
                  </el-dropdown-menu>
                </template>
              </el-dropdown>
            </div>
          </div>
        </el-header>
        
        <el-main class="main-content">
          <div class="stats-section">
            <el-row :gutter="20">
              <el-col :span="6">
                <el-card class="stat-card">
                  <div class="stat-content">
                    <div class="stat-icon">
                      <el-icon color="#409eff"><Document /></el-icon>
                    </div>
                    <div class="stat-info">
                      <div class="stat-number">{{ stats.totalPatents }}</div>
                      <div class="stat-label">总专利数</div>
                    </div>
                  </div>
                </el-card>
              </el-col>
              
              <el-col :span="6">
                <el-card class="stat-card">
                  <div class="stat-content">
                    <div class="stat-icon">
                      <el-icon color="#67c23a"><DocumentAdd /></el-icon>
                    </div>
                    <div class="stat-info">
                      <div class="stat-number">{{ stats.generatedToday }}</div>
                      <div class="stat-label">今日生成</div>
                    </div>
                  </div>
                </el-card>
              </el-col>
              
              <el-col :span="6">
                <el-card class="stat-card">
                  <div class="stat-content">
                    <div class="stat-icon">
                      <el-icon color="#e6a23c"><Collection /></el-icon>
                    </div>
                    <div class="stat-info">
                      <div class="stat-number">{{ stats.totalTemplates }}</div>
                      <div class="stat-label">模板数量</div>
                    </div>
                  </div>
                </el-card>
              </el-col>
              
              <el-col :span="6">
                <el-card class="stat-card">
                  <div class="stat-content">
                    <div class="stat-icon">
                      <el-icon color="#f56c6c"><TrendCharts /></el-icon>
                    </div>
                    <div class="stat-info">
                      <div class="stat-number">{{ stats.successRate }}%</div>
                      <div class="stat-label">成功率</div>
                    </div>
                  </div>
                </el-card>
              </el-col>
            </el-row>
          </div>
          
          <div class="recent-section">
            <el-card>
              <template #header>
                <div class="card-header">
                  <span>最近生成的专利</span>
                  <el-button type="primary" @click="$router.push('/patent/generate')">
                    新建专利
                  </el-button>
                </div>
              </template>
              
              <el-table :data="recentPatents" style="width: 100%">
                <el-table-column prop="title" label="专利标题" />
                <el-table-column prop="type" label="类型" width="120" />
                <el-table-column prop="status" label="状态" width="120">
                  <template #default="{ row }">
                    <el-tag :type="getStatusType(row.status)">
                      {{ row.status }}
                    </el-tag>
                  </template>
                </el-table-column>
                <el-table-column prop="createdAt" label="创建时间" width="180" />
                <el-table-column label="操作" width="200">
                  <template #default="{ row }">
                    <el-button size="small" @click="viewPatent(row.id)">
                      查看
                    </el-button>
                    <el-button size="small" type="primary" @click="editPatent(row.id)">
                      编辑
                    </el-button>
                  </template>
                </el-table-column>
              </el-table>
            </el-card>
          </div>
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script>
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '@/store/user'
import { 
  Odometer, 
  DocumentAdd, 
  Document, 
  Collection, 
  ArrowDown,
  TrendCharts
} from '@element-plus/icons-vue'

export default {
  name: 'Dashboard',
  components: {
    Odometer,
    DocumentAdd,
    Document,
    Collection,
    ArrowDown,
    TrendCharts
  },
  setup() {
    const router = useRouter()
    const userStore = useUserStore()
    
    const stats = reactive({
      totalPatents: 0,
      generatedToday: 0,
      totalTemplates: 0,
      successRate: 0
    })
    
    const recentPatents = ref([])
    
    const getStatusType = (status) => {
      const statusMap = {
        '已完成': 'success',
        '生成中': 'warning',
        '草稿': 'info',
        '失败': 'danger'
      }
      return statusMap[status] || 'info'
    }
    
    const handleLogout = () => {
      userStore.logout()
      router.push('/login')
    }
    
    const viewPatent = (id) => {
      router.push(`/patent/${id}`)
    }
    
    const editPatent = (id) => {
      router.push(`/patent/edit/${id}`)
    }
    
    const fetchDashboardData = async () => {
      // 模拟数据
      stats.totalPatents = 45
      stats.generatedToday = 3
      stats.totalTemplates = 12
      stats.successRate = 95
      
      recentPatents.value = [
        {
          id: 1,
          title: '基于深度学习的图像识别专利',
          type: '发明专利',
          status: '已完成',
          createdAt: '2024-01-15 14:30'
        },
        {
          id: 2,
          title: '智能语音交互系统',
          type: '实用新型',
          status: '生成中',
          createdAt: '2024-01-15 10:20'
        }
      ]
    }
    
    onMounted(() => {
      fetchDashboardData()
    })
    
    return {
      userStore,
      stats,
      recentPatents,
      getStatusType,
      handleLogout,
      viewPatent,
      editPatent
    }
  }
}
</script>

<style scoped>
.dashboard-container {
  height: 100vh;
}

.sidebar {
  background: #304156;
  color: white;
}

.logo {
  padding: 20px;
  text-align: center;
  border-bottom: 1px solid #434a50;
}

.logo h3 {
  margin: 0;
  color: white;
}

.sidebar-menu {
  border: none;
  background: transparent;
}

.header {
  background: white;
  border-bottom: 1px solid #e4e7ed;
  padding: 0 20px;
}

.header-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 100%;
}

.user-name {
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 8px;
}

.main-content {
  padding: 20px;
  background: #f5f5f5;
}

.stats-section {
  margin-bottom: 20px;
}

.stat-card {
  cursor: pointer;
  transition: transform 0.2s;
}

.stat-card:hover {
  transform: translateY(-2px);
}

.stat-content {
  display: flex;
  align-items: center;
  gap: 16px;
}

.stat-icon {
  font-size: 32px;
}

.stat-number {
  font-size: 24px;
  font-weight: bold;
  color: #303133;
}

.stat-label {
  color: #909399;
  font-size: 14px;
}

.recent-section {
  background: white;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>