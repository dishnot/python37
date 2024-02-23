*** Settings ***
Default Tags      STK
Resource          ../业务流程/TSP接口测试.robot
Resource          ../业务流程/http通用检查点.robot
Resource          ../接口定义/中台/F1接口.robot
Resource          ../接口定义/中台/F4接口.robot
Resource          ../接口定义/中台/F9接口.robot

*** Test Cases ***
F400001_F4_资金查询_STK_NONE
    TSP接口测试

F900201_F9_资金查询_STK_NONE
    TSP接口测试

F900202_F9_资金划拨_STK_2
    TSP接口测试

F900202_F9_资金划拨_STK_1
    TSP接口测试

F400002_F4_资金划拨_STK_1
    TSP接口测试

F400002_F4_资金划拨_STK_2
    TSP接口测试

F900203_F9_双中心资金划拨_STK_0
    TSP接口测试    10

F900203_F9_双中心资金划拨_STK_1
    TSP接口测试    400

F400003_F4_双中心资金划拨_STK_0
    TSP接口测试    400

F400003_F4_双中心资金划拨_STK_1
    TSP接口测试    400

F900204_F9_双中心资金划拨_STK_2
    TSP接口测试

F900204_F9_双中心资金划拨_STK_1
    TSP接口测试

F400004_F4_双中心资金划拨_STK_2
    TSP接口测试

F400004_F4_双中心资金划拨_STK_1
    TSP接口测试

F900000_F9_客户登录_STK_NONE
    TSP接口测试
