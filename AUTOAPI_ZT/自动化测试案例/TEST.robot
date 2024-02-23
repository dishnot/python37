*** Test Cases ***
TEST1
    ${num1}=    Set Variable    122023091400000035
    ${num2}=    Set Variable    122023091400000036
    ${num2}    evaluate    type(${num2})
    Should Be Equal As Strings    ${num1}    ${num2}
