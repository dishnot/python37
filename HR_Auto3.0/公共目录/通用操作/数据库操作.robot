*** Settings ***
Resource          ../配置信息/环境配置信息.robot
Resource          常用关键字.robot
Resource          华锐_数据库操作.robot

*** Keywords ***
买卖交易委托后检查_表查询
    [Arguments]    ${接口或表名称}    ${字段名称}    ${接口类型}=${接口类型_全局变量}
    [Documentation]    1.20211123 chm 新增
    数据库链接
    log    ${接口或表名称}
    ${字段名称key}    ${字段名称values}    字典拆分为key和Values    ${字段名称}
    ${Status}    ${msg}    Run Keyword And Ignore Error    Dictionary Should Contain Value    ${字段名称}    无计算逻辑
    ${字段名称}    ${表名}    ${条件}    Run Keyword    华锐_买卖委托表数据查询    ${字段名称key}    ${字段名称values}    ${接口或表名称}    ${字段名称}    ${Status}
    # 查询
    log    select ${字段名称} from ${表名} where ${条件}
    ${字段值}    query    select ${字段名称} from ${表名} where ${条件}
    log    ${字段值}
    ${表结果}    Create List
    FOR    ${i}    IN    @{字段值}
        ${表_转换字典}    列表转换为字典    ${字段名称key}    ${i}
        Append To List    ${表结果}    ${表_转换字典}
    END
    log    ${表结果}
    [Return]    ${表结果}
