# 插件名称 

cloudartifact

# 功能说明

用于将构建产物归档到云存储中

# 参数说明

| 参数名称 | 类型 | 默认值 | 是否必须 | 含义 |
|---|---|---|---|---|
| scm.type | string | git | **非必须** | 工程使用的版本控制类型，当归档版本（artifact.version）参数没有制定时，自动生成版本号时使用 |
| cloud.provider | string | qcloud | **必须** | qcloud/aliyun | 云服务提供商，目前只支持qcloud |
| app.id | string | 空 | **必须** | 空 |
| secret.id | string | 空 | **必须** | 空|
| secret.key | string | 空 | **必须** | 空|
| region | string | 空 | **必须** | 存储区域编号，比如：华北(tj), 西南(cd) |
| bucket | string | 空 | **必须** | 存储bucket名称 |
| artifact.lane | string | jenkins | **必须** | 存储分区，分区规范样例比如： dev/test/qa/prod等 |
| group.id | string | 空 | **必须** | 用于创建归档目录 |
| artifact.id | string | 空 | **必须** | 用于创建归档项目目录 |
| artifact.version | string | 空 | **必须** | 归档版本，如果为空也就是默认值，那么会通过scm.type自动生成 |
| fileset.dir | string | 空 | **必须** | 需要归档的文件目录 |
| fileset.includes | string | 空 | **必须** | 需要归档的文件目录下需要包含的文件模式 |
| fileset.exclude| string | 空 | **必须** | 需要归档的文件目录下需要排除的文件，也就是不需要归档的文件模式 |
| allow.redeploy | boolean | false | **必须** | 是否可以覆盖已归档文件 |
| is.create.checksum | boolean | true | **必须** | 是否需要创建md5校验文件 |

# 配置使用样例

```yml
stages:
- name: artifact
  tasks:
    - task.id: cloudartifact
      app.id: '12xxxxxx218'
      secret.id: 'AKIDxxxxxxxxxxxxO3rr3mjqSWI'
      secret.key: 'msvn9xxxxxxxxxxRg5Xvm496'
      region: 'gz'
      bucket: 'sgz2tx'
      artifact.lane: 'qa'
      artifact.version: $PIPELINE_VERSION
      fileset.dir: 'resdl'
      fileset.includes: '*.tar.gz,*.md5'
      is.create.checksum: false
      allow.redeploy: true
```