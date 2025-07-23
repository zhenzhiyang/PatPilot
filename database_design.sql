-- ====================================================
-- PatPilot AI专利生成系统 - 数据库设计
-- 基于 README.md 核心功能模块设计
-- ====================================================

-- 创建数据库
CREATE DATABASE IF NOT EXISTS patpilot CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE patpilot;

-- ====================================================
-- 1. 用户管理模块
-- ====================================================

-- 用户表
CREATE TABLE users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '用户ID',
    username VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
    email VARCHAR(100) NOT NULL UNIQUE COMMENT '邮箱',
    password VARCHAR(255) NOT NULL COMMENT '密码（加密后）',
    full_name VARCHAR(100) COMMENT '真实姓名',
    phone VARCHAR(20) COMMENT '手机号',
    avatar_url VARCHAR(500) COMMENT '头像URL',
    role ENUM('USER', 'PREMIUM', 'ADMIN') DEFAULT 'USER' COMMENT '用户角色',
    status ENUM('ACTIVE', 'INACTIVE', 'BANNED') DEFAULT 'ACTIVE' COMMENT '用户状态',
    email_verified BOOLEAN DEFAULT FALSE COMMENT '邮箱是否验证',
    subscription_plan ENUM('FREE', 'BASIC', 'PRO', 'ENTERPRISE') DEFAULT 'FREE' COMMENT '订阅方案',
    subscription_expires_at DATETIME COMMENT '订阅到期时间',
    api_quota_monthly INT DEFAULT 10 COMMENT '月API调用配额',
    api_quota_used INT DEFAULT 0 COMMENT '已使用API配额',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    last_login_at TIMESTAMP COMMENT '最后登录时间',
    last_login_ip VARCHAR(45) COMMENT '最后登录IP',
    
    INDEX idx_username (username),
    INDEX idx_email (email),
    INDEX idx_role (role),
    INDEX idx_status (status),
    INDEX idx_subscription_plan (subscription_plan),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB COMMENT='用户表';

-- 用户会话表
CREATE TABLE user_sessions (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '会话ID',
    user_id BIGINT NOT NULL COMMENT '用户ID',
    token VARCHAR(512) NOT NULL UNIQUE COMMENT 'JWT Token',
    refresh_token VARCHAR(512) COMMENT '刷新Token',
    device_info TEXT COMMENT '设备信息',
    user_agent TEXT COMMENT '用户代理',
    ip_address VARCHAR(45) COMMENT 'IP地址',
    expires_at TIMESTAMP NOT NULL COMMENT '过期时间',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_token (token),
    INDEX idx_expires_at (expires_at)
) ENGINE=InnoDB COMMENT='用户会话表';

-- ====================================================
-- 2. 专利模板管理模块
-- ====================================================

-- 专利模板分类表
CREATE TABLE template_categories (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '分类ID',
    name VARCHAR(100) NOT NULL COMMENT '分类名称',
    description TEXT COMMENT '分类描述',
    patent_type ENUM('INVENTION', 'UTILITY', 'DESIGN') NOT NULL COMMENT '专利类型',
    parent_id BIGINT COMMENT '父分类ID',
    sort_order INT DEFAULT 0 COMMENT '排序顺序',
    is_active BOOLEAN DEFAULT TRUE COMMENT '是否启用',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    
    FOREIGN KEY (parent_id) REFERENCES template_categories(id) ON DELETE SET NULL,
    INDEX idx_patent_type (patent_type),
    INDEX idx_parent_id (parent_id),
    INDEX idx_sort_order (sort_order)
) ENGINE=InnoDB COMMENT='专利模板分类表';

-- 专利模板表
CREATE TABLE patent_templates (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '模板ID',
    name VARCHAR(200) NOT NULL COMMENT '模板名称',
    description TEXT COMMENT '模板描述',
    category_id BIGINT NOT NULL COMMENT '分类ID',
    patent_type ENUM('INVENTION', 'UTILITY', 'DESIGN') NOT NULL COMMENT '专利类型',
    template_content LONGTEXT NOT NULL COMMENT '模板内容（JSON格式）',
    field_definitions LONGTEXT COMMENT '字段定义（JSON格式）',
    version VARCHAR(20) DEFAULT '1.0' COMMENT '版本号',
    is_system BOOLEAN DEFAULT FALSE COMMENT '是否系统模板',
    is_public BOOLEAN DEFAULT TRUE COMMENT '是否公开',
    creator_id BIGINT COMMENT '创建者ID',
    usage_count INT DEFAULT 0 COMMENT '使用次数',
    rating DECIMAL(3,2) DEFAULT 0.00 COMMENT '评分',
    status ENUM('ACTIVE', 'DRAFT', 'ARCHIVED') DEFAULT 'ACTIVE' COMMENT '状态',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    
    FOREIGN KEY (category_id) REFERENCES template_categories(id) ON DELETE RESTRICT,
    FOREIGN KEY (creator_id) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_category_id (category_id),
    INDEX idx_patent_type (patent_type),
    INDEX idx_creator_id (creator_id),
    INDEX idx_is_public (is_public),
    INDEX idx_status (status),
    INDEX idx_usage_count (usage_count),
    INDEX idx_rating (rating)
) ENGINE=InnoDB COMMENT='专利模板表';

-- 模板版本历史表
CREATE TABLE template_versions (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '版本ID',
    template_id BIGINT NOT NULL COMMENT '模板ID',
    version VARCHAR(20) NOT NULL COMMENT '版本号',
    template_content LONGTEXT NOT NULL COMMENT '模板内容',
    field_definitions LONGTEXT COMMENT '字段定义',
    change_log TEXT COMMENT '变更日志',
    creator_id BIGINT COMMENT '创建者ID',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    
    FOREIGN KEY (template_id) REFERENCES patent_templates(id) ON DELETE CASCADE,
    FOREIGN KEY (creator_id) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_template_id (template_id),
    INDEX idx_version (version),
    UNIQUE KEY uk_template_version (template_id, version)
) ENGINE=InnoDB COMMENT='模板版本历史表';

-- ====================================================
-- 3. 专利文档管理模块
-- ====================================================

-- 专利文档表
CREATE TABLE patent_documents (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '文档ID',
    title VARCHAR(500) NOT NULL COMMENT '专利标题',
    abstract TEXT COMMENT '摘要',
    applicant VARCHAR(200) COMMENT '申请人',
    inventor VARCHAR(500) COMMENT '发明人',
    patent_type ENUM('INVENTION', 'UTILITY', 'DESIGN') NOT NULL COMMENT '专利类型',
    template_id BIGINT COMMENT '使用的模板ID',
    content LONGTEXT COMMENT '专利内容（富文本）',
    content_json LONGTEXT COMMENT '结构化内容（JSON格式）',
    technical_field TEXT COMMENT '技术领域',
    background_art TEXT COMMENT '背景技术',
    invention_content TEXT COMMENT '发明内容',
    brief_description TEXT COMMENT '附图说明',
    detailed_description LONGTEXT COMMENT '具体实施方式',
    claims LONGTEXT COMMENT '权利要求书',
    drawings_info TEXT COMMENT '附图信息',
    keywords VARCHAR(500) COMMENT '关键词',
    owner_id BIGINT NOT NULL COMMENT '所有者ID',
    status ENUM('DRAFT', 'IN_REVIEW', 'APPROVED', 'REJECTED', 'PUBLISHED', 'APPLIED') DEFAULT 'DRAFT' COMMENT '文档状态',
    privacy_level ENUM('PRIVATE', 'TEAM', 'PUBLIC') DEFAULT 'PRIVATE' COMMENT '隐私级别',
    legal_status VARCHAR(100) COMMENT '法律状态',
    application_number VARCHAR(100) COMMENT '申请号',
    application_date DATE COMMENT '申请日期',
    publication_number VARCHAR(100) COMMENT '公开号',
    publication_date DATE COMMENT '公开日期',
    grant_number VARCHAR(100) COMMENT '授权号',
    grant_date DATE COMMENT '授权日期',
    priority_info TEXT COMMENT '优先权信息',
    ipc_classification VARCHAR(200) COMMENT 'IPC分类号',
    cpc_classification VARCHAR(200) COMMENT 'CPC分类号',
    word_count INT DEFAULT 0 COMMENT '字数统计',
    originality_score DECIMAL(5,2) COMMENT '原创度评分',
    ai_generated BOOLEAN DEFAULT FALSE COMMENT '是否AI生成',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    
    FOREIGN KEY (template_id) REFERENCES patent_templates(id) ON DELETE SET NULL,
    FOREIGN KEY (owner_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_title (title),
    INDEX idx_patent_type (patent_type),
    INDEX idx_owner_id (owner_id),
    INDEX idx_status (status),
    INDEX idx_privacy_level (privacy_level),
    INDEX idx_application_number (application_number),
    INDEX idx_publication_number (publication_number),
    INDEX idx_grant_number (grant_number),
    INDEX idx_created_at (created_at),
    FULLTEXT KEY ft_content (title, abstract, content, keywords)
) ENGINE=InnoDB COMMENT='专利文档表';

-- 文档版本历史表
CREATE TABLE document_versions (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '版本ID',
    document_id BIGINT NOT NULL COMMENT '文档ID',
    version_number INT NOT NULL COMMENT '版本号',
    title VARCHAR(500) COMMENT '标题',
    content LONGTEXT COMMENT '文档内容',
    content_json LONGTEXT COMMENT '结构化内容',
    change_summary TEXT COMMENT '变更摘要',
    change_details LONGTEXT COMMENT '变更详情',
    editor_id BIGINT COMMENT '编辑者ID',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    
    FOREIGN KEY (document_id) REFERENCES patent_documents(id) ON DELETE CASCADE,
    FOREIGN KEY (editor_id) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_document_id (document_id),
    INDEX idx_version_number (version_number),
    UNIQUE KEY uk_document_version (document_id, version_number)
) ENGINE=InnoDB COMMENT='文档版本历史表';

-- 文档协作表
CREATE TABLE document_collaborators (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '协作ID',
    document_id BIGINT NOT NULL COMMENT '文档ID',
    user_id BIGINT NOT NULL COMMENT '用户ID',
    role ENUM('OWNER', 'EDITOR', 'VIEWER', 'COMMENTER') DEFAULT 'VIEWER' COMMENT '协作角色',
    permissions JSON COMMENT '详细权限设置',
    invited_by BIGINT COMMENT '邀请人ID',
    invited_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '邀请时间',
    accepted_at TIMESTAMP COMMENT '接受时间',
    status ENUM('PENDING', 'ACCEPTED', 'DECLINED', 'REVOKED') DEFAULT 'PENDING' COMMENT '状态',
    
    FOREIGN KEY (document_id) REFERENCES patent_documents(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (invited_by) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_document_id (document_id),
    INDEX idx_user_id (user_id),
    UNIQUE KEY uk_document_user (document_id, user_id)
) ENGINE=InnoDB COMMENT='文档协作表';

-- ====================================================
-- 4. AI生成和反查重模块
-- ====================================================

-- AI生成任务表
CREATE TABLE ai_generation_tasks (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '任务ID',
    user_id BIGINT NOT NULL COMMENT '用户ID',
    document_id BIGINT COMMENT '关联文档ID',
    task_type ENUM('FULL_GENERATION', 'SECTION_GENERATION', 'REWRITE', 'IMPROVEMENT') NOT NULL COMMENT '任务类型',
    input_data LONGTEXT NOT NULL COMMENT '输入数据（JSON格式）',
    prompt_template TEXT COMMENT '提示词模板',
    model_name VARCHAR(100) COMMENT '使用的模型',
    model_version VARCHAR(50) COMMENT '模型版本',
    parameters JSON COMMENT '生成参数',
    status ENUM('PENDING', 'PROCESSING', 'COMPLETED', 'FAILED', 'CANCELLED') DEFAULT 'PENDING' COMMENT '任务状态',
    progress INT DEFAULT 0 COMMENT '进度百分比',
    result_content LONGTEXT COMMENT '生成结果',
    result_metadata JSON COMMENT '结果元数据',
    error_message TEXT COMMENT '错误信息',
    token_count INT COMMENT 'Token消耗量',
    processing_time INT COMMENT '处理时间（秒）',
    queue_position INT COMMENT '队列位置',
    priority INT DEFAULT 5 COMMENT '优先级（1-10）',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    started_at TIMESTAMP COMMENT '开始时间',
    completed_at TIMESTAMP COMMENT '完成时间',
    
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (document_id) REFERENCES patent_documents(id) ON DELETE SET NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_document_id (document_id),
    INDEX idx_status (status),
    INDEX idx_task_type (task_type),
    INDEX idx_created_at (created_at),
    INDEX idx_priority (priority)
) ENGINE=InnoDB COMMENT='AI生成任务表';

-- 反查重检测表
CREATE TABLE plagiarism_checks (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '检测ID',
    user_id BIGINT NOT NULL COMMENT '用户ID',
    document_id BIGINT COMMENT '文档ID',
    generation_task_id BIGINT COMMENT '生成任务ID',
    check_type ENUM('FULL_DOCUMENT', 'SECTION', 'INCREMENTAL') NOT NULL COMMENT '检测类型',
    content_to_check LONGTEXT NOT NULL COMMENT '待检测内容',
    content_hash VARCHAR(64) COMMENT '内容哈希',
    detection_engines JSON COMMENT '使用的检测引擎',
    overall_similarity DECIMAL(5,2) COMMENT '总体相似度',
    similarity_threshold DECIMAL(5,2) DEFAULT 15.00 COMMENT '相似度阈值',
    is_passed BOOLEAN COMMENT '是否通过检测',
    detailed_results LONGTEXT COMMENT '详细检测结果（JSON格式）',
    similar_sources JSON COMMENT '相似来源信息',
    rewrite_suggestions LONGTEXT COMMENT '改写建议',
    status ENUM('PENDING', 'PROCESSING', 'COMPLETED', 'FAILED') DEFAULT 'PENDING' COMMENT '检测状态',
    processing_time INT COMMENT '处理时间（毫秒）',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    completed_at TIMESTAMP COMMENT '完成时间',
    
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (document_id) REFERENCES patent_documents(id) ON DELETE SET NULL,
    FOREIGN KEY (generation_task_id) REFERENCES ai_generation_tasks(id) ON DELETE SET NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_document_id (document_id),
    INDEX idx_generation_task_id (generation_task_id),
    INDEX idx_content_hash (content_hash),
    INDEX idx_overall_similarity (overall_similarity),
    INDEX idx_status (status),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB COMMENT='反查重检测表';

-- 文本改写记录表
CREATE TABLE text_rewrites (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '改写ID',
    plagiarism_check_id BIGINT NOT NULL COMMENT '查重检测ID',
    original_text LONGTEXT NOT NULL COMMENT '原始文本',
    rewritten_text LONGTEXT NOT NULL COMMENT '改写文本',
    rewrite_strategy ENUM('LEXICAL', 'SYNTACTIC', 'SEMANTIC', 'STRUCTURAL') NOT NULL COMMENT '改写策略',
    similarity_before DECIMAL(5,2) COMMENT '改写前相似度',
    similarity_after DECIMAL(5,2) COMMENT '改写后相似度',
    semantic_similarity DECIMAL(5,2) COMMENT '语义相似度',
    quality_score DECIMAL(5,2) COMMENT '改写质量评分',
    is_accepted BOOLEAN COMMENT '是否被接受',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    
    FOREIGN KEY (plagiarism_check_id) REFERENCES plagiarism_checks(id) ON DELETE CASCADE,
    INDEX idx_plagiarism_check_id (plagiarism_check_id),
    INDEX idx_rewrite_strategy (rewrite_strategy),
    INDEX idx_similarity_after (similarity_after)
) ENGINE=InnoDB COMMENT='文本改写记录表';

-- ====================================================
-- 5. 智能检索系统
-- ====================================================

-- 搜索历史表
CREATE TABLE search_history (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '搜索ID',
    user_id BIGINT COMMENT '用户ID',
    search_query VARCHAR(1000) NOT NULL COMMENT '搜索查询',
    search_type ENUM('FULLTEXT', 'SEMANTIC', 'MIXED') DEFAULT 'FULLTEXT' COMMENT '搜索类型',
    search_filters JSON COMMENT '搜索过滤条件',
    results_count INT DEFAULT 0 COMMENT '结果数量',
    search_time INT COMMENT '搜索耗时（毫秒）',
    ip_address VARCHAR(45) COMMENT 'IP地址',
    user_agent TEXT COMMENT '用户代理',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '搜索时间',
    
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_search_type (search_type),
    INDEX idx_created_at (created_at),
    FULLTEXT KEY ft_search_query (search_query)
) ENGINE=InnoDB COMMENT='搜索历史表';

-- 专利引用关系表
CREATE TABLE patent_citations (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '引用ID',
    citing_document_id BIGINT NOT NULL COMMENT '引用文档ID',
    cited_document_id BIGINT COMMENT '被引用文档ID',
    cited_patent_number VARCHAR(100) COMMENT '被引用专利号',
    cited_title VARCHAR(500) COMMENT '被引用标题',
    citation_type ENUM('FORWARD', 'BACKWARD', 'SELF') NOT NULL COMMENT '引用类型',
    citation_context TEXT COMMENT '引用上下文',
    relevance_score DECIMAL(5,2) COMMENT '相关性评分',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    
    FOREIGN KEY (citing_document_id) REFERENCES patent_documents(id) ON DELETE CASCADE,
    FOREIGN KEY (cited_document_id) REFERENCES patent_documents(id) ON DELETE SET NULL,
    INDEX idx_citing_document_id (citing_document_id),
    INDEX idx_cited_document_id (cited_document_id),
    INDEX idx_cited_patent_number (cited_patent_number),
    INDEX idx_citation_type (citation_type)
) ENGINE=InnoDB COMMENT='专利引用关系表';

-- ====================================================
-- 6. 系统配置和日志
-- ====================================================

-- 系统配置表
CREATE TABLE system_configs (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '配置ID',
    config_key VARCHAR(100) NOT NULL UNIQUE COMMENT '配置键',
    config_value LONGTEXT COMMENT '配置值',
    config_type ENUM('STRING', 'NUMBER', 'BOOLEAN', 'JSON') DEFAULT 'STRING' COMMENT '配置类型',
    category VARCHAR(50) DEFAULT 'GENERAL' COMMENT '配置分类',
    description TEXT COMMENT '配置描述',
    is_encrypted BOOLEAN DEFAULT FALSE COMMENT '是否加密存储',
    is_readonly BOOLEAN DEFAULT FALSE COMMENT '是否只读',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    
    INDEX idx_config_key (config_key),
    INDEX idx_category (category)
) ENGINE=InnoDB COMMENT='系统配置表';

-- 审计日志表
CREATE TABLE audit_logs (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '日志ID',
    user_id BIGINT COMMENT '用户ID',
    action VARCHAR(100) NOT NULL COMMENT '操作动作',
    resource_type VARCHAR(50) COMMENT '资源类型',
    resource_id BIGINT COMMENT '资源ID',
    old_values JSON COMMENT '旧值',
    new_values JSON COMMENT '新值',
    ip_address VARCHAR(45) COMMENT 'IP地址',
    user_agent TEXT COMMENT '用户代理',
    session_id VARCHAR(100) COMMENT '会话ID',
    request_id VARCHAR(100) COMMENT '请求ID',
    execution_time INT COMMENT '执行时间（毫秒）',
    status ENUM('SUCCESS', 'FAILURE', 'ERROR') DEFAULT 'SUCCESS' COMMENT '执行状态',
    error_message TEXT COMMENT '错误信息',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_action (action),
    INDEX idx_resource_type (resource_type),
    INDEX idx_resource_id (resource_id),
    INDEX idx_status (status),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB COMMENT='审计日志表';

-- 文件存储表
CREATE TABLE file_storage (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '文件ID',
    user_id BIGINT COMMENT '上传用户ID',
    document_id BIGINT COMMENT '关联文档ID',
    file_name VARCHAR(255) NOT NULL COMMENT '文件名',
    original_name VARCHAR(255) COMMENT '原始文件名',
    file_path VARCHAR(500) NOT NULL COMMENT '文件路径',
    file_size BIGINT NOT NULL COMMENT '文件大小（字节）',
    file_type VARCHAR(100) COMMENT '文件类型',
    mime_type VARCHAR(100) COMMENT 'MIME类型',
    file_hash VARCHAR(64) COMMENT '文件哈希',
    storage_type ENUM('LOCAL', 'MINIO', 'OSS', 'S3') DEFAULT 'LOCAL' COMMENT '存储类型',
    bucket_name VARCHAR(100) COMMENT '存储桶名称',
    is_public BOOLEAN DEFAULT FALSE COMMENT '是否公开访问',
    access_url VARCHAR(500) COMMENT '访问URL',
    thumbnail_url VARCHAR(500) COMMENT '缩略图URL',
    metadata JSON COMMENT '文件元数据',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (document_id) REFERENCES patent_documents(id) ON DELETE SET NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_document_id (document_id),
    INDEX idx_file_hash (file_hash),
    INDEX idx_file_type (file_type),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB COMMENT='文件存储表';

-- ====================================================
-- 初始化数据
-- ====================================================

-- 插入系统配置
INSERT INTO system_configs (config_key, config_value, config_type, category, description) VALUES
('ai.openai.api_key', '', 'STRING', 'AI', 'OpenAI API密钥'),
('ai.openai.model', 'gpt-3.5-turbo', 'STRING', 'AI', '默认OpenAI模型'),
('ai.max_tokens', '4000', 'NUMBER', 'AI', '最大Token数量'),
('ai.temperature', '0.7', 'NUMBER', 'AI', '生成温度参数'),
('plagiarism.similarity_threshold', '15.0', 'NUMBER', 'PLAGIARISM', '相似度阈值'),
('plagiarism.check_engines', '["turnitin", "cnki"]', 'JSON', 'PLAGIARISM', '查重引擎列表'),
('file.max_upload_size', '104857600', 'NUMBER', 'FILE', '最大上传文件大小（字节）'),
('file.allowed_types', '["pdf", "doc", "docx", "txt"]', 'JSON', 'FILE', '允许的文件类型'),
('system.maintenance_mode', 'false', 'BOOLEAN', 'SYSTEM', '维护模式'),
('user.default_quota', '10', 'NUMBER', 'USER', '默认用户配额');

-- 插入默认模板分类
INSERT INTO template_categories (name, description, patent_type, sort_order) VALUES
('发明专利模板', '发明专利相关模板', 'INVENTION', 1),
('实用新型模板', '实用新型专利相关模板', 'UTILITY', 2),  
('外观设计模板', '外观设计专利相关模板', 'DESIGN', 3);

-- 创建索引优化查询性能
CREATE INDEX idx_documents_complex ON patent_documents(owner_id, status, patent_type, created_at);
CREATE INDEX idx_tasks_complex ON ai_generation_tasks(user_id, status, created_at);
CREATE INDEX idx_checks_complex ON plagiarism_checks(user_id, status, overall_similarity);

-- 添加数据库性能优化建议注释
/* 
性能优化建议:
1. 定期清理过期的用户会话数据
2. 对audit_logs表按时间分区
3. 为LONGTEXT字段考虑使用压缩存储
4. 定期分析和优化慢查询
5. 考虑为高频查询字段添加复合索引
6. 对文件存储表的大文件考虑使用外部存储
7. 定期备份重要数据
*/