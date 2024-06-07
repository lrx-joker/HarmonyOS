# 项目介绍
    本项目是针对代码工具链生成的DDS服务文件所建立的。
 
    能够将多个DDS服务文件进行合并，构建DDS基本服务端以及客户端程序框架。包含生成server.cpp、client.cpp、CMakeLists.txt
 
# 环境依赖
 
 
# 目录结构描述
    ├── ReadMe.md           // 帮助文档
    
    ├── AutoCreateDDS.py    // 合成DDS的 python脚本文件
    
    ├── DDScore             // DDS核心文件库，包含各版本的include、src、lib文件夹，方便合并
    
    │   ├── include_src     // 包含各版本的include、src文件夹
    
    │       ├── V1.0
    
    │           ├── include
    
    │           └── src
    
    │       └── V......
    
    │   └── lib             // 包含各版本的lib文件夹
    
    │       ├── arm64       // 支持arm64系统版本的lib文件夹
    
    │           ├── V1.0
    
    │           └── V......
    
    │       └── x86         // 支持x86系统版本的lib文件夹
    
    │           ├── V1.0
    
    │           └── V......
    
    ├── target              // 合成结果存放的文件夹
    
    └── temp                // 存放待合并的服务的服务文件夹
 
# 使用说明
 
 
 
# 版本内容更新
###### v1.0.0: 
    1.实现gen文件的拷贝、合并
    
    2.实现common文件的合并
    
    3.实现指定版本的include、src、lib文件的拷贝
 
 
