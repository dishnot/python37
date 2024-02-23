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
    ${output1}    Execute Command    ls -l
    ${output2}    Execute Command    ls -l
    Log    ${output1}
    Log    ${output2}

关闭连接
    # 关闭SSH连接
    Close All Connections
