*** Settings ***
Documentation     订单_78为linux上海软加速环境
...               订单_118为linux深圳软加速环境
Library           RequestsLibrary
Resource          ../通用操作/常用关键字.robot
Library           DatabaseLibrary
Library           demjson
Resource          ../../接口定义/华锐/连接接口.robot
Resource          ../../业务流程/检查点流程.robot

*** Variables ***
&{API地址}          网址=http://utp.ciccwm.com    金证api接口后缀=/macli/client/    环境后缀=/api/rfenv/    金证柜台接口后缀=/lbm/client/    华锐环境后缀=/atp/env/    华锐api接口后缀=/atp/client/    华锐web登录后缀1=/bss/getChallenge    华锐web登录后缀2=/bss/login    华锐web查询客户信息=/bss/account/list    华锐web查询证券信息=/bss/security/list    华锐web资金调整=/bss/fund/query    华锐web股份调整=/bss/stock/sharePositionAdjust    华锐web交易参考信息设置=/bss/securityParam/list    华锐web配售交易参考信息设置=/bss/rightsIssueBusinessRule/list    华锐webETF实时申购赎回=/bss/etfBizRule/list    华锐web网上发行=/bss/securityParam/businessType/13/list    华锐api返回信息=/atp/order/
&{订单_66}          服务器IP=10.138.1.66    服务器端口=41000    数据库=10.138.1.68    数据库名称=kbss_stds    数据库用户名称=sa    数据库密码=zt@1234    数据库端口=1433    服务队列=req_stds    应答队列=ans_stds    servername=KCBP01    username=KCXP00    password=888888    protocol=${0}    port=${21000}
&{订单_37}          服务器IP=10.171.7.37    服务器端口=41000    数据库=10.171.9.13    数据库名称=kbss_stds_zt    数据库用户名称=sa    数据库密码=zt@1234    数据库端口=1433    服务队列=req_stds_zt    应答队列=ans_stds_zt    servername=KCBP01    username=KCXP00    password=888888    protocol=${0}    port=${21000}
&{订单_134}         服务器IP=10.171.7.134    服务器端口=41000    数据库=10.171.9.13    数据库名称=kbss_stds_zt2    数据库用户名称=sa    数据库密码=zt@1234    数据库端口=1433    服务队列=req_stds_zt2    应答队列=ans_stds_zt2    servername=KCBP01    username=KCXP00    password=888888    protocol=${0}    port=${21000}
&{订单_47}          服务器IP=10.138.2.47    服务器端口=41000    数据库=10.138.1.68    数据库名称=kbss_stds_47    数据库用户名称=sa    数据库密码=zt@1234    数据库端口=1433    服务队列=req_stds    应答队列=ans_stds    servername=KCBP01    username=KCXP00    password=888888    protocol=${0}    port=${21000}
&{订单_118}         服务器IP=10.171.1.118    服务器端口=41000    数据库=10.171.9.13    数据库名称=kbss_stds_33    数据库用户名称=sa    数据库密码=szkd@@600446    数据库端口=1433    服务队列=req_stds_33    应答队列=ans_stds_33    servername=KCBP01    username=KCXP00    password=888888    protocol=${0}    port=${21000}
&{订单_27}          服务器IP=10.174.3.27    服务器端口=41000    数据库=10.171.9.13    数据库名称=kbss_stds_33    数据库用户名称=sa    数据库密码=zt@1234    数据库端口=1433    服务队列=req_stds_33    应答队列=ans_stds_33    servername=KCBP01    username=KCXP00    password=888888    protocol=${0}    port=${21000}
&{订单_78}          服务器IP=10.171.7.78    服务器端口=41000    数据库=10.171.9.13    数据库名称=kbss_stds_331    数据库用户名称=sa    数据库密码=szkd@@600446    数据库端口=1433    服务队列=req_stds_331    应答队列=ans_stds_331    servername=KCBP01    username=KCXP00    password=888888    protocol=${0}    port=${21000}
&{华锐_123}         web网址=http://10.138.2.125:8091    web账号=allOp    web密码=archforce    数据库IP=10.138.2.125    数据库用户名=bos    数据库密码=Bos@2021    数据库端口=${3306}    序号=${3}    环境名称=123    环境描述=测试环境    网关IP=10.138.2.123    网关账户=zjcftest8    网关密码=zjcftest8    网关端口=${32001}
&{华锐_223}         web网址=http://10.138.2.224:8091    web账号=allOp    web密码=archforce    数据库IP=10.138.2.224    数据库用户名=bos    数据库密码=Bos@2022    数据库端口=${3306}    序号=${2}    环境名称=223    环境描述=测试环境    网关IP=10.138.2.223    网关账户=zdhcs005    网关密码=zdhcs005    网关端口=${32001}
&{华锐_188}         web网址=http://10.138.2.224:8091    web账号=allOp    web密码=archforce    数据库IP=10.138.2.224    数据库用户名=bos    数据库密码=Bos@2022    数据库端口=${3306}    序号=${2}    环境名称=188    环境描述=测试环境    网关IP=10.138.2.188    网关账户=zdhce002    网关密码=zdhce002    网关端口=${32005}
&{新版华锐_123}       web网址=http://10.138.2.125:8091    web账号=allOp    web密码=archforce    数据库IP=10.138.2.125    数据库用户名=bos    数据库密码=Bos@2021    数据库端口=${3306}    序号=${3}    环境名称=123_new    环境描述=测试环境    网关IP=10.138.2.123    网关账户=sqltest2    网关密码=sqltest2    网关端口=${32001}
&{新版华锐_223}       web网址=http://10.138.2.224:8091    web账号=allOp    web密码=archforce    数据库IP=10.138.2.224    数据库用户名=bos    数据库密码=Bos@2022    数据库端口=${3306}    序号=${2}    环境名称=223_new    环境描述=测试环境    网关IP=10.138.2.223    网关账户=zdhcs006    网关密码=zdhcs006    网关端口=${32001}
&{新版华锐_188}       web网址=http://10.138.2.224:8091    web账号=allOp    web密码=archforce    数据库IP=10.138.2.224    数据库用户名=bos    数据库密码=Bos@2022    数据库端口=${3306}    序号=${2}    环境名称=188_new    环境描述=测试环境    网关IP=10.138.2.188    网关账户=zdhce001    网关密码=zdhce001    网关端口=${32005}

*** Keywords ***
环境信息查询与连接
    [Arguments]    ${接口类型}=${接口类型_全局变量}
    #华锐和金证环境    Stk是金证，Cash是华锐
    ${环境}    Run Keyword If    '${TEST_ENV}'=='66'    Set Variable    ${订单_66}
    ...    ELSE IF    '${TEST_ENV}'=='47'    Set Variable    ${订单_47}
    ...    ELSE IF    '${TEST_ENV}'=='118'    Set Variable    ${订单_118}
    ...    ELSE IF    '${TEST_ENV}'=='37'    Set Variable    ${订单_37}
    ...    ELSE IF    '${TEST_ENV}'=='134'    Set Variable    ${订单_134}
    ...    ELSE IF    '${TEST_ENV}'=='27'    Set Variable    ${订单_27}
    ...    ELSE IF    '${TEST_ENV}'=='78'    Set Variable    ${订单_78}
    ...    ELSE IF    '${TEST_ENV}'=='123'    Set Variable    ${华锐_123}
    ...    ELSE IF    '${TEST_ENV}'=='223'    Set Variable    ${华锐_223}
    ...    ELSE IF    '${TEST_ENV}'=='188'    Set Variable    ${华锐_188}
    ...    ELSE IF    '${TEST_ENV}'=='123_new'    Set Variable    ${新版华锐_123}
    ...    ELSE IF    '${TEST_ENV}'=='223_new'    Set Variable    ${新版华锐_223}
    ...    ELSE IF    '${TEST_ENV}'=='188_new'    Set Variable    ${新版华锐_188}
    ${域名/IP}    Run Keyword If    '${接口类型}'=='Stk'    Set Variable    ${环境["服务器IP"]}
    ...    ELSE IF    '${接口类型}'=='Cash'    Set Variable    ${环境["网关IP"]}
    ${端口}    Run Keyword If    '${接口类型}'=='Stk'    Set Variable    ${环境["服务器端口"]}
    ...    ELSE IF    '${接口类型}'=='Cash'    Set Variable    ${环境["网关端口"]}
    ${数据库信息}    Run Keyword If    '${接口类型}'=='Stk'    Set Variable    Server=${环境["数据库"]};Port=${环境["数据库端口"]};Database=${环境["数据库名称"]};UID=${环境["数据库用户名称"]};PWD=${环境["数据库密码"]}
    ...    ELSE IF    '${接口类型}'=='Cash'    Set Variable    host='${环境["数据库IP"]}',port=${环境["数据库端口"]},user='${环境["数据库用户名"]}',password='${环境["数据库密码"]}'    #password='${环境["数据库密码"]}',host='${环境["数据库IP"]}',port=${环境["数据库端口"]},user='${环境["数据库用户名"]}'
    ${队列信息}    Run Keyword If    '${接口类型}'=='Stk' and '${TEST_ENV}'in'(118,78,27)'    Set Variable    {\\"address\\":\\"${环境["数据库"]}\\",\\"sendq\\":\\"${环境["服务队列"]}\\",\\"recvq\\":\\"${环境["应答队列"]}\\",\\"servername\\":\\"${环境["servername"]}\\",\\"username\\":\\"${环境["username"]}\\",\\"password\\":\\"${环境["password"]}\\",\\"protocol\\":${环境["protocol"]},\\"port\\":${环境["port"]}}
    ...    ELSE IF    '${接口类型}'=='Stk' and '${TEST_ENV}'in'(47,66,37,134)'    Set Variable    {\\"address\\":\\"${环境["服务器IP"]}\\",\\"sendq\\":\\"${环境["服务队列"]}\\",\\"recvq\\":\\"${环境["应答队列"]}\\",\\"servername\\":\\"${环境["servername"]}\\",\\"username\\":\\"${环境["username"]}\\",\\"password\\":\\"${环境["password"]}\\",\\"protocol\\":${环境["protocol"]},\\"port\\":${环境["port"]}}
    ...    ELSE IF    '${接口类型}'=='Cash'    Set Variable    {\\"id\\":${环境["序号"]},\\"env_name\\":\\"${环境["环境名称"]}\\",\\"env_desc\\":\\"${环境["环境描述"]}\\",\\"gate_user\\":\\"${环境["网关账户"]}\\",\\"gate_password\\":\\"${环境["网关密码"]}\\",\\"env_ip\\":\\"${环境["网关IP"]}\\",\\"port\\":${环境["网关端口"]}}
    ${请求信息}    Run Keyword If    '${接口类型}'=='Stk'    Set Variable    \\"F_SESSION\\":\\"1839893105657921\\",\\"F_OP_SITE\\":\\"00505680bbd7\\",\\"F_CHANNEL\\":\\"0\\",\\"F_OP_USER\\":\\"w8sBypob9KM=\\",\\"F_OP_ROLE\\":\\"2\\",\\"F_OP_ORG\\":\\"8001\\",
    ...    ELSE IF    '${接口类型}'=='Cash'    Set Variable    \    #\\"F_SESSION\\":\\"1839893105657921\\",\\"F_OP_SITE\\":\\"00505680bbd7\\",\\"F_CHANNEL\\":\\"0\\",\\"F_OP_USER\\":\\"w8sBypob9KM=\\",\\"F_OP_ROLE\\":\\"2\\",\\"F_OP_ORG\\":\\"8001\\",
    ${环境_全局变量}    Set Variable    ${环境}
    Set Global Variable    ${环境_全局变量}
    #把数据信息存在到UTP平台上
    POST环境请求_UTP    {"env_name": "${TEST_ENV}","env_desc": "${TEST_ENV}环境","env_address": "${域名/IP}","env_port": "${端口}","db_info": "${数据库信息}","quenue_info": "${队列信息}","request_info": "${请求信息}"}
    #华锐网关连接
    Run Keyword If    '${接口类型}'=='Cash'    Connect_连接函数
    #数据库链接
    ${数据库信息_全局变量}    Set Variable    ${数据库信息}
    Set Global Variable    ${数据库信息_全局变量}
    数据库链接
    #KBSS数据信息
    ${fixpram_全局变量}    Replace String    ${请求信息}    ${/}    ${EMPTY}
    Set Global Variable    ${fixpram_全局变量}
    Comment    Close_连接关闭函数

POST接口下单请求_UTP数据银行
    [Arguments]    ${接口}    ${接口参数}    ${接口中文名称}=${EMPTY}    ${接口响应}=${EMPTY}    ${环境}=${TEST_ENV}    ${接口类型}=${接口类型_全局变量}    ${接口版本}=1.0.0    ${session}=${EMPTY}
    #创建session
    ${hearder}    Run Keyword IF    '${接口中文名称}'!='用户登录API'and '${接口类型}'=='Stk'    create dictionary    Content-Type=application/json    session=${session_全局变量}
    ...    ELSE    create dictionary    Content-Type=application/json
    create session    自定义POST请求    ${API地址["网址"]}    ${hearder}
    #接口调用
    log    ${接口中文名称}
    #根据不同系统传参不一样
    ${接口入参}    Run Keyword If    '${接口中文名称}'!='${EMPTY}' and '${接口类型}'=='Stk'    Set Variable    {"env": "${环境}","func_code": "${接口}","bus_type": "${接口类型}","bus_name": "${接口中文名称}","version": "${接口版本}","data": {${接口参数}}}
    ...    ELSE IF    '${接口中文名称}'!='${EMPTY}' and '${接口类型}'=='Cash'    set variable    {"env": "atp_${环境}","bus_id": "${接口}","bus_type": "${接口类型}","req_api": "${接口中文名称}","ans_api": "${接口响应}","version": "${接口版本}","data": ${接口参数}}
    ...    ELSE IF    '${接口中文名称}'=='${EMPTY}'    Set Variable    {"env": "${环境}","func_code": "${接口}","data": [{${接口参数}}]}
    log    ${接口入参}
    #格式转换
    ${接口入参}    evaluate    demjson.encode(${接口入参})    demjson
    Comment    ${接口入参}    Run Keyword If    '${接口类型}'!='Stk'    evaluate    json.dumps(${接口入参})    json
    ...    ELSE    set variable    ${接口入参}
    Comment    ${接口入参}    Run Keyword If    '${接口类型}'=='Stk'    evaluate    json.dumps(${接口入参})    json
    ...    ELSE    set variable    ${接口入参}    #将python对象编码成Json字符串
    log    ${接口入参}
    #选择后缀地址
    ${后缀}    Run Keyword If    '${接口中文名称}'!='${EMPTY}' and '${接口类型}'=='Stk'    set variable    ${API地址["金证api接口后缀"]}
    ...    ELSE IF    '${接口中文名称}'!='${EMPTY}' and '${接口类型}'=='Cash'    set variable    ${API地址["华锐api接口后缀"]}
    ...    ELSE IF    '${接口中文名称}'=='${EMPTY}'    Set Variable    ${API地址["金证柜台接口后缀"]}
    log    网址：${API地址["网址"]}${后缀}|入参：${接口入参}
    #请求
    Comment    ${resp}    Post Request    自定义POST请求    ${后缀}    data=${接口入参}
    ${resp}    POST On Session    自定义POST请求    ${后缀}    data=${接口入参}
    ${headers}    set variable    ${resp.headers}
    #格式处理
    log    ${resp}
    ${resp}    set variable    ${resp.json()}
    log    响应头：${headers}|数据：${resp}
    [Return]    ${resp}    ${headers}

GET环境请求_UTP
    [Arguments]    ${接口入参}    ${后缀}=${API地址["华锐api返回信息"]}
    #创建session
    ${hearder}    create dictionary    Content-Type=application/json
    create session    自定义POST请求    ${API地址["网址"]}    ${hearder}
    #接口调用
    Comment    ${接口入参}    create dictionary    env_name=${TEST_ENV}
    Comment    ${resp}    get Request    自定义POST请求    ${API地址["环境后缀"]}    params=${接口入参}
    log    网址：${API地址["网址"]}${后缀}|入参：${接口入参}
    Comment    ${resp}    get Request    自定义POST请求    ${后缀}    params=${接口入参}
    ${resp}    GET On Session    自定义POST请求    ${后缀}    params=${接口入参}
    #格式处理
    ${resp}    set variable    ${resp.json()}
    ${resp}    Set Variable    ${resp["data"][0]}
    log    ${resp}
    [Return]    ${resp}

POST环境请求_UTP
    [Arguments]    ${接口入参}    ${后缀}=${EMPTY}
    #创建session
    ${hearder}    create dictionary    Content-Type=application/json
    create session    自定义POST请求    ${API地址["网址"]}    ${hearder}
    #接口调用
    Comment    ${接口入参}    Set Variable    ${接口入参}
    ${后缀}    Run Keyword If    '${后缀}'=='${EMPTY}'    Set Variable    ${API地址["环境后缀"]}
    ...    ELSE IF    '${后缀}'!='${EMPTY}'    Set Variable    ${API地址["华锐环境后缀"]}
    log    网址：${API地址["网址"]}${后缀}|入参：${接口入参}
    Comment    ${resp}    Post Request    自定义POST请求    ${后缀}    data=${接口入参}
    #格式转换
    ${接口入参}    evaluate    demjson.encode(${接口入参} )    demjson
    ${resp}    POST On Session    自定义POST请求    ${后缀}    data=${接口入参}
    #格式处理
    ${resp}    set variable    ${resp.json()}
    log    ${resp}
    [Return]    ${resp}

数据库链接
    [Arguments]    ${接口类型}=${接口类型_全局变量}    ${数据库信息}=${数据库信息_全局变量}
    #数据库链接
    #SQL
    Comment    win版连接    Run Keyword If    '${接口类型}'=='Stk'    Connect To Database Using Custom Params    pyodbc    "Driver={SQL Server};${数据库信息}"
    Comment    linux版连接    Run Keyword If    '${接口类型}'=='Stk'    Connect To Database Using Custom Params    pyodbc    "Driver={ODBC Driver 11 for SQL Server};${数据库信息}"
    ${xt}    Evaluate    sys.platform    sys
    ${driver}    Set Variable IF    '${xt}'=='win32'    SQL Server    ODBC Driver 11 for SQL Server
    Run Keyword If    '${接口类型}'=='Stk'    Connect To Database Using Custom Params    pyodbc    "Driver={${driver}};${数据库信息}"
    #mysql
    Run Keyword If    '${接口类型}'=='Cash'    Connect To Database Using Custom Params    pymysql    ${数据库信息}
    #Oracel数据库连接_基准数据存储
    Run Keyword If    '${接口类型}'=='${EMPTY}'    Connect To Database Using Custom Params    cx_Oracle    'auto','auto','(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=10.138.2.239)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=autotest)))'

GET获取返回数据_华锐API
    [Arguments]    ${用户系统消息序号}
    #获取数据
    Comment    ${接口入参}    Create Dictionary    client_seq_id=${用户系统消息序号}
    FOR    ${i}    IN RANGE    10
        ${resp}    GET环境请求_UTP    client_seq_id=${用户系统消息序号}
        Run Keyword And Return Status    Run Keyword If    '${resp["reason"]}'=='None'    SLEEP    0.25
        Run Keyword And Return Status    Continue For Loop IF    '${resp["reason"]}'=='None'
        ${keys}    ${values}    ${reason}    类似字典类的字符串转换为字典    ${resp["reason"]}
        Run Keyword And Return Status    Exit For Loop If    '${reason["err_msg"]}'=='成功'
    END
    log    ${resp}
    log    ${resp["ack"]}
    log    ${resp["ans"]}
    华锐登录检查    ${resp}
    #判断正常单是否因环境问题导致下单错误
    ${keys}    ${values}    ${返回数据}    类似字典类的字符串转换为字典    ${resp["ack"]}
    #${ord_status}    Run Keyword If    '${resp["business_name"]}' in ('集中竞价交易委托函数','债券转股回售业务委托函数','配售业务委托函数','质押式回购集中竞价业务委托函数','ETF申赎业务委托函数','网上发行业务委托函数','盘后定价(科创板、创业板)业务委托函数')    Set Variable    ${返回数据["ord_status"]}
    #Run Keyword If    '${resp["business_name"]}' in ('集中竞价交易委托函数','债券转股回售业务委托函数','配售业务委托函数','质押式回购集中竞价业务委托函数','ETF申赎业务委托函数','网上发行业务委托函数','盘后定价(科创板、创业板)业务委托函数') and '${订单状态_全局变量}' not in ('废单')    Should Not Be Equal As Strings    ${ord_status}    8    ${订单状态_全局变量}用例订单状态为已拒绝，请检查环境！！
    #已申报和已拒绝不写ans
    ${数据}    Run Keyword If    '${resp["business_name"]}' in ('集中竞价交易委托函数','债券转股回售业务委托函数','配售业务委托函数','质押式回购集中竞价业务委托函数','ETF申赎业务委托函数','网上发行业务委托函数','盘后定价(科创板、创业板)业务委托函数','用户登录')    Set Variable    ${resp["ack"]}
    ...    ELSE    Set Variable    ${resp["ans"]}
    ${keys}    ${values}    ${返回数据}    类似字典类的字符串转换为字典    ${数据}
    log    ${返回数据}
    ${返回码}    Set Variable    ${reason["err_code"]}
    [Return]    ${返回码}    ${返回数据}
