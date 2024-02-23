*** Settings ***
Resource          ../公共目录/通用操作/常用关键字.robot
Resource          ../公共目录/配置信息/TSP环境配置信息.robot
Resource          ../公共目录/配置信息/POST接口调用.robot

*** Keywords ***
环境冒烟测试
    冒烟用例名称转换为字典
    ${url}    Run KeyWord    通过接口名取环境路径
    ${返回信息}    ${返回消息头}    POST接口下单请求_ZT    ${url}    ${接口名_全局变量}
    LOG     环境测试
