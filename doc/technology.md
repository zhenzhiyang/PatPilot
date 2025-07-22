# AI专利生成系统 - 技术架构详解

## 🏗️ 系统整体架构

### 架构概览
```
┌─────────────────────────────────────────────────────────────┐
│                        前端层                                │
├─────────────────────────────────────────────────────────────┤
│  Vue3 + Vite + TypeScript + ElementPlus                    │
│  ├─ 用户认证模块                                             │
│  ├─ 模板管理模块                                             │
│  ├─ 专利生成模块                                             │
│  ├─ 反查重模块                                               │
│  └─ 文档管理模块                                             │
├─────────────────────────────────────────────────────────────┤
│                      网关层                                  │
├─────────────────────────────────────────────────────────────┤
│  Spring Cloud Gateway                                       │
│  ├─ 路由转发                                                │
│  ├─ 鉴权认证                                                │
│  ├─ 限流熔断                                                │
│  └─ 日志监控                                                │
├─────────────────────────────────────────────────────────────┤
│                    业务服务层                               │
├─────────────────────────────────────────────────────────────┤
│  用户服务 │ 模板服务 │ AI服务 │ 查重服务 │ 文件服务          │
├─────────────────────────────────────────────────────────────┤
│                    数据层                                   │
├─────────────────────────────────────────────────────────────┤
│  MySQL │ Redis │ Elasticsearch │ MinIO │ RabbitMQ          │
├─────────────────────────────────────────────────────────────┤
│                    AI引擎层                                 │
├─────────────────────────────────────────────────────────────┤
│  Python AI服务                                              │
│  ├─ 文本生成模型                                            │
│  ├─ 反查重引擎                                              │
│  ├─ 语义分析                                                │
│  └─ 改写优化                                                │
└─────────────────────────────────────────────────────────────┘
```

---

## 💻 前端技术栈详解

### Vue3 + Composition API
```typescript
// 组件示例
<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { usePatentStore } from '@/stores/patent'

const patentStore = usePatentStore()
const patentData = ref({})

const generatedPatent = computed(() => patentStore.generatedContent)

onMounted(async () => {
  await patentStore.fetchTemplates()
})
</script>
```

### 状态管理 - Pinia
```typescript
// stores/patent.ts
import { defineStore } from 'pinia'
import { patentApi } from '@/api'

export const usePatentStore = defineStore('patent', {
  state: () => ({
    templates: [],
    currentPatent: null,
    generationStatus: 'idle',
    antiPlagiarismResults: []
  }),
  
  actions: {
    async generatePatent(data: PatentRequest) {
      this.generationStatus = 'generating'
      try {
        const response = await patentApi.generate(data)
        this.currentPatent = response.data
        this.generationStatus = 'completed'
      } catch (error) {
        this.generationStatus = 'failed'
      }
    }
  }
})
```

### 网络请求 - Axios封装
```typescript
// api/request.ts
import axios from 'axios'
import { useAuthStore } from '@/stores/auth'

const request = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL,
  timeout: 30000
})

// 请求拦截器
request.interceptors.request.use(config => {
  const authStore = useAuthStore()
  if (authStore.token) {
    config.headers.Authorization = `Bearer ${authStore.token}`
  }
  return config
})

// 响应拦截器
request.interceptors.response.use(
  response => response.data,
  error => {
    if (error.response?.status === 401) {
      // 处理token过期
    }
    return Promise.reject(error)
  }
)
```

---

## ⚙️ 后端技术栈详解

### Spring Boot微服务架构

#### 1. 用户服务 (patent-user-service)
```java
@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {
    
    private final UserService userService;
    private final JwtTokenUtil jwtTokenUtil;
    
    @PostMapping("/register")
    public ResponseEntity<UserResponse> register(@Valid @RequestBody RegisterRequest request) {
        User user = userService.register(request);
        return ResponseEntity.ok(UserResponse.from(user));
    }
    
    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(@Valid @RequestBody LoginRequest request) {
        AuthResponse response = userService.login(request);
        return ResponseEntity.ok(response);
    }
}
```

#### 2. AI服务 (patent-ai-service)
```java
@Service
public class PatentGenerationService {
    
    @Autowired
    private OpenAiClient openAiClient;
    
    @Autowired
    private RedisTemplate<String, Object> redisTemplate;
    
    @Async
    @RabbitListener(queues = "patent.generation")
    public void handleGenerationTask(PatentGenerationTask task) {
        try {
            // 1. 检查缓存
            String cacheKey = generateCacheKey(task);
            String cachedResult = (String) redisTemplate.opsForValue().get(cacheKey);
            
            if (cachedResult != null) {
                updateTaskStatus(task.getId(), cachedResult);
                return;
            }
            
            // 2. 调用AI生成
            String generatedContent = openAiClient.generatePatent(task);
            
            // 3. 缓存结果
            redisTemplate.opsForValue().set(cacheKey, generatedContent, Duration.ofHours(24));
            
            // 4. 更新任务状态
            updateTaskStatus(task.getId(), generatedContent);
            
        } catch (Exception e) {
            handleGenerationError(task.getId(), e);
        }
    }
}
```

#### 3. 反查重服务 (patent-anti-plagiarism-service)
```java
@Service
public class AntiPlagiarismService {
    
    @Autowired
    private SimilarityCalculator similarityCalculator;
    
    @Autowired
    private TextRewriter textRewriter;
    
    public PlagiarismCheckResult checkAndRewrite(String content) {
        // 1. 分块检测
        List<TextBlock> blocks = splitIntoBlocks(content);
        
        // 2. 并行查重
        List<CompletableFuture<SimilarityResult>> futures = blocks.stream()
            .map(block -> CompletableFuture.supplyAsync(() -> 
                similarityCalculator.calculate(block)))
            .collect(Collectors.toList());
        
        // 3. 结果聚合
        List<SimilarityResult> results = futures.stream()
            .map(CompletableFuture::join)
            .collect(Collectors.toList());
        
        // 4. 智能改写
        List<TextBlock> rewrittenBlocks = results.stream()
            .filter(r -> r.getSimilarity() > 0.15)
            .map(r -> textRewriter.rewrite(r.getBlock()))
            .collect(Collectors.toList());
        
        return new PlagiarismCheckResult(results, rewrittenBlocks);
    }
}
```

---

## 🗄️ 数据层技术详解

### MySQL 8.0 优化配置
```sql
-- 专利表优化
CREATE TABLE `patent_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(500) NOT NULL COMMENT '专利标题',
  `application_number` varchar(50) COMMENT '申请号',
  `patent_type` tinyint NOT NULL COMMENT '专利类型',
  `content` longtext COMMENT '专利内容',
  `status` tinyint DEFAULT 1 COMMENT '状态',
  `created_by` bigint NOT NULL,
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_application_number` (`application_number`),
  KEY `idx_created_by` (`created_by`),
  FULLTEXT INDEX `idx_content` (`content`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Redis缓存策略
```java
@Configuration
@EnableCaching
public class RedisConfig {
    
    @Bean
    public RedisTemplate<String, Object> redisTemplate(RedisConnectionFactory factory) {
        RedisTemplate<String, Object> template = new RedisTemplate<>();
        template.setConnectionFactory(factory);
        
        // 使用JSON序列化
        Jackson2JsonRedisSerializer<Object> serializer = 
            new Jackson2JsonRedisSerializer<>(Object.class);
        template.setDefaultSerializer(serializer);
        
        return template;
    }
    
    @Cacheable(value = "patentTemplates", key = "#categoryId")
    public List<PatentTemplate> getTemplatesByCategory(Long categoryId) {
        return templateRepository.findByCategoryId(categoryId);
    }
}
```

### Elasticsearch全文检索
```java
@Document(indexName = "patents")
public class PatentDocument {
    
    @Id
    private Long id;
    
    @Field(type = FieldType.Text, analyzer = "ik_max_word")
    private String title;
    
    @Field(type = FieldType.Text, analyzer = "ik_max_word")
    private String content;
    
    @Field(type = FieldType.Keyword)
    private String patentType;
    
    @Field(type = FieldType.Date)
    private LocalDateTime createdTime;
}
```

---

## 🤖 AI引擎技术详解

### Python AI服务架构
```python
# app.py
from fastapi import FastAPI
from patent_ai.engine import PatentGenerationEngine
from patent_ai.anti_plagiarism import AntiPlagiarismEngine

app = FastAPI(title="Patent AI Engine")

# 初始化引擎
generation_engine = PatentGenerationEngine()
plagiarism_engine = AntiPlagiarismEngine()

@app.post("/api/generate")
async def generate_patent(request: PatentRequest):
    """生成专利文本"""
    return await generation_engine.generate(request)

@app.post("/api/check-plagiarism")
async def check_plagiarism(content: str):
    """检查相似度并改写"""
    return await plagiarism_engine.check_and_rewrite(content)
```

### 文本生成模型集成
```python
# patent_ai/generation.py
import openai
from transformers import pipeline
from langchain.prompts import PromptTemplate

class PatentGenerationEngine:
    def __init__(self):
        self.openai_client = openai.OpenAI(api_key=os.getenv("OPENAI_API_KEY"))
        self.local_model = pipeline("text-generation", model="chinese-patent-model")
        
        self.patent_prompt = PromptTemplate(
            template="""
            基于以下信息生成一份完整的发明专利申请文本：
            
            技术领域：{technical_field}
            创新点：{innovation_points}
            技术方案：{technical_solution}
            
            请按照以下格式生成：
            1. 发明名称
            2. 技术领域
            3. 背景技术
            4. 发明内容
            5. 具体实施方式
            6. 权利要求书
            """,
            input_variables=["technical_field", "innovation_points", "technical_solution"]
        )
    
    async def generate(self, request: PatentRequest) -> PatentResponse:
        # 1. 参数验证
        if not self.validate_request(request):
            raise ValueError("Invalid request parameters")
        
        # 2. 生成提示词
        prompt = self.patent_prompt.format(
            technical_field=request.technical_field,
            innovation_points=request.innovation_points,
            technical_solution=request.technical_solution
        )
        
        # 3. 调用大模型
        response = await self.call_llm(prompt)
        
        # 4. 后处理
        processed_response = self.post_process(response)
        
        return PatentResponse(content=processed_response)
```

### 反查重算法实现
```python
# patent_ai/anti_plagiarism.py
import torch
from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity
import spacy

class AntiPlagiarismEngine:
    def __init__(self):
        self.sentence_model = SentenceTransformer('paraphrase-multilingual-MiniLM-L12-v2')
        self.nlp = spacy.load("zh_core_web_sm")
        
    async def check_similarity(self, text: str, reference_texts: List[str]) -> SimilarityResult:
        """计算文本相似度"""
        # 1. 文本分块
        chunks = self.chunk_text(text)
        
        # 2. 生成向量
        text_vectors = self.sentence_model.encode(chunks)
        ref_vectors = self.sentence_model.encode(reference_texts)
        
        # 3. 计算相似度
        similarity_matrix = cosine_similarity(text_vectors, ref_vectors)
        
        # 4. 找出高相似度段落
        high_similarity_parts = self.find_high_similarity_parts(similarity_matrix)
        
        return SimilarityResult(
            overall_similarity=np.mean(similarity_matrix),
            high_similarity_parts=high_similarity_parts
        )
    
    async def rewrite_text(self, text: str, target_similarity: float = 0.15) -> str:
        """智能改写文本"""
        # 1. 同义词替换
        text = self.synonym_replacement(text)
        
        # 2. 句式变换
        text = self.sentence_restructuring(text)
        
        # 3. 段落重组
        text = self.paragraph_reordering(text)
        
        return text
```

---

## 🔐 安全架构

### JWT认证流程
```
用户登录 -> Spring Security验证 -> 生成JWT Token -> 
客户端存储 -> 每次请求携带Token -> 网关验证 -> 服务调用
```

### 权限控制
```java
@Component
public class CustomPermissionEvaluator implements PermissionEvaluator {
    
    @Override
    public boolean hasPermission(Authentication auth, Object targetDomainObject, Object permission) {
        User user = (User) auth.getPrincipal();
        String permissionStr = (String) permission;
        
        return user.getAuthorities().stream()
            .anyMatch(grantedAuthority -> 
                grantedAuthority.getAuthority().equals(permissionStr));
    }
}
```

---

## 🚀 部署架构

### Docker容器化
```dockerfile
# Dockerfile for backend
FROM openjdk:11-jre-slim

COPY target/patent-backend.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app.jar", "--spring.profiles.active=prod"]
```

### Docker Compose配置
```yaml
version: '3.8'
services:
  # 后端服务
  patent-backend:
    build: ./backend
    ports:
      - "8080:8080"
    environment:
      - SPRING_PROFILES_ACTIVE=docker
    depends_on:
      - mysql
      - redis
      - rabbitmq
  
  # 前端服务
  patent-frontend:
    build: ./frontend
    ports:
      - "80:80"
    depends_on:
      - patent-backend
  
  # AI服务
  patent-ai:
    build: ./ai-engine
    ports:
      - "5000:5000"
    environment:
      - OPENAI_API_KEY=${OPENAI_API_KEY}
  
  # 数据库
  mysql:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: patent123
      MYSQL_DATABASE: patent_system
    volumes:
      - mysql_data:/var/lib/mysql
  
  redis:
    image: redis:6.0-alpine
    volumes:
      - redis_data:/data
  
  rabbitmq:
    image: rabbitmq:3.8-management
    ports:
      - "5672:5672"
      - "15672:15672"

volumes:
  mysql_data:
  redis_data:
```

---

## 📊 监控与日志

### 应用监控
- **Spring Boot Actuator**: 健康检查、指标收集
- **Prometheus + Grafana**: 系统监控仪表板
- **ELK Stack**: 日志收集与分析

### 性能指标
- **响应时间**: API响应时间 < 500ms
- **并发量**: 支持1000并发用户
- **可用性**: 99.9%服务可用性
- **错误率**: < 0.1%

---

## 🔧 开发工具链

### 代码质量
- **SonarQube**: 代码质量检查
- **ESLint**: 前端代码规范
- **Checkstyle**: 后端代码规范

### 版本控制
- **Git**: 代码版本管理
- **Git Flow**: 分支管理策略
- **Conventional Commits**: 提交规范

### CI/CD流程
- **GitHub Actions**: 自动化构建部署
- **Docker**: 容器化部署
- **Kubernetes**: 容器编排 (可选)