# AI专利生成系统 (PatPilot)

一个基于AI技术的智能专利生成与管理系统，通过大语言模型生成专利文本，并结合多种技术避免AI查重检测。

## 项目简介

本项目由两人团队协作开发，旨在构建一个完整的AI专利生成平台，能够根据用户输入的技术领域、创新点等信息，自动生成符合专利规范的申请文本，同时采用先进的反查重技术确保生成内容的原创性。

## 技术架构

### 后端技术栈
- **框架**: Spring Boot 2.7+
- **数据库**: MySQL 8.0+
- **ORM**: MyBatis Plus
- **认证**: JWT + Spring Security
- **API文档**: Swagger 3
- **AI集成**: OpenAI GPT / 其他大模型API
- **缓存**: Redis (用于缓存AI响应和会话管理)
- **消息队列**: RabbitMQ (异步处理AI生成任务)
- **文件存储**: MinIO (专利文档存储)
- **搜索引擎**: Elasticsearch (专利检索)

### 前端技术栈
- **框架**: Vue 3 + Vite
- **UI组件**: Element Plus
- **状态管理**: Pinia
- **路由管理**: Vue Router
- **HTTP客户端**: Axios
- **图表库**: ECharts
- **富文本编辑器**: Quill.js (专利文本编辑)
- **PDF预览**: PDF.js (专利文档预览)

### 反AI查重技术栈
- **文本重写引擎**: 基于BERT的文本改写模型
- **语义保持算法**: 使用Sentence-BERT确保改写后语义一致性
- **多样性生成**: 温度采样(temperature sampling) + Top-p采样
- **同义词替换**: 使用WordNet + 领域专业词库
- **句式重构**: 基于依存句法分析的句式变换
- **段落重排**: 保持逻辑关系的内容重组
- **查重检测集成**: 集成Turnitin、知网查重API
- **原创度评分**: 基于余弦相似度的原创度评估

## 核心功能模块

### 1. 用户管理模块
- 用户注册/登录/权限管理
- JWT令牌认证
- 用户角色分级（普通用户/高级用户/管理员）

### 2. 专利模板管理
- 模板分类管理（发明专利/实用新型/外观设计）
- 模板自定义创建与编辑
- 模板版本控制

### 3. AI专利生成引擎
- 智能技术领域识别
- 创新点提取与扩展
- 专利文本自动生成
- 图表自动生成与插入

### 4. 反查重处理系统
- **实时查重检测**: 生成过程中实时检测相似度
- **智能改写引擎**: 自动重写相似内容
- **原创度评估**: 多维度原创度评分
- **查重报告生成**: 详细查重分析报告

### 5. 专利文档管理
- 文档版本管理
- 协作编辑功能
- 导出格式支持（PDF/Word/XML）
- 法律状态跟踪

### 6. 智能检索系统
- 全文检索
- 语义相似度搜索
- 专利引用分析
- 技术趋势分析

## 反AI查重技术详解

### 1. 多层次改写策略
```
第一层：词汇级改写
- 专业术语同义词替换
- 连接词变换
- 数量词表达方式变更

第二层：句式级改写
- 主动被动语态转换
- 定语从句与分词短语转换
- 并列句与复合句重构

第三层：段落级改写
- 技术特征重排序
- 实施例重组
- 论证逻辑重构
```

### 2. 语义保持机制
- **BERTScore**: 使用预训练模型评估语义相似度
- **领域适应**: 基于专利语料fine-tune的BERT模型
- **约束生成**: 确保技术特征不被误改

### 3. 原创度提升算法
- **温度参数动态调整**: 0.7-0.9之间动态调整
- **Top-p采样**: p值在0.9-0.95范围内变化
- **n-gram重复惩罚**: 避免n-gram重复出现

### 4. 实时检测机制
- **增量查重**: 每生成一段检测一次
- **阈值控制**: 相似度阈值设定为15%
- **回退机制**: 超标内容自动重新生成

## 项目结构

```
patent-ai-system/
├── backend/                    # 后端服务
│   ├── src/main/java/com/patent/
│   │   ├── config/            # 配置类
│   │   ├── controller/        # 控制器
│   │   ├── service/           # 业务逻辑层
│   │   ├── mapper/            # 数据访问层
│   │   ├── model/             # 数据模型
│   │   ├── security/          # 安全配置
│   │   └── utils/             # 工具类
│   └── resources/
│       ├── application.yml    # 配置文件
│       └── mapper/            # MyBatis映射文件
├── frontend/                   # 前端应用
│   ├── src/
│   │   ├── api/               # API接口
│   │   ├── assets/            # 静态资源
│   │   ├── components/        # 公共组件
│   │   ├── views/             # 页面视图
│   │   ├── store/             # 状态管理
│   │   ├── router/            # 路由配置
│   │   └── utils/             # 工具函数
│   └── package.json
├── ai-engine/                  # AI引擎服务
│   ├── models/                # 预训练模型
│   ├── processors/            # 文本处理器
│   └── anti-plagiarism/       # 反查重模块
├── docker-compose.yml         # 容器编排
└── README.md                  # 项目说明
```

## 开发环境要求

### 后端环境
- JDK 11 或更高版本
- MySQL 8.0+
- Redis 6.0+
- RabbitMQ 3.8+
- Maven 3.6+

### 前端环境
- Node.js 16+
- npm 7+ 或 yarn 1.22+

### AI环境
- Python 3.8+
- PyTorch 1.9+
- Transformers 4.20+
- CUDA 11.0+ (可选，用于GPU加速)

## 快速开始

### 1. 克隆项目
```bash
git clone https://github.com/zhenzhiyang/PatPilot.git
cd PatPilot
```

### 2. 启动后端服务
```bash
# 进入后端目录
cd backend

# 安装依赖
mvn clean install

# 启动服务
mvn spring-boot:run
```

### 3. 启动前端服务
```bash
# 进入前端目录
cd frontend

# 安装依赖
npm install

# 启动开发服务器
npm run dev
```

### 4. 启动AI引擎
```bash
# 进入AI引擎目录
cd ai-engine

# 创建虚拟环境
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# 安装依赖
pip install -r requirements.txt

# 启动AI服务
python app.py
```

### 5. Docker一键启动
```bash
docker-compose up -d
```

## 开发进度

详细的开发任务清单和技术实现方案请参考 [todo.md](doc/todo.md) 和 [technology.md](doc/technology.md) 文档。

项目采用15周敏捷开发模式，分为8个主要阶段，每个阶段都有详细的任务分解和技术实现要点。

## API文档

启动项目后，可以通过以下地址访问API文档：
- Swagger UI: http://localhost:8080/swagger-ui.html
- API文档: http://localhost:8080/v3/api-docs

## 贡献指南

1. Fork 项目
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开 Pull Request

## 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件。

## 联系方式

- 项目负责人：郑志阳
- 邮箱：zhenzhiyang@example.com
- 项目地址：https://github.com/zhenzhiyang/PatPilot

## 致谢

- 感谢OpenAI提供的GPT模型API
- 感谢Element Plus提供的优秀UI组件库
- 感谢所有开源社区的贡献者