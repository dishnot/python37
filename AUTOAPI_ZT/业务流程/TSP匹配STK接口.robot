*** Settings ***
Resource          ../公共目录/通用操作/常用关键字.robot
Resource          ../公共目录/配置信息/TSP环境配置信息.robot
Resource          ../公共目录/配置信息/POST接口调用.robot
Resource          ../公共目录/数据配置/账户信息.robot
Resource          ../接口定义/中台/F1接口.robot
Resource          ../接口定义/中台/F4接口.robot
Resource          ../接口定义/中台/F9接口.robot
Resource          ../公共目录/通用操作/数据库查询.robot
Resource          ../公共目录/配置信息/环境连接.robot
Resource          ../接口定义/金证/3.实时查询.robot
Resource          ../接口定义/金证/4.辅助功能.robot
Resource          ../接口定义/华锐/初始化接口.robot
Resource          ../接口定义/华锐/查询接口.robot
Resource          ../公共目录/配置信息/接口入参数据.robot
Resource          检查点流程.robot
Resource          中台初始化流程.robot
Resource          TSP对接系统方初始化流程.robot

*** Keywords ***
调用接口
    ${返回码}    ${返回信息}    Run KeyWord If    '${接口名_全局变量}' in ('F400001','F900201')    可用资金查询_10303001
    ...    ELSE IF    '${接口名_全局变量}' in ('F900202','F400002','F900204','F400004') and ${划拨方向_全局变量}==2    可用资金查询_10303001
    ...    ELSE IF    '${接口名_全局变量}' in ('F900202','F400002','F900204','F400004') and ${划拨方向_全局变量}==1    可用资金查询_10303131_集中交易
    ...    ELSE IF    '${接口名_全局变量}' in ('F900203','F400003')    资金流水查询_10309005
    ...    ELSE IF    '${接口名_全局变量}' in ('F900000')    用户登录API_10301105
    Run KeyWord If    ${返回码}!=200    LOG    请核对环境及接口！！！
    [Return]    ${返回码}    ${返回信息}
