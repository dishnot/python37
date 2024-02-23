*** Settings ***
Default Tags      WFW
Resource          ../业务流程/TSP接口测试.robot
Resource          ../业务流程/http通用检查点.robot
Resource          ../接口定义/中台/F1接口.robot
Resource          ../接口定义/中台/F4接口.robot
Resource          ../接口定义/中台/F9接口.robot

*** Test Cases ***
F900201_F9_502_WFW_NONE
    TSP接口测试
