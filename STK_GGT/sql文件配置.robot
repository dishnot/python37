*** Settings ***
Library           RequestsLibrary
Library           DatabaseLibrary
Library           demjson
Library           String
Library           Collections
Library           DateTime
Library           OperatingSystem

*** Variables ***
&{209}            数据库=10.138.1.211    数据库名称=kbss_stds_209    数据库用户名称=sa    数据库密码=zt@1234    数据库端口=1433
&{125}            数据库=10.171.9.5    数据库名称=kbss_stds_fsl    数据库用户名称=sa    数据库密码=zt@1234    数据库端口=1433
&{33}             数据库=10.171.9.13    数据库名称=kbss_stds_33    数据库用户名称=sa    数据库密码=zt@1234    数据库端口=1433
&{47}             数据库=10.138.1.68    数据库名称=kbss_stds_47    数据库用户名称=sa    数据库密码=zt@1234    数据库端口=1433
&{66}             数据库=10.138.1.68    数据库名称=kbss_stds    数据库用户名称=sa    数据库密码=zt@1234    数据库端口=1433

*** Keywords ***
数据库连接
    ${环境}    Run Keyword If    '${TEST_ENV}'=='209'    Set Variable    ${209}
    ...    ELSE IF    '${TEST_ENV}'=='125'    Set Variable    ${125}
    ...    ELSE IF    '${TEST_ENV}'=='33'    Set Variable    ${33}
    ...    ELSE IF    '${TEST_ENV}'=='47'    Set Variable    ${47}
    ...    ELSE IF    '${TEST_ENV}'=='66'    Set Variable    ${66}
    ${数据库信息}    Set Variable    Server=${环境["数据库"]};Port=${环境["数据库端口"]};Database=${环境["数据库名称"]};UID=${环境["数据库用户名称"]};PWD=${环境["数据库密码"]}
    ${xt}    Evaluate    sys.platform    sys
    ${driver}    Set Variable IF    '${xt}'=='win32'    SQL Server    ODBC Driver 11 for SQL Server
    Run Keyword    Connect To Database Using Custom Params    pyodbc    "Driver={${driver}};${数据库信息}"

sql文件匹配
    [Arguments]    ${文件名}=${用例首字段}
    log    ${CURDIR}
    LOG    ${EXECDIR}
    ${xt}    Evaluate    sys.platform    sys
    ${路径}    Run KeyWord If    '${目录}'=='深港通委托成功'    Set Variable    深港通
    ...    ELSE IF    '${目录}'=='沪港通委托成功'    Set Variable    沪港通
    ...    ELSE IF    '${目录}'=='深港通委托异常'    Set Variable    深港通_异常
    ...    ELSE IF    '${目录}'=='沪港通委托异常'    Set Variable    沪港通_异常
    ${后缀}    Run Keyword If    '${订单状态}' in ('已报','全撤')    Set Variable    已报
    ...    ELSE IF    '${订单状态}' in ('部成','部撤')    Set Variable    部成
    ...    ELSE    Set Variable    ${订单状态}
    ${sql文件目录}    Run Keyword If    '${目录}' in ('沪港通委托成功','深港通委托成功')    Set Variable    ${路径}_${后缀}
    ...    ELSE IF    '${目录}' in ('深港通委托异常','沪港通委托异常')    Set Variable    ${路径}
    ${sql文件名}    Run Keyword If    '${目录}' in ('沪港通委托成功','深港通委托成功')    Set Variable    ${文件名}${后缀}.sql
    ...    ELSE IF    '${目录}' in ('深港通委托异常','沪港通委托异常')    Set Variable    ${文件名}.sql
    ${file_path}    Set Variable IF    '${xt}'=='win32'    ${EXECDIR}\\${sql文件目录}\\${sql文件名}    ${EXECDIR}/${sql文件目录}/${sql文件名}
    [Return]    ${file_path}

用例模式
    log    ${TEST_NAME}
    ${用例名称转换成List}    Split String    ${TEST_NAME}    _
    ${用例名称提取}    Set Variable    ${用例名称转换成List[0]}
    ${用例名称提取1}    Set Variable    ${用例名称转换成List[1]}
    ${用例名}    Set Variable    ${用例名称转换成List[2]}
    ${订单状态}    Set Variable    ${用例名称转换成List[3]}
    log    ${用例名称提取}
    ${用例首字段}    Set Variable    ${用例名称提取}
    ${目录}    Set Variable    ${用例名称提取1}
    Set Global Variable    ${用例首字段}
    Set Global Variable    ${目录}
    Set Global Variable    ${用例名}
    Set Global Variable    ${订单状态}
