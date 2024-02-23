*** Settings ***
Documentation     -v CUST_MODE:1P1 -v TEST_ENV:77 --metadata user:chenhui2
...               本实践基于metadata参数实现本地接口测试的上报及通知流程，以下是metadata在数据上报流程上的使用说明
...               1. --metadata \ user:xxxx \ \ \ 上报人，user的值为个人的AD域账号，不指定是，默认为system用户
...               2. --metadata \ branch:xxxx \ 上报工程的分支（当本地工程也使用gitlab进行管理时有效）
...               3. --metadata \ iteration:xxxx \ 上报的迭代或迭代号，指TAPD的迭代
...               4. --metadata \ project_id:xxxx \ 本地工程对应gitlab工程的项目ID。若不传，则默认以本地的工程名反向查询gitlab项目，若不存在，UTP记为0
...               5. --metadata \ send_email:1 \ --metadata \ relation_members:xxx \ \ 发送企信时使用，多个企信用户接收者，使用英文,符号隔开
...               6. 注意事项：强烈建议本地工程均使用gitlab进行管理，且该工程有在UTP上存在
...               华锐脚本接口自动化需获取token
