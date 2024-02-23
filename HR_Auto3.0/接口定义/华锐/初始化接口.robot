*** Settings ***
Library           RequestsLibrary
Resource          ../../公共目录/配置信息/环境配置信息.robot

*** Keywords ***
登录_web
    #获取session
    ${header}    Create Dictionary    Content-Type=application/json
    Create Session    信息查询    ${环境_全局变量["web网址"]}    ${header}
    log    网址：${环境_全局变量["web网址"]}${API地址["华锐web登录后缀1"]}|入参： 账号:"${环境_全局变量["web账号"]}" 密码：${环境_全局变量["web密码"]}
    ${resp}    POST On Session    信息查询    ${API地址["华锐web登录后缀1"]}    data={"userName": "${环境_全局变量["web账号"]}"}
    ${resp_json}    Set Variable    ${resp.json()}
    #密码处理及session
    ${session}    Evaluate    re.findall(r'shiro.session=(.+?); Path=/','${resp.headers['set-cookie']}')    re    #提取shiro.session
    ${randomKey}    Evaluate    hex(random.randint(0,16**8)).replace('0x','')    random    #随机生成字符串
    ${密码加密}    Evaluate    hashlib.sha256('${环境_全局变量["web密码"]}'.encode('utf-8')).hexdigest()    hashlib    #密码加密
    ${密码}    Evaluate    hashlib.sha256('${resp_json["body"]["challenge"]}${randomKey}${密码加密}'.encode('utf-8')).hexdigest()    hashlib    #密码最终由challenge、randomKey、密码加密三部分机密组成
    #登录
    ${华锐web_Cookie_全局变量}    Create Dictionary    shiro.session=${session[0]}
    Create Session    web登录    ${环境_全局变量["web网址"]}    ${header}    ${华锐web_Cookie_全局变量}
    log    网址：${环境_全局变量["web网址"]}${API地址["华锐web登录后缀2"]}|入参：{"password": "${密码}", "randomKey": "${randomKey}", "userName": "${环境_全局变量["web账号"]}"}
    ${resp}    POST On Session    web登录    ${API地址["华锐web登录后缀2"]}    data={"password": "${密码}", "randomKey": "${randomKey}", "userName": "${环境_全局变量["web账号"]}"}
    Should Be Equal As Strings    ${resp.json()["code"]}    0
    Set Global Variable    ${华锐web_Cookie_全局变量}

获取客户信息_web
    [Arguments]    ${客户号}=${客户代码_全局变量}
    ${header}    Create Dictionary    Content-Type=application/json
    Create Session    查询客户信息    ${环境_全局变量["web网址"]}    ${header}    ${华锐web_Cookie_全局变量}
    ${data}    Set Variable    {"matchFields":{"custId":"${客户号}"},"sort":{"key":"id","sortType":"ASC"}}
    log    网址：${环境_全局变量["web网址"]}${API地址["华锐web查询客户信息"]}|入参：${data}
    ${resp}    POST On Session    查询客户信息    ${API地址["华锐web查询客户信息"]}    data=${data}
    ${resp_json}    Set Variable    ${resp.json()}
    log    ${resp_json}
    #把数据拆分为上海和深圳
    ${深圳_客户信息}    Create Dictionary
    ${上海_客户信息}    Create Dictionary
    FOR    ${i}    IN    @{resp_json['body']['content']}
        log    ${i}
        log    '${i["marketId"]}'=='102'
        Run Keyword If    '${i["marketId"]}'=='102'    Set To Dictionary    ${深圳_客户信息}    证券账户=${i['accountId']}    资金账户=${i['fundId']}    客户号=${i['custId']}    客户姓名=${i['custName']}    营业部=${i['branchId']}    账户角色=${i['accountRole']}    资本属性=${i['capitalAttr']}    账户类型=${i['accountType']}    账户状态=${i['status']}:    市场代码=${i['marketId']}    所属交易单元=${i['pbuid']}    报盘交易单元=${i['offerPbuId']}
        ...    指定交易标志=${i['assignment']}    指定交易单元=${i['assignmentSeat']}    checkFund=${i['checkFund']}    checkShare=${i['checkShare']}    开户方式=${i['openAccountWay']}    权限模板ID=${i['templateId']}    权限模板名称=${i['templateName']}    accountMaxPurchaseQty=${i['accountMaxPurchaseQty']}    mainStockRightQty=${i['mainStockRightQty']}    tibStockRightQty=${i['tibStockRightQty']}    开户日期=${i['openDate']}    closeDate=${i['closeDate']}    dataStatus=${i['dataStatus']}    分区号=${i['partition']}
        Run Keyword if    '${i["marketId"]}'=='101'    Set To Dictionary    ${上海_客户信息}    证券账户=${i['accountId']}    资金账户=${i['fundId']}    客户号=${i['custId']}    客户姓名=${i['custName']}    营业部=${i['branchId']}    账户角色=${i['accountRole']}    资本属性=${i['capitalAttr']}    账户类型=${i['accountType']}    账户状态=${i['status']}:    市场代码=${i['marketId']}    所属交易单元=${i['pbuid']}    报盘交易单元=${i['offerPbuId']}
        ...    指定交易标志=${i['assignment']}    指定交易单元=${i['assignmentSeat']}    checkFund=${i['checkFund']}    checkShare=${i['checkShare']}    开户方式=${i['openAccountWay']}    权限模板ID=${i['templateId']}    权限模板名称=${i['templateName']}    accountMaxPurchaseQty=${i['accountMaxPurchaseQty']}    mainStockRightQty=${i['mainStockRightQty']}    tibStockRightQty=${i['tibStockRightQty']}    开户日期=${i['openDate']}    closeDate=${i['closeDate']}    dataStatus=${i['dataStatus']}    分区号=${i['partition']}
    END
    log    ${深圳_客户信息}
    log    ${上海_客户信息}
    Set Global Variable    ${深圳_客户信息}
    Set Global Variable    ${上海_客户信息}
    ${客户信息_全局变量}    Run Keyword If    '${交易板块_全局变量}'=='00'    Set Variable    ${深圳_客户信息}
    ...    ELSE IF    '${交易板块_全局变量}'=='10'    Set Variable    ${上海_客户信息}
    Comment    ${客户代码_全局变量}    Set Variable    ${i['CUST_CODE']}
    Set Global Variable    ${客户信息_全局变量}
    Comment    Set Global Variable    ${客户代码_全局变量}

获取证券信息_web
    [Arguments]    ${证券代码}=${证券代码_全局变量}
    ${header}    Create Dictionary    Content-Type=application/json
    Create Session    查询客户信息    ${环境_全局变量["web网址"]}    ${header}    ${华锐web_Cookie_全局变量}
    ${data}    Set Variable    {"matchFields":{"securityId":"${证券代码}"},"sort":{"key":"id","sortType":"ASC"}}
    log    网址：${环境_全局变量["web网址"]}${API地址["华锐web查询证券信息"]}|入参：${data}
    ${resp}    POST On Session    查询客户信息    ${API地址["华锐web查询证券信息"]}    data=${data}
    ${resp_json}    Set Variable    ${resp.json()}
    log    ${resp_json}
    ${证券信息_全局变量}    Set Variable    ${resp_json['body']['content'][0]}
    Set Global Variable    ${证券信息_全局变量}

资金调整_web
    [Arguments]    ${调整资金}    ${客户信息}=${客户信息_全局变量}    ${货币种类}=CNY
    ${header}    Create Dictionary    Content-Type=application/json
    Create Session    资金调整    ${环境_全局变量["web网址"]}    ${header}    ${华锐web_Cookie_全局变量}
    ${类型}    Set Variable    5    #5增加，6减少
    ${data}    Set Variable    {"data": {"branchId": "${客户信息["营业部"]}","currency": "${货币种类}","description": "","fundAccount": "${客户信息["资金账户"]}","operation": "${类型}","partition": "${客户信息["分区号"]}","value": "${调整资金}"},"instType": "FundAdjust"}
    log    网址：${环境_全局变量["web网址"]}${API地址["华锐web资金调整"]}|入参：${data}
    ${resp}    POST On Session    资金调整    ${API地址["华锐web资金调整"]}    data=${data}
    ${resp_json}    Set Variable    ${resp.json()}
    log    ${resp_json}
    ${instResult}    Set Variable    ${resp_json["body"]["instResult"]}
    log    ${instResult}

股份调整_web
    [Arguments]    ${调整持仓}    ${证券代码}=${证券代码_全局变量}    ${客户信息}=${客户信息_全局变量}
    ${header}    Create Dictionary    Content-Type=application/json
    Create Session    股份调整    ${环境_全局变量["web网址"]}    ${header}    ${华锐web_Cookie_全局变量}
    ${类型}    Set Variable    1    #1增加，2减少
    ${data}    Set Variable    {"accountId": "${客户信息["证券账户"]}","branchId": "${客户信息["营业部"]}","fundId": "${客户信息["资金账户"]}","marketId": "${客户信息["市场代码"]}","operation":"${类型}","partition": "${客户信息["分区号"]}","securityId": "${证券代码}","value": "${调整持仓}"}
    log    网址：${环境_全局变量["web网址"]}${API地址["华锐web股份调整"]}|入参：${data}
    ${resp}    POST On Session    股份调整    ${API地址["华锐web股份调整"]}    data=${data}
    ${resp_json}    Set Variable    ${resp.json()}
    log    ${resp_json}

交易参考信息设置_web
    [Arguments]    ${证券代码}=${证券代码_全局变量}    ${取证券业务号}=${用例名称转换成字典}
    ${header}    Create Dictionary    Content-Type=application/json
    Create Session    交易参考信息设置    ${环境_全局变量["web网址"]}    ${header}    ${华锐web_Cookie_全局变量}
    ${业务类型}    Run Keyword If    '${取证券业务号['证券业务']}' in '(100,101)'    Set Variable    1
    ...    ELSE IF    '${取证券业务号['证券业务']}' in '(160,161)'    Set Variable    15
    ...    ELSE IF    '${取证券业务号['证券业务']}' in '(106,153)'    Set Variable    14
    ...    ELSE IF    '${取证券业务号['证券业务']}' == '165'    Set Variable    2
    ...    ELSE IF    '${取证券业务号['证券业务']}' == '113'    Set Variable    13
    ...    ELSE IF    '${取证券业务号['证券业务']}' in '(181,182,187,188)'    Set Variable    12
    ${data}    Set Variable    {"matchFields":{"businessType":"${业务类型}","securityId":"${证券代码}"},"sort":{"key":"id","sortType":"ASC"}}
    log    网址：${环境_全局变量["web网址"]}${API地址["华锐web股份调整"]}|入参：${data}
    ${resp}    Run Keyword If    '${取证券业务号['证券业务']}' in '(100,101,160,161,165)'    POST On Session    交易参考信息设置    ${API地址["华锐web交易参考信息设置"]}    data=${data}
    ...    ELSE IF    '${取证券业务号['证券业务']}' in '(106,153)'    POST On Session    交易参考信息设置    ${API地址["华锐web配售交易参考信息设置"]}    data=${data}
    ...    ELSE IF    '${取证券业务号['证券业务']}' in '113'    POST On Session    交易参考信息设置    ${API地址["华锐web网上发行"]}    data=${data}
    ...    ELSE IF    '${取证券业务号['证券业务']}' in '(181,182,187,188)'    POST On Session    交易参考信息设置    ${API地址["华锐webETF申赎"]}    data=${data}
    ${resp_json}    Set Variable    ${resp.json()}
    log    ${resp_json}
    ${价位价差_全局变量}    Run Keyword If    '${取证券业务号['证券业务']}' in '(100,101,165)'    Set Variable    ${resp_json["body"]["content"][0]["priceTick"]}
    ...    ELSE IF    '${取证券业务号['证券业务']}' in '(106,153,160,161,113)'    Set Variable    ${EMPTY}
    Set Global Variable    ${价位价差_全局变量}
