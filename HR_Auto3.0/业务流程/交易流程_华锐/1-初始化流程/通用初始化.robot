*** Settings ***
Resource               ../../../接口定义/华锐/初始化接口.robot

*** Keywords ***
华锐_客户与证券信息查询
         登录_Web
         获取客户信息_web
         获取证券信息_web
         交易参考信息设置_web
