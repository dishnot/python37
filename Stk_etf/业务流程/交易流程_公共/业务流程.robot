*** Settings ***
Resource          ../../公共目录/配置信息/环境配置信息.robot
Resource          1-初始化流程/普通买卖交易.robot
Resource          2-订单委托流程/订单下单流程.robot
Resource          3-检查点流程/普通买卖交易.robot
Resource          ../../公共目录/模式配置/sqltest模式关键字.robot

*** Keywords ***
普通交易委托流程
    [Arguments]    ${交易信息}    ${权限}=${EMPTY}
    环境信息查询与连接
    log    ---初始化
    普通买卖交易初始化流程    ${交易信息}    ${权限}
    log    ---委托
    普通买卖下单流程
    log    ---检查
    普通买卖交易检查流程

普通交易委托流程_备份
    [Arguments]    ${交易信息}    ${资金初始化}    ${股份初始化}    ${委托数量}    ${权限}=${EMPTY}
    用例名称转换为字典
    环境信息查询与连接
    账户信息_全局变量
    登录_Web
    获取客户信息
    获取证券信息    ${交易信息["证券代码"]}
    资金调整_web    1000
    股份调整_web    100    ${交易信息["证券代码"]}
    ReqCustLoginOther_账户登入函数
    ReqFundQuery_资金查询
    ReqShareQuery_股份查询    ${交易信息["证券代码"]}
    ReqCashAuctionOrder_现货委托交易    1    ${交易信息["证券代码"]}    a    211100    2300000    #221100    #230000
    ReqCancelOrder_通用撤单    ${订单编号_全局变量}
    ReqOrderQuery_订单查询    ${订单编号_全局变量}
    ReqTradeOrderQuery_成交查询    ${订单编号_全局变量}
    ReqOrderQuery_订单查询    ${订单编号_撤单_全局变量}
    ReqTradeOrderQuery_成交查询    ${订单编号_撤单_全局变量}
    Comment    ${系统类型}    Set Variable If    '${TEST_TYPE}'=='Stk'    普通交易_金证    普通交易_华锐
    Comment    Run Keyword    ${系统类型}    ${交易信息}    ${资金初始化}    ${股份初始化}    ${委托数量}    ${权限}

新股申购委托流程
    [Arguments]    ${交易信息}    ${委托数量}    ${权限}=${EMPTY}
    环境信息查询与连接
    log    ---初始化
    新股申购初始化流程    ${交易信息}    ${委托数量}    ${权限}
    log    ---委托
    普通买卖下单流程
    log    ---检查
    新股申购交易检查流程

买蓝委托流程
    环境信息查询与连接
    log    ---初始化
    用例名称转换为字典
    log    ---检查
    ${file_path}    sql文件匹配
    ${sqltest查询数据}    execute_sql_script_file    ${file_path}    True    True
    LOG    ${sqltest查询数据}
    ${数据数量}    Get Length    ${sqltest查询数据}
    ${b}    Set Variable    0
    FOR    ${i}    IN    @{sqltest查询数据}
        LOG    ${i}
        ${b}    Evaluate    ${b}+1
        Set To Dictionary    ${i}    number    ${b}
        sqltest委托入参数据处理    ${i}
        sqltest普通买卖初始化
        金证_普通买卖下单流程
        普通买卖交易检查流程
    END
    Disconnect From Database
