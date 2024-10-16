# chat2api-plus
**chat2api-plus** 用于将 Web 端的 ChatGPT 对话接口转换为标准的 OpenAI API 格式。本程序支持官网所有模型(会持续更新)，包括 GPT-3.5、GPT-4、GPT-4-all、GPTS， GPT-4o, GPT-4o-mini 和 dalle画图模型。本项目配备了易于使用的管理仪表板，包括渠道管理、可视化数据显示以及批量添加或修改账户的功能。

**重要提示**：~~运行此项目需要授权。目前可联系项目组进行试用，提供免费试用网关。~~

**注意**：~~本站出售api逆向自研网关，基础价格600￥/QPS，2QPS以上500￥，5QPS以上400￥，稳定高速。网关支持私有化部署，具体价格私聊；~~

~~可以提供免费测试网关，支持拼车，可以自行反代，按量控制~~

~~为保证服务负载和性能，杜绝超卖，到达QPS上限，停止售卖~~

配套网关部署方案：https://github.com/wm-chatgpt/chatgpt-gateway

## 特性
- **功能丰富**：支持传图、传文件、dall-e画图、下载文件、oss存储图片、gpts隐私自动确认等
- **无门槛**：无需手动登录获取 access token，直接填入账号密码即可使用。
- **批量导入导出**：支持轻松导入导出各种格式的账号列表并且批量添加标签，易于管理。
- **均衡负载**：通过权重和优先级的双重控制，灵活分配账号使用次数。
- **人性化设计**：支持筛选和搜索账号，可查看每个账号在每个模型上的调用次数和官网订阅到期时间。
- **高度可靠**：内置自动重试机制和账号冷却功能，最小化错误率。
- **自动化操作**：定时自动更新账号状态，每日自动清理过期/异常账号。
- **数据可视化**：清晰展示所有 API 调用数据及账号池的实时状态。
- **自动继续对话**：一次性输出超长的响应回复，突破逆向的限制
- **画图自动冷却**：超出dall-e每日上限后自动冷却
- **自动删除聊天记录**：破解号逆向爱好者福音


## 支持的模型列表(持续更新)

本项目当前支持以下AI模型：

- `gpt-3.5-turbo`: 普号调用的官网3.5。
- `gpt-3.5o`: 普号调用的4o模型，因为不能画图，所以与plus和team的4o隔离。
- `gpt-4`: 正常的gpt-4，模拟api，不支持联网等功能。
- `gpt-4-all`: GPT-4的全功能版本，支持图像、文件输入，支持调用联网插件，代码解释器，画图等全部官网功能。
- `gpt-4o`: 最新发布的GPT-4o模型，由plus或者team号调用。
- `gpt-4o-mini`: 最新发布的GPT-4o-mini模型，最有性价比的模型，由普号调用。
- `gpt-4-gizmo-*`: 匹配传入的gpts的gizmo id，调用所有gpts。
- `dall-e-3`: 官网画图模型，可定制尺寸，生成高质量画面。

支持两个端点：

- `/v1/images/generations`
- `/v1/chat/completions`

## 界面截图
<img width="1080" alt="image" src="https://github.com/user-attachments/assets/020015e5-8a37-4066-9c12-763915772633">
<img width="1080" alt="image" src="https://github.com/user-attachments/assets/04c51cc8-4885-4995-b910-9fc9d6ac1cd1">
<img width="1080" alt="2738c275edc33000fae4273dc17dc2b" src="https://github.com/user-attachments/assets/2faf0b1a-c599-449e-9228-d218563a9c11">

---

## 部署

为了部署本项目，你需要跟随以下步骤操作：

### 步骤 1: 克隆仓库

首先，一键部署脚本：

```bash
curl -sSfL https://raw.githubusercontent.com/hanglegehang/chat2api-plus/main/quick-install.sh | bash
```

### 步骤 2: 进入项目目录

克隆完成后，切换到项目目录中：

```bash
cd chat2api-plus
```

### 步骤 3: 配置文件

使用文本编辑器打开配置文件并按照指引填写相关配置。这里以 `vi` 编辑器为例：

```bash
vi config.yaml
```

| 配置项       | 描述                           | 默认值                     |
|-----------|------------------------------|-------------------------|
|    DelayTime | 单账号对话冷却时间，单位秒                | 0                       |
|    EnableRetry           | 是否开启自动重试                     | true                    |
|    RetryHttpCodeList           | 重试错误码，yaml格式配置，一行一个，不理解不要乱配置 | 401, 429, 502, 403, 500 |
|    MaxRetryCount | 最大重试次数                       | 3                       |
|    QueueRefreshAccount           | 是否开启队列加号                     | true                    |
|    QueueAddAccountRate           | 队列加号速率，单位秒                   | 2s处理一个                  |
|    PrePrompt           | 是否添加默认Prompt                 | true                    |
|    MaxContinueCount           | 超长对话，最大连续对话次数                | 3                       |
|    API_SERVER           | 网关地址                         | 无                       |
|    EnableWeight           | 是否开启权重                       | false                   |
|    EnableToolText           | 是否返回工具调用痕迹                   | false                   |
|    OssPicDisable           | 是否禁用图片oss,禁用后会直接返回官方地址       | false                   |
|    OverCountDisableTime           | 429后普号禁用时长，单位秒               | 3600（1小时）               |
|    SpeedTestSkip           | new-api测试速度优化                | false                   |
|    AUTO_DELETE_CONV           | 自动删除聊天记录，调用接口主动删除            | false                   |
|    HistoryDisabled           | 使用隐私默认对话，无法使用文件下载            | false                   |
|    DalleFreezeEnable           | 画图冷却，会将对话一起冷却，按需开启           | false                   |
|    DalleFreezeTime           | 画图冷却时长，单位秒                   | 10800（3小时）              |

确保根据实际情况修改配置文件中的设置，数据库连接、请求所需的验证秘钥、网关地址等。

### 步骤 4: 启动服务

使用 Docker Compose 启动服务。确保你的机器上已安装了 Docker 和 Docker Compose。

```bash
docker compose up -d
```

此命令将在后台启动所有必要的容器。

### 步骤 5: 访问后台

在浏览器中访问 `ip地址:端口/admin` 或者你配置的反向代理域名。

默认的用户名和密码为：

- 用户名: admin
- 密码: 123456

请在首次登陆后尽快更改默认密码以保证系统安全。



## 联系方式 & 购买授权

<img src="https://github.com/user-attachments/assets/fb135b91-b10f-4b11-bc04-ae5ba631aa79" width="250" height="auto" alt="联系方式及购买授权信息">
