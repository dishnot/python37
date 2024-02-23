*** Settings ***
Library           RequestsLibrary
Resource          ../通用操作/常用关键字.robot
Library           DatabaseLibrary
Library           demjson

*** Variables ***
&{F4F9_API}       URL=http://api-gw-v2-restful.tsp-sit.10.171.7.248.nip.io/v1.0/    URIF4=CapitalService/    URIF9=ClientService/    #SIT测试环境
#&{F4F9_API}      URL=http://api-gw-test-v2.tsp.10.171.7.208.nip.io/v1.0/    URIF4=CapitalService/    URIF9=ClientService/    #测试开发环境
&{STOCK_API}      URL=http://zuul.mircroservice-dev.10.171.7.38.nip.io/v1.0/    URI_LR=FislStockService/    URI_JZ=StockService    #微服务环境
&{F1_API}         URL=http://api-gw-restful.tsp-uat.10.171.7.219.nip.io/v1.0/    URI=CapitalAPIService/
&{TDSQL}          数据库IP=10.171.5.8    数据库用户名=devuser    数据库密码=devuser@tsp    数据库端口=${3306}

*** Keywords ***
通过接口名取环境路径
    [Arguments]    ${接口属性}=${接口属性_全局变量}
    ${url}    Run Keyword If    '${接口属性}'=='F1'    Set Variable    ${F1_API["URL"]}${F1_API["URI"]}
    ...    ELSE IF    '${接口属性}'=='F4'    Set Variable    ${F4F9_API["URL"]}${F4F9_API["URIF4"]}
    ...    ELSE IF    '${接口属性}'=='F9'    Set Variable    ${F4F9_API["URL"]}${F4F9_API["URIF9"]}
    [Return]    ${url}

通过对接系统取环境路径
    [Arguments]    ${对接系统}=${测试系统_全局变量}
    ${url}    Run Keyword If    '${对接系统}'=='WFW'    Set Variable    ${STOCK_API["URL"]}${STOCK_API["URI_JZ"]}
    ...    ELSE IF    '${对接系统}'=='LR'    Set Variable    ${STOCK_API["URL"]}${STOCK_API["URI_LR"]}
    [Return]    ${url}

TDSQL数据库连接
    ${数据库信息}    Set Variable    host='${TDSQL["数据库IP"]}',port=${TDSQL["数据库端口"]},user='${TDSQL["数据库用户名"]}',password='${TDSQL["数据库密码"]}'
    Run Keyword    Connect To Database Using Custom Params    pymysql    ${数据库信息}

关闭数据库操作
    ${数据库信息}    Set Variable    host='${TDSQL["数据库IP"]}',port=${TDSQL["数据库端口"]},user='${TDSQL["数据库用户名"]}',password='${TDSQL["数据库密码"]}'
    ${conn}=    Connect To Database Using Custom Params    pymysql    ${数据库信息}
    Close Database Connection    ${conn}
