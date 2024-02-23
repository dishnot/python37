*** Settings ***
Resource          接口与表_录制模式.robot

*** Keywords ***
查询接口与表比对的通用流程
    [Arguments]    ${调用接口}
    [Documentation]    1.20211123 chm 新增
    log    ${调用接口}
    FOR    ${i}    IN    @{调用接口}
        ${返回码}    ${返回信息}    Run Keyword If    '${i}'in ('当日委托查询_10303003')    委托撤单查询_多条数据_比对录制模式    ${i}
        ...    ELSE    ${i}
        log    -----对比-----
        接口与表比对验证_比对模式    ${i}    ${返回信息}
    END

接口与表比对验证_比对模式
    [Arguments]    ${查询接口名称}    ${dict}
    [Documentation]    1.20211123 chm 新增
    #接口与表获取
    ${接口结果}    ${表结果}    接口与表处理_比对模式    ${查询接口名称}    ${dict}
    # 接口与表对比
    ${len_接口}    Get Length    ${接口结果}
    ${len_表}    Get Length    ${表结果}
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${len_接口}    ${len_表}    返回记录数与预期结果不一致
    ${msg}    Set Variable
    FOR    ${i}    IN RANGE    ${len_接口}
        log    ${接口结果[${i}]}|${表结果[${i}]}
        ${status}    ${error_msg}    Run Keyword And Ignore Error    Dictionaries Should Be Equal    ${接口结果[${i}]}    ${表结果[${i}]}
        ${msg}    Set Variable If    '${status}'=='FAIL'    ${msg} 记录${i+1}：【${error_msg[42:]}】    ${msg}
        log    ${msg}
    END
    ${msg_top}    Set Variable    ${查询接口名称}以下记录与预期结果不一致:
    ${msg}    Set Variable    ${msg_top}${msg}
    #Run Keyword And Continue On Failure    Should Be Equal As Strings    ${msg}    ${msg_top}
    Run Keyword And Ignore Error    Should Be Equal As Strings    ${msg}    ${msg_top}

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
