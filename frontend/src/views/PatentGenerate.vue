<template>
  <div class="min-h-screen w-full bg-slate-50 text-slate-800">
    <TopNav />
    <div class="flex pt-16">
    <!-- Sidebar -->
    <aside class="w-72 bg-white border-r border-slate-200 p-3 hidden md:block xl:sticky xl:top-16 xl:h-[calc(100vh-64px)] overflow-y-auto">
      <nav class="space-y-6 pr-2">
        <div>
          <div class="text-xs uppercase tracking-wider text-slate-500 mb-2">⚡ 创作模式</div>
          <ul class="space-y-1">
            <li><button class="nav-item" :class="isMode('quick')" @click="setMode('quick')">快速生成（一键整篇）</button></li>
            <li><button class="nav-item" :class="isMode('modular')" @click="setMode('modular')">模块生成（逐步撰写）</button></li>
          </ul>
            </div>
        <div>
          <div class="text-xs uppercase tracking-wider text-slate-500 mb-2">📄 项目</div>
          <ul class="space-y-1">
            <li><button class="nav-item" @click="setActive('project','new')">新建专利</button></li>
            <li><button class="nav-item" @click="setActive('project','history')">历史项目</button></li>
            <li><button class="nav-item" @click="setActive('project','drafts')">草稿箱</button></li>
          </ul>
                    </div>
        <div v-if="state.mode === 'modular'">
          <div class="text-xs uppercase tracking-wider text-slate-500 mb-2">📝 专利撰写</div>
          <ul class="space-y-1">
            <li><button class="nav-item" :class="isActive('writing','basic')" @click="setActive('writing','basic')">基本信息</button></li>
            <li><button class="nav-item" :class="isActive('writing','background')" @click="setActive('writing','background')">技术领域与背景技术</button></li>
            <li><button class="nav-item" :class="isActive('writing','invention')" @click="setActive('writing','invention')">发明内容</button></li>
            <li><button class="nav-item" :class="isActive('writing','figures')" @click="setActive('writing','figures')">附图与说明</button></li>
            <li><button class="nav-item" :class="isActive('writing','claims')" @click="setActive('writing','claims')">权利要求书</button></li>
            <li><button class="nav-item" :class="isActive('writing','abstract')" @click="setActive('writing','abstract')">摘要与附图摘要</button></li>
            <li><button class="nav-item" :class="isActive('writing','ai')" @click="setActive('writing','ai')">AI润色与查重</button></li>
          </ul>
                    </div>
        <div>
          <div class="text-xs uppercase tracking-wider text-slate-500 mb-2">📂 工具与辅助</div>
          <ul class="space-y-1">
            <li><button class="nav-item" @click="setActive('tools','ai-search')">AI参考检索（专利对比）</button></li>
            <li><button class="nav-item" @click="setActive('tools','ipc')">IPC/CPC 分类号检索</button></li>
            <li><button class="nav-item" @click="setActive('tools','claims-check')">权利要求结构校验</button></li>
            <li><button class="nav-item" @click="setActive('tools','style-check')">规范性/格式校对</button></li>
            <li><button class="nav-item" @click="setActive('tools','templates')">模板库（快速导入）</button></li>
          </ul>
                    </div>
        <div>
          <div class="text-xs uppercase tracking-wider text-slate-500 mb-2">⚙️ 设置</div>
          <ul class="space-y-1">
            <li><button class="nav-item" @click="setActive('settings','export')">导出/下载（Word、PDF）</button></li>
            <li><button class="nav-item" @click="setActive('settings','i18n')">语言切换</button></li>
            <li><button class="nav-item" @click="setActive('settings','account')">账户信息</button></li>
          </ul>
                </div>
            </nav>
        </aside>
        
    <!-- Main + Editor -->
    <main class="flex-1 flex flex-col">
            
      <!-- Content & Right Editor -->
      <div class="flex-1 min-h-0 grid grid-cols-1 lg:grid-cols-[minmax(0,0.55fr)_minmax(700px,1fr)] gap-0">
        <!-- Form Content -->
        <section class="p-4 overflow-y-auto">
          <div class="mx-auto w-full max-w-5xl space-y-4">
          <!-- 基本信息 -->
          <div v-if="is('writing','basic')" class="card">
            <div class="card-body grid md:grid-cols-2 gap-4">
              <div>
                <label class="form-label">专利类型</label>
                <el-select v-model="form.basic.type" placeholder="请选择">
                  <el-option label="发明" value="发明" />
                  <el-option label="实用新型" value="实用新型" />
                  <el-option label="外观设计" value="外观设计" />
                </el-select>
                        </div>
              <div>
                <label class="form-label">专利名称</label>
                <el-input v-model="form.basic.title" placeholder="请输入专利名称" />
                    </div>
              <div>
                <label class="form-label">申请人</label>
                <el-input v-model="form.basic.applicant" placeholder="申请人名称" />
                                </div>
              <div>
                <label class="form-label">发明人</label>
                <el-input v-model="form.basic.inventors" placeholder="多个用 、 分隔" />
                        </div>
                    </div>
                </div>
                
          <!-- 技术领域与背景技术 -->
          <div v-else-if="is('writing','background')" class="card">
            <div class="card-body grid gap-4">
              <div>
                <label class="form-label">行业背景</label>
                <el-input v-model="form.background.industry" type="textarea" :rows="4" placeholder="行业现状、技术发展趋势…" />
                        </div>
              <div>
                <label class="form-label">现有技术不足</label>
                <el-input v-model="form.background.issues" type="textarea" :rows="6" placeholder="存在的问题、痛点…" />
                        </div>
                    </div>
                </div>
                
          <!-- 发明内容 -->
          <div v-else-if="is('writing','invention')" class="card">
            <div class="card-body grid gap-4">
              <div>
                <label class="form-label">技术方案</label>
                <el-input v-model="form.invention.solution" type="textarea" :rows="8" placeholder="详细描述核心方案、模块、流程…" />
                        </div>
              <div>
                <label class="form-label">有益效果</label>
                <el-input v-model="form.invention.effects" type="textarea" :rows="6" placeholder="与现有技术相比的改进与效果…" />
                        </div>
                    </div>
                </div>
                
          <!-- 附图与说明 -->
          <div v-else-if="is('writing','figures')" class="card">
            <div class="card-body grid gap-4">
              <div>
                <label class="form-label">上传或生成附图</label>
                <el-upload drag multiple action="#" :auto-upload="false">
                  <i class="el-icon--upload"></i>
                  <div class="el-upload__text">将文件拖到此处，或 <em>点击上传</em></div>
                </el-upload>
                        </div>
              <div>
                <label class="form-label">图示说明</label>
                <el-input v-model="form.figures.caption" type="textarea" :rows="6" placeholder="附图的编号与说明…" />
                        </div>
                    </div>
                </div>
                
          <!-- 权利要求书 -->
          <div v-else-if="is('writing','claims')" class="card">
            <div class="card-body grid gap-4">
              <div>
                <label class="form-label">独立权利要求</label>
                <el-input v-model="form.claims.independent" type="textarea" :rows="6" placeholder="独立权利要求内容…" />
                        </div>
              <div>
                <label class="form-label">从属权利要求</label>
                <el-input v-model="form.claims.dependent" type="textarea" :rows="6" placeholder="从属权利要求条款，编号换行…" />
                    </div>
                </div>
            </div>
            
          <!-- 摘要与附图摘要 -->
          <div v-else-if="is('writing','abstract')" class="card">
            <div class="card-body grid gap-4">
              <div>
                <label class="form-label">摘要</label>
                <el-input v-model="form.abstract.text" type="textarea" :rows="6" placeholder="技术要点、实现方式与效果的简要概述…" />
              </div>
            </div>
            </div>
            
          <!-- AI 润色与查重（占位） -->
          <div v-else-if="is('writing','ai')" class="card">
            <div class="card-body">
              <el-alert title="将整合到右侧编辑器统一展示，点击上方“AI 生成 / AI 润色”即可。" type="info" show-icon />
                </div>
            </div>
            
          <!-- 其他占位页面 -->
          <div v-else class="card">
            <div class="card-body">
              <el-empty description="该功能即将上线" />
            </div>
          </div>
          </div>
        </section>

        <!-- Right Editor -->
        <aside class="border-l border-slate-200 bg-white p-4 sticky top-16 h-[calc(100vh-64px)] overflow-hidden flex flex-col">
          <Toolbar
            style="border: 1px solid #e2e8f0; border-bottom: none; border-radius: 8px 8px 0 0;"
            :editor="wangEditorRef"
            :default-config="toolbarConfig"
            :mode="'default'"
          />
          <div class="flex-1 min-h-0">
            <Editor
              v-model="editorHtml"
              style="height: 100%; border: 1px solid #e2e8f0; border-radius: 0 0 8px 8px;"
              :default-config="editorConfig"
              :mode="'default'"
              @onCreated="handleCreated"
            />
            </div>
        </aside>
      </div>
    </main>
    </div>
  </div>
</template>

<script setup>
import { reactive, ref, computed, onBeforeUnmount } from 'vue'
import '@wangeditor/editor/dist/css/style.css'
import { Editor, Toolbar } from '@wangeditor/editor-for-vue'
import TopNav from '@/components/TopNav.vue'

const state = reactive({
  group: 'writing',
  key: 'basic'
})

const form = reactive({
  basic: { type: '', title: '', applicant: '', inventors: '' },
  background: { industry: '', issues: '' },
  invention: { solution: '', effects: '' },
  figures: { caption: '' },
  claims: { independent: '', dependent: '' },
  abstract: { text: '' }
})

const editorHtml = ref('')
const wangEditorRef = ref(null)
const toolbarConfig = { excludeKeys: [] }
const editorConfig = { placeholder: 'AI生成的内容将展示在此，您可以直接编辑…', MENU_CONF: { uploadImage: { base64LimitSize: 5 * 1024 } } }

const pageTitle = computed(() => {
  const map = {
    basic: '基本信息',
    background: '技术领域与背景技术',
    invention: '发明内容',
    figures: '附图与说明',
    claims: '权利要求书',
    abstract: '摘要与附图摘要',
    ai: 'AI 润色与查重'
  }
  return state.mode === 'quick' ? '快速生成' : (map[state.key] || '专利撰写')
})

const breadcrumb = computed(() => pageTitle.value)

const setActive = (group, key) => {
  state.group = group
  state.key = key
}

const is = (group, key) => state.group === group && state.key === key
const isActive = (group, key) => ({ 'bg-blue-50 text-blue-700': is(group, key) })

// 创作模式
state.mode = 'quick' // quick | modular
const setMode = (mode) => { state.mode = mode }
const isMode = (mode) => ({ 'bg-blue-50 text-blue-700': state.mode === mode })

// 快速生成数据
const quick = reactive({ type: '', domain: '', prompt: '' })
const generateFromPrompt = () => {
  const title = quick.domain ? `${quick.domain}相关${quick.type || '专利'}` : `${quick.type || '专利'}方案`
  const sections = [
    `# ${title}`,
    `【技术领域】本申请涉及${quick.domain || '相关'}领域。`,
    `【背景技术】针对现有技术中的不足，提出改进方案。`,
    `【发明内容】根据您的需求描述：${quick.prompt || '（未提供详细需求，将使用通用结构）'}。`,
    `【有益效果】本申请具有结构简化、实现方便、成本可控等优点。`,
    `【附图说明】附图用于解释本申请的实施方式。`,
    `【具体实施方式】结合附图对方案的结构与流程进行详细说明。`
  ]
  editorHtml.value = sections.join('<br/><br/>')
}

const generateFromForm = () => {
  // 简单的拼接生成占位文本，后续可接入后端/LLM
  const sections = []
  if (form.basic.title) sections.push(`# ${form.basic.title}`)
  if (form.basic.type || form.basic.applicant || form.basic.inventors) {
    sections.push(`类型：${form.basic.type || '-'}\n申请人：${form.basic.applicant || '-'}\n发明人：${form.basic.inventors || '-'}`)
  }
  if (form.background.industry) sections.push(`【行业背景】\n${form.background.industry}`)
  if (form.background.issues) sections.push(`【现有技术不足】\n${form.background.issues}`)
  if (form.invention.solution) sections.push(`【技术方案】\n${form.invention.solution}`)
  if (form.invention.effects) sections.push(`【有益效果】\n${form.invention.effects}`)
  if (form.figures.caption) sections.push(`【附图说明】\n${form.figures.caption}`)
  if (form.claims.independent) sections.push(`【独立权利要求】\n${form.claims.independent}`)
  if (form.claims.dependent) sections.push(`【从属权利要求】\n${form.claims.dependent}`)
  if (form.abstract.text) sections.push(`【摘要】\n${form.abstract.text}`)
  const md = sections.join('\n\n')
  editorHtml.value = md.replace(/\n/g, '<br/>')
}

const beautifyEditor = () => {
  if (!editorHtml.value) return
  // 简易“润色”：去除多余空格并统一标点间距
  editorHtml.value = editorHtml.value
    .replace(/\s+\n/g, '\n')
    .replace(/\n{3,}/g, '\n\n')
    .replace(/【/g, '【').replace(/】/g, '】')
}

const clearEditor = () => { editorHtml.value = '' }

const saveDraft = () => {
  const payload = { form: JSON.parse(JSON.stringify(form)), editor: editorHtml.value, savedAt: new Date().toISOString() }
  localStorage.setItem('patent_draft', JSON.stringify(payload))
}

const exportAs = (ext) => {
  const blob = new Blob([editorHtml.value || ''], { type: 'text/plain;charset=utf-8' })
  const url = URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url
  a.download = `${form.basic.title || '专利文稿'}.${ext}`
  document.body.appendChild(a)
  a.click()
  a.remove()
  URL.revokeObjectURL(url)
}

const handleCreated = (editorInstance) => { wangEditorRef.value = editorInstance }
onBeforeUnmount(() => { if (wangEditorRef.value) wangEditorRef.value.destroy() })
</script>

<style scoped>
.nav-item {
  @apply w-full text-left px-3 py-2 rounded-md hover:bg-slate-100 transition-colors text-sm;
}
.card {
  @apply bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden;
}
.card-header {
  @apply px-4 py-3 border-b border-slate-200 bg-slate-50 font-medium text-slate-700;
}
.card-body { @apply p-4; }
.form-label { @apply block mb-2 text-sm text-slate-600; }
</style>


