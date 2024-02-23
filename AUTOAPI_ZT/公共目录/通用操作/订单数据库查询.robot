*** Settings ***
Resource          ../../公共目录/配置信息/环境配置信息.robot

*** Keywords ***
表
    @{资金表}    Query    SELECT * \ FROM CUACCT_FUND
