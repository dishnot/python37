*** Settings ***
Library           SSHLibrary

*** Variables ***
${HOST}           10.138.1.185
${USERNAME}       root
${PASSWORD}       TestTeam@1234

*** Keywords ***
连接
    # 建立SSH连接
    Open Connection    ${HOST}
    Login    ${USERNAME}    ${PASSWORD}

执行指令
    ${output1}    Execute Command    cd /usr/local/lib/python3.7/site-packages/maTrade&&./clear_shm.sh
    ${output2}    Execute Command    cd /opt/.autotest_platform_prd/&&./celery_matrade.sh
    Log    ${output1}
    Log    ${output2}

关闭连接
    # 关闭SSH连接
    Close All Connections

185环境清除信号量重启软加速进程操作
    连接
    执行指令
    关闭连接
