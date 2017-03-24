## icare2
### 开发环境
1. Mysql 5.5 以上
2. rails 4.1.4, ruby 2.1以上
3. redis 2.6 以上
### 初始化项目
`cp db/development.sqlite3.example db/development.sqlite3`
#### 运行 solr
`rails g sunspot_rails:install && rake sunspot:solr:start && rake
sunspot:solr:reindex`

### 运行测试
每次push代码前请运行 'rake spec'，以检查测试是否通过。
#### 数据准备
把开发数据还原到test 数据库

###前端开发简述：
1. 使用slim作为前端模板，Sass代替CSS，CoffeeScript代替JavaScript开发
2. 使用bootstrap 2.3.2作为前端组件库
3. 手机端式样(独立页面)，使用 mb-XX 作为class 或 id
