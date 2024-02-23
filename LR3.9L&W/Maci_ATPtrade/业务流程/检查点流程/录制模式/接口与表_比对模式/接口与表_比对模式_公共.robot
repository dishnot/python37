*** Settings ***
Resource          ../../../../业务流程/检查点流程/录制模式/接口与表_录制模式/接口与表_录制模式_公共.robot
Resource          ../../../../业务流程/检查点流程/录制模式/接口与表_录制模式/接口与表_录制模式_普通.robot

*** Keywords ***
委托撤单查询_多条数据_比对录制模式
    [Arguments]    ${接口名称}
    [Documentation]    1.20211123 chm 新增
    ${委托_撤单合同序号key}    ${委托_撤单合同序号Values}    字典拆分为key和Values    ${委托_撤单合同序号_全局变量}
    ${合并信息}    Create List
    FOR    ${i}    IN    @{委托_撤单合同序号Values}
        ${返回码}    ${返回信息}    Run Keyword If    '${i}'!='${EMPTY}'    ${接口名称}    ${i}
        log    ${返回信息}
        Run Keyword If    '${i}'!='${EMPTY}'    Append To List    ${合并信息}    ${返回信息[0]}
        log    ${合并信息}
    END
    log    ${合并信息}
    [Return]    ${返回码}    ${合并信息}
