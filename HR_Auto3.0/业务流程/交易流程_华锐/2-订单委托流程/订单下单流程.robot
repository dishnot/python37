*** Settings ***
Resource          ../../../接口定义/华锐/交易接口.robot

*** Keywords ***
华锐_普通买卖下单流程
    [Arguments]    ${委托数量}=${委托数量_全局变量}    ${委托价格}=${委托价格_全局变量}    ${订单状态}=${订单状态_全局变量}    ${接口类型}=${接口类型_全局变量}    ${取证券业务}=${用例名称转换成字典}
    ${A}    Run Keyword if    '${取证券业务['证券业务']}' in '(100,101)'    ReqCashAuctionOrder_现货委托交易    ${委托数量}    ${委托价格}
    ...    ELSE IF    '${取证券业务['证券业务']}' in '(160,161)'    ReqSwapPutbackOrder_转股    ${委托数量}    ${委托价格}
    ...    ELSE IF    '${取证券业务['证券业务']}' in '(106,153)'    ReqRightslssueOrder_配售    ${委托数量}    ${委托价格}
    ...    ELSE IF    '${取证券业务['证券业务']}' == '165'    ReqRepoAuctionOrder_质押式回购    ${委托数量}    ${委托价格}
    ...    ELSE IF    '${取证券业务['证券业务']}' == '113'    ReqlssueOrder_网上发行    ${委托数量}    ${委托价格}
    ...    ELSE IF    '${取证券业务['证券业务']}' in '(181,182,187,188)'    ReqETFRedemptionOrder_ETF申赎    ${委托数量}    ${委托价格}
    log    ${A}
    Comment    ReqCashAuctionOrder_现货委托交易    1    ${交易信息["证券代码"]}    a    211100    2300000    #221100    #230000
    Run Keyword if    '${订单状态}' in ('部撤','全撤')    ReqCancelOrder_通用撤单    ${订单编号_全局变量}
    ${委托_撤单合同序号_全局变量}    Run Keyword if    '${订单状态}' in ('部撤','全撤')    Create Dictionary    委托=${订单编号_全局变量}    撤单=${订单编号_撤单_全局变量}
    ...    ELSE    Create Dictionary    委托=${订单编号_全局变量}    撤单=${EMPTY}
    ${委托_撤单申报合同号_全局变量}    Run Keyword if    '${订单状态}' in ('部撤','全撤')    Create Dictionary    委托=${申报合同号_全局变量}    撤单=${申报合同号_撤单_全局变量}
    ...    ELSE    Create Dictionary    委托=${申报合同号_全局变量}    撤单=${EMPTY}
    Set Global Variable    ${委托_撤单合同序号_全局变量}
    Set Global Variable    ${委托_撤单申报合同号_全局变量}
