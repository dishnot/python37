*** Settings ***
Library           RequestsLibrary
Library           DatabaseLibrary
Library           demjson

*** Keywords ***
接口入参数据
    [Arguments]    ${接口}
    ${接口入参数据}    Run KeyWord If    '${接口}'=='F10301105'    Set Variable    { \ \ \ \ "request": { \ \ \ \ \ \ \ \ "F_OP_USER": "79197095", \ \ \ \ \ \ \ \ "F_OP_ROLE": "1", \ \ \ \ \ \ \ \ "F_OP_SITE": "Captain Liu", \ \ \ \ \ \ \ \ "F_CHANNEL": "7", \ \ \ \ \ \ \ \ "F_SESSION": "", \ \ \ \ \ \ \ \ "F_FUNCTION": "f10301105", \ \ \ \ \ \ \ \ "F_RUNTIME": "2023-1-3 10:09:10.0010", \ \ \ \ \ \ \ \ "F_OP_ORG": "8071", \ \ \ \ \ \ \ \ "ACCT_TYPE": "Z", \ \ \ \ \ \ \ \ "ACCT_ID": "12989039", \ \ \ \ \ \ \ \ "PASSWORD": "123444" \ \ \ \ } }
    ...    ELSE IF    '${接口}'=='F400001'    Set Variable    { \ \ \ \ "request": { \ \ \ \ \ \ \ \ "opUser": "27639016", \ \ \ \ \ \ \ \ "opRole": "2", \ \ \ \ \ \ \ \ "opSite": "Captain Liu", \ \ \ \ \ \ \ \ "channel": "P", \ \ \ \ \ \ \ \ "session": "", \ \ \ \ \ \ \ \ "functionId": "F400001", \ \ \ \ \ \ \ \ "runTime": "16:00", \ \ \ \ \ \ \ \ "opOrg": "8070", \ \ \ \ \ \ \ \ "account": "10888427" \ \ \ \ } }
    ...    ELSE IF    '${接口}'=='F400020'    Set Variable    { \ \ \ \ "request": { \ \ \ \ \ \ \ \ "opUser": "34332263", \ \ \ \ \ \ \ \ "opRole": "2", \ \ \ \ \ \ \ \ "opSite": "Captain Liu", \ \ \ \ \ \ \ \ "channel": "P", \ \ \ \ \ \ \ \ "session": "", \ \ \ \ \ \ \ \ "functionId": "F400001", \ \ \ \ \ \ \ \ "runTime": "16:00", \ \ \ \ \ \ \ \ "opOrg": "8161", \ \ \ \ \ \ \ \ "account": "10888476" \ \ \ \ } }
    ...    ELSE IF    '${接口}'=='F400030'    Set Variable    { \ \ \ \ "request": { \ \ \ \ \ \ \ \ "opUser": "34332263", \ \ \ \ \ \ \ \ "opRole": "2", \ \ \ \ \ \ \ \ "opSite": "Captain Liu", \ \ \ \ \ \ \ \ "channel": "P", \ \ \ \ \ \ \ \ "session": "", \ \ \ \ \ \ \ \ "functionId": "F400030", \ \ \ \ \ \ \ \ "runTime": "16:00", \ \ \ \ \ \ \ \ "opOrg": "8161", \ \ \ \ \ \ \ \ "account": "79150866" \ \ \ \ } }
    ...    ELSE IF    '${接口}'=='F900000'    Set Variable    { \ \ \ \ "request": { \ \ \ \ \ \ \ \ "opUser": "27638406", \ \ \ \ \ \ \ \ "opRole": "1", \ \ \ \ \ \ \ \ "opSite": "NA", \ \ \ \ \ \ \ \ "channel": "7", \ \ \ \ \ \ \ \ "session": "", \ \ \ \ \ \ \ \ "functionId": "F900000", \ \ \ \ \ \ \ \ "runTime": "16:00", \ \ \ \ \ \ \ \ "opOrg": "8161", \ \ \ \ \ \ \ \ "idType": "Z", \ \ \ \ \ \ \ \ "userId": "55801392", \ \ \ \ \ \ \ \ "password": "123444" \ \ \ \ } }
    ...    ELSE IF    '${接口}'=='F900201'    Set Variable    { \ \ \ \ "request": { \ \ \ \ \ \ \ \ "opUser": "34332263", \ \ \ \ \ \ \ \ "opRole": "2", \ \ \ \ \ \ \ \ "opSite": "Captain Liu", \ \ \ \ \ \ \ \ "channel": "P", \ \ \ \ \ \ \ \ "session": "", \ \ \ \ \ \ \ \ "functionId": "F900201", \ \ \ \ \ \ \ \ "runTime": "16:00", \ \ \ \ \ \ \ \ "opOrg": "8161", \ \ \ \ \ \ \ \ "account": "37858825" \ \ \ \ \ } }
    ...    ELSE IF    '${接口}'=='F900202'    Set Variable    { \ \ \ \ "request": { \ \ \ \ \ \ \ \ "opUser": "34332263", \ \ \ \ \ \ \ \ "opRole": "2", \ \ \ \ \ \ \ \ "opSite": "Captain Liu123", \ \ \ \ \ \ \ \ "channel": "P", \ \ \ \ \ \ \ \ "session": "", \ \ \ \ \ \ \ \ "functionId": "F900300", \ \ \ \ \ \ \ \ "runTime": "16:00", \ \ \ \ \ \ \ \ "opOrg": "8161", \ \ \ \ \ \ \ \ "currency": "0", \ \ \ \ \ \ \ \ "direct":"2", \ \ \ \ \ \ \ \ "account": "37858825" \ \ \ \ } }
    ...    ELSE IF    '${接口}'=='F900203'    Set Variable    { \ \ \ \ "request": { \ \ \ \ \ \ \ \ "opUser": "34332263", \ \ \ \ \ \ \ \ "opRole": "2", \ \ \ \ \ \ \ \ "opSite": "Captain Liu", \ \ \ \ \ \ \ \ "channel": "P", \ \ \ \ \ \ \ \ "session": "", \ \ \ \ \ \ \ \ "functionId": "F900300", \ \ \ \ \ \ \ \ "runTime": "16:00", \ \ \ \ \ \ \ \ "opOrg": "8161", \ \ \ \ \ \ \ \ "currency": "0", \ \ \ \ \ \ \ \ "direct":"1", \ \ \ \ \ \ \ \ "account": "37858825", \ \ \ \ \ \ \ \ "bizAmount": "1" \ \ \ \ } }
    ...    ELSE IF    '${接口}'=='F900204'    Set Variable    { \ \ \ \ "request": { \ \ \ \ \ \ \ \ "opUser": "34332263", \ \ \ \ \ \ \ \ "opRole": "2", \ \ \ \ \ \ \ \ "opSite": "Captain Liu", \ \ \ \ \ \ \ \ "channel": "P", \ \ \ \ \ \ \ \ "session": "919FAC6F55064ABEB56C941C3679702D", \ \ \ \ \ \ \ \ "functionId": "F900300", \ \ \ \ \ \ \ \ "runTime": "16:00", \ \ \ \ \ \ \ \ "opOrg": "8161", \ \ \ \ \ \ \ \ "currency": "0", \ \ \ \ \ \ \ \ "direct":"2", \ \ \ \ \ \ \ \ "account": "79162621", \ \ \ \ \ \ \ \ "bizAmount": "1" \ \ \ \ } }
    ...    ELSE IF    '${接口}'=='F910005'    Set Variable    { \ \ \ \ "request": { \ \ \ \ \ \ \ \ "opUser": "34332263", \ \ \ \ \ \ \ \ "opRole": "2", \ \ \ \ \ \ \ \ "opSite": "Captain Liu", \ \ \ \ \ \ \ \ "channel": "P", \ \ \ \ \ \ \ \ "session": "", \ \ \ \ \ \ \ \ "functionId": "F900300", \ \ \ \ \ \ \ \ "runTime": "16:00", \ \ \ \ \ \ \ \ "opOrg": "8161", \ \ \ \ \ \ \ \ "account": "79197175" \ \ \ \ } }
    ...    ELSE IF    '${接口}'=='F910100'    Set Variable    000000
    ...    ELSE IF    '${接口}'=='F910300'    Set Variable    { \ \ \ \ "request": { \ \ \ \ \ \ \ \ "opUser": "79197095", \ \ \ \ \ \ \ \ "opRole": "1", \ \ \ \ \ \ \ \ "opSite": "Captain Liu", \ \ \ \ \ \ \ \ "channel": "P", \ \ \ \ \ \ \ \ "session": "l6gbc0j73bfftxb27xthagua3hsm5qi8f6de", \ \ \ \ \ \ \ \ "functionId": "F910401", \ \ \ \ \ \ \ \ "runTime": "16:00", \ \ \ \ \ \ \ \ "opOrg": "8161", \ \ \ \ \ \ \ \ "account": "79197177", \ \ \ \ \ \ \ \ "cashNo": "458" \ \ \ \ } }
    ...    ELSE IF    '${接口}'=='F910401'    Set Variable    { \ \ \ \ "request": { \ \ \ \ \ \ \ \ "opUser": "79197095", \ \ \ \ \ \ \ \ "opRole": "1", \ \ \ \ \ \ \ \ "opSite": "Captain Liu", \ \ \ \ \ \ \ \ "channel": "P", \ \ \ \ \ \ \ \ "session": "kgch71o41amdnf9d9d0ae2pwgfuhma0z1s40", \ \ \ \ \ \ \ \ "functionId": "F910401", \ \ \ \ \ \ \ \ "runTime": "16:00", \ \ \ \ \ \ \ \ "opOrg": "8161", \ \ \ \ \ \ \ \ "account": "12989039", \ \ \ \ \ \ \ \ "pageNum":"1", \ \ \ \ \ \ \ \ "pageSize":"100" \ \ \ \ } }
    [Return]    ${接口入参数据}

固定入参数据
    [Arguments]    ${操作用户代码}=${操作用户代码_全局变量}    ${操作用户角色}=${操作用户角色_全局变量}    ${操作站点}=${操作站点_全局变量}    ${操作渠道}=${操作渠道_全局变量}    ${会话凭证}=${会话凭证_全局变量}    ${功能代码}=${功能代码_全局变量}    ${调用时间}=${调用时间_全局变量}    ${操作机构}=${操作机构_全局变量}
    ${固定入参数据}    Set Variable    "opUser":"${操作用户代码}","opRole":"${操作用户角色}","opSite":"${操作站点}","channel":"${操作渠道}","session":"${会话凭证}","functionId":"${功能代码}","runTime":"${调用时间}","opOrg":"${操作机构}"
    [Return]    ${固定入参数据}

固参逻辑取值
    [Arguments]    ${接口属性}=${接口属性_全局变量}    ${接口名}=${接口名_全局变量}
    #${接口名}    Convert To String    ${接口名}
    ${操作用户代码_全局变量}    Set Variable    ${TSP客户号}
    ${操作用户角色_全局变量}    Run Keyword If    '${接口属性}'=='F9'    Set Variable    1
    ...    ELSE IF    '${接口属性}'=='F4'    Set Variable    2
    ${操作站点_全局变量}    Set Variable    PC;IIP=10.138.2.47;IPORT=59637;LIP=10.18.15.141;MAC=D8BBC1ED6CBB;HD=CA4E2_0E_052238_CE_EE24EA_0C_00;PCN=DESKTOP-UT9IGF1;CPU=BFEBFBFF000A0653;PI=C^4EED091C^NTFS^116G;VOL=WINDOWS^4@MATRADEAPP.EXE
    ${操作渠道_全局变量}    Set Variable    P
    ${会话凭证_全局变量}    Run Keyword If    '${接口属性}'!='F4' and '${接口名}'!='F900000'    Set Variable    ${session_全局变量}
    ...    ELSE IF    '${接口属性}'=='F4' or '${接口名}'=='F900000'    Set Variable    ${EMPTY}
    ${功能代码_全局变量}    Set Variable    ${接口名}
    ${调用时间_全局变量}    Set Variable    15：23
    ${操作机构_全局变量}    Set Variable    ${操作机构_全局变量}
    Set Global Variable    ${操作用户代码_全局变量}
    Set Global Variable    ${操作用户角色_全局变量}
    Set Global Variable    ${操作站点_全局变量}
    Set Global Variable    ${操作渠道_全局变量}
    Set Global Variable    ${会话凭证_全局变量}
    Set Global Variable    ${功能代码_全局变量}
    Set Global Variable    ${调用时间_全局变量}
    Set Global Variable    ${操作机构_全局变量}

业务入参数据
    [Arguments]    ${市场}    ${币种}=0    ${划拨方向}=${划拨方向_全局变量}    ${发生金额}=${发生金额_全局变量}
    ${业务入参数据}    Run keyword If    '${接口名_全局变量}'=='F400001'    Set Variable    "account":"${资金账户}","market":"${市场}"
    ...    ELSE IF    '${接口名_全局变量}'=='F900201'    Set Variable    "account":"${资金账户}","market":"${市场}","currency":"${币种}"
    ...    ELSE IF    '${接口名_全局变量}'=='F900202'    Set Variable    "account":"${资金账户}","direct":"${划拨方向}","currency":"${币种}"
    ...    ELSE IF    '${接口名_全局变量}'=='F900203'    Set Variable    "account":"${资金账户}","direct":"${划拨方向}","currency":"${币种}","bizAmount":"${发生金额}"
    ...    ELSE IF    '${接口名_全局变量}'=='F900204'    Set Variable    "account":"${资金账户}","direct":"${划拨方向}","currency":"${币种}","bizAmount":"${发生金额}"
    [Return]    ${业务入参数据}

登录业务入参数据
    [Arguments]    ${账户类型}=Z    ${用户账户}=${资金账户}
    ${密码}    Run KeyWord If    '${测试系统_全局变量}'=='ATP'    Set Variable    123321
    ...    ELSE IF    '${测试系统_全局变量}'=='STK'    Set Variable    123444
    ...    ELSE IF    '${测试系统_全局变量}'=='WFW'    Set Variable    123444
    ${业务入参数据}    Set Variable    "idType":"${账户类型}","userId":"${用户账户}","password":"${密码}"
    [Return]    ${业务入参数据}

登录固参逻辑取值
    [Arguments]    ${接口属性}=${接口属性_全局变量}    ${接口名}=F900000
    #${接口名}    Convert To String    ${接口名}
    ${操作用户代码_全局变量}    Set Variable    ${TSP客户号}
    ${操作用户角色_全局变量}    Run Keyword If    '${接口属性}'=='F9'    Set Variable    1
    ...    ELSE IF    '${接口属性}'=='F4'    Set Variable    2
    ${操作站点_全局变量}    Set Variable    PC;IIP=10.138.2.47;IPORT=59637;LIP=10.18.15.141;MAC=D8BBC1ED6CBB;HD=CA4E2_0E_052238_CE_EE24EA_0C_00;PCN=DESKTOP-UT9IGF1;CPU=BFEBFBFF000A0653;PI=C^4EED091C^NTFS^116G;VOL=WINDOWS^4@MATRADEAPP.EXE
    ${操作渠道_全局变量}    Set Variable    P
    ${功能代码_全局变量}    Set Variable    ${接口名}
    ${调用时间_全局变量}    Set Variable    15：23
    ${操作机构_全局变量}    Set Variable    ${操作机构_全局变量}
    Set Global Variable    ${操作用户代码_全局变量}
    Set Global Variable    ${操作用户角色_全局变量}
    Set Global Variable    ${操作站点_全局变量}
    Set Global Variable    ${操作渠道_全局变量}
    Set Global Variable    ${功能代码_全局变量}
    Set Global Variable    ${调用时间_全局变量}
    Set Global Variable    ${操作机构_全局变量}

登录固定入参数据
    [Arguments]    ${操作用户代码}=${操作用户代码_全局变量}    ${操作用户角色}=${操作用户角色_全局变量}    ${操作站点}=${操作站点_全局变量}    ${操作渠道}=${操作渠道_全局变量}    ${功能代码}=${功能代码_全局变量}    ${调用时间}=${调用时间_全局变量}    ${操作机构}=${操作机构_全局变量}
    ${固定入参数据}    Set Variable    "opUser":"${操作用户代码}","opRole":"${操作用户角色}","opSite":"${操作站点}","channel":"${操作渠道}","functionId":"${功能代码}","runTime":"${调用时间}","opOrg":"${操作机构}"
    [Return]    ${固定入参数据}

双中心资金划拨方向参数
    [Arguments]    ${环境}
    ${划拨方向}    Run KeyWord If    '${TEST_ENV_SH}'=='${环境}' and '${接口名_全局变量}' in ('F900203','F400003')    Set Variable    0
    ...    ELSE IF    '${TEST_ENV_SZ}'=='${环境}' and '${接口名_全局变量}' in ('F900203','F400003')    Set Variable    1
    [Return]    ${划拨方向}
