# AI专利生成系统 (PatPilot) - Claude Code配置

这是一个基于AI技术的智能专利生成与管理系统的Claude Code配置文档。

## 项目概述

AI专利生成系统是一个完整的AI专利生成平台，能够根据用户输入自动生成符合专利规范的申请文本，并采用先进的反查重技术确保内容原创性。

## 技术栈

### 后端
- Spring Boot 2.7+
- MySQL 8.0+
- MyBatis Plus
- JWT + Spring Security
- OpenAI GPT / 大模型API

### 前端
- Vue 3 + Vite
- Element Plus
- Pinia
- Quill.js

### AI引擎
- Python 3.8+
- PyTorch 1.9+
- Transformers 4.20+
- 反查重技术

## 项目结构

```
patent-ai-system/
├── backend/          # Spring Boot后端服务
├── frontend/         # Vue 3前端应用
├── ai-engine/        # AI引擎服务
└── docker-compose.yml
```

## 开发命令

### 后端开发
```bash
cd backend
mvn clean install
mvn spring-boot:run
```

### 前端开发
```bash
cd frontend
npm install
npm run dev
npm run build
npm run lint
```

### AI引擎
```bash
cd ai-engine
pip install -r requirements.txt
python app.py
```

### 容器化部署
```bash
docker-compose up -d
```

## 核心功能模块

1. **用户管理** - JWT认证与权限管理
2. **专利模板管理** - 模板分类与版本控制
3. **AI专利生成引擎** - 智能文本生成
4. **反查重处理系统** - 多层次改写策略
5. **专利文档管理** - 版本管理与协作编辑
6. **智能检索系统** - 全文检索与语义搜索

## API端点

- 后端服务: http://localhost:8080
- API文档: http://localhost:8080/swagger-ui.html
- 前端应用: http://localhost:3000

## 环境要求

- JDK 11+
- Node.js 16+
- Python 3.8+
- MySQL 8.0+
- Redis 6.0+

## 开发提示

- 项目采用15周敏捷开发模式
- 详细任务清单见 doc/todo.md
- 技术实现方案见 doc/technology.md
- 遵循MIT许可证

## 快速启动

1. 克隆项目: `git clone https://github.com/zhenzhiyang/PatPilot.git`
2. 配置环境变量（已设置.env文件）
3. 启动数据库服务
4. 按顺序启动后端、前端、AI引擎服务
5. 访问 http://localhost:3000 开始使用