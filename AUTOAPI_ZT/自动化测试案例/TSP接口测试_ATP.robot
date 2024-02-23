*** Settings ***
Default Tags      ATP
Resource          ../业务流程/TSP接口测试.robot
Resource          ../业务流程/http通用检查点.robot
Resource          ../接口定义/中台/F1接口.robot
Resource          ../接口定义/中台/F4接口.robot
Resource          ../接口定义/中台/F9接口.robot

*** Test Cases ***
F900201_F9_资金查询_ATP_NONE
    TSP接口测试

F900202_F9_增强资产查询_ATP_2
    TSP接口测试

F900202_F9_外部实时资产查询_ATP_1
    TSP接口测试

F900203_F9_双中心资金划拨_ATP_0
    TSP接口测试

F900203_F9_双中心资金划拨_ATP_1
    TSP接口测试

F900204_F9_双中心资金划拨_ATP_1
    TSP接口测试

F900205_F9_双中心资金划拨_ATP_2
    TSP接口测试

F900000_F9_客户登录_ATP_NONE
    TSP接口测试
