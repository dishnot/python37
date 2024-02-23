*** Settings ***
Resource          ../../交易流程_公共/3-检查点流程/公共/计算该笔委托的值_取值计算录制模式.robot
Resource          ../../交易流程_公共/3-检查点流程/公共/接口与表_比对模式.robot
Resource          ../../交易流程_公共/3-检查点流程/公共/接口与表_录制模式.robot

*** Keywords ***
金证_普通买卖检查流程
    ${调用接口}    Create List    可用资金查询_10303001    当日委托查询_10303003    当日成交查询_10303004
    log    ----------比对
    Run Keyword And Continue On Failure    查询接口与表比对的通用流程    ${调用接口}
    log    ----------取值计算录制
    ${变化数据}    Create List    可用资金查询_10303001    CUACCT_FUND
    Run Keyword And Continue On Failure    查询接口与表取值计算录制的通用流程    ${变化数据}
    log    ----------取值录制
    ${录制数据}    Create List    当日委托查询_10303003    当日成交查询_10303004    STK_ORDER    STK_MATCHING    STK_ORDER_DETAIL
    Run Keyword And Continue On Failure    查询接口与表取值录制的通用流程    ${录制数据}
    log    -----------------全表录制
    ${录制全数据}    Create List    可用资金_10303001_全接口字段    可用股份_10303002_全接口字段    CUACCT_FUND全表字段    STK_ASSET全表字段
    Run Keyword And Continue On Failure    查询接口与表全录制的通用流程    ${录制全数据}

金证_新股申购检查流程
    ${调用接口}    Create List    当日委托查询_10303003
    log    ----------取值录制
    ${录制数据}    Create List    当日委托查询_10303003    STK_ORDER
    Run Keyword And Continue On Failure    查询接口与表取值录制的通用流程    ${录制数据}

金证_篮子委托检查流程
    ${录制数据}    Create List    当日委托查询_10303003    当日成交查询_10303004    STK_ORDER    STK_MATCHING    STK_ORDER_DETAIL
    Run Keyword And Continue On Failure    查询接口与表取值录制的通用流程    ${录制数据}
    log    -----------------全表录制
    ${录制全数据}    Create List    可用资金_10303001_全接口字段    可用股份_10303002_全接口字段    CUACCT_FUND全表字段    STK_ASSET全表字段
    Run Keyword And Continue On Failure    查询接口与表全录制的通用流程    ${录制全数据}
