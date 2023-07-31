*** Settings ***
Library  SeleniumLibrary

Documentation    Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}      https://scouts-test.futbolkolektyw.pl/en
${BROWSER}        Chrome
${SIGNINBUTTON}     xpath=//*[@type='submit']
${EMAILINPUT}    xpath=//*[@id='login']
${PASSWORDINPUT}        xpath=//*[@id='password']
${PAGELOGO}     xpath=//div[3]/div[1]/div/div[1]
${ADDPLAYERBUTTON}      xpath=//*[text()='Add player']
${NAMEINPUT}        xpath=//*[@name='name']
${SURNAMEINPUT}     xpath=//*[@name='surname']
${AGEINPUT}     xpath=//*[@name='age']
${POSITIONINPUT}        xpath=//*[@name='mainPosition']
${SUBMITBUTTON}     xpath=//*[@type='submit']
${NEWPLAYER}        xpath=//*[text()='Edit player Jan Nowak']
${SIGNOUTBUTTON}        xpath=//*[text()='Sign out']
${TITLE}        xpath=//h5
${PLAYERSBUTTON}        xpath=//*[text()='Players']
${PLAYER}       xpath=//*[@id="MUIDataTableBodyRow-0"]/td[1]
${NAME}     xpath=//th[1]/span/button/span[1]/div/div[1]
${NOTIFICATIONBOX}      xpath=//*[@role='alert']
${NOTIFICATIONTEXT}     xpath=//*[text()='Saved player.']
${MATCHESBUTTON}        xpath=//ul[2]/div[2]/div[2]/span
${ADDMATCH}     xpath=//main/a/button/span[1]
${ADDPLAYERHEADER}     xpath=//form/div[1]/div/span
${ENGLISHBUTTON}        xpath=//*[text()='English']
${POLSKIBUTTON}     xpath=//*[text()='Polski']
${ENGLISHTEXT}      xpath=//*[text()='Activity']
${POLISHTEXT}       xpath=//*[text()='Gracze']

*** Test Cases ***
Login to the system
    Open login page
    Type in email
    Type in password
    Click on the Sign in button
    Assert dashboard
    [Teardown]    Close Browser

Filling the form Dodaj Gracza
    Open login page
    Type in email
    Type in password
    Click on the Sign in button
    Assert dashboard
    Click on the Add Player button
    Assert Add a player
    Type in Name
    Type in Surname
    Type in Age
    Type in Main position
    Click on the Submit button
    Assert adding a new player
    [Teardown]    Close Browser

Sign out of the system
    Open login page
    Type in email
    Type in password
    Click on the Sign in button
    Assert dashboard
    Click on the Sign out button
    Assert title
    [Teardown]    Close Browser

Editing information of an existing player
    Open login page
    Type in email
    Type in password
    Click on the Sign in button
    Assert dashboard
    Click on the Players button
    Assert Players
    Select any player from the list
    Type In Name new text
    Click On The Submit Button
    Assert edit a player
    [Teardown]    Close Browser

List of matches played by the selected player
    Open login page
    Type in email
    Type in password
    Click on the Sign in button
    Assert dashboard
    Click on the Players button
    Assert Players
    Select any player from the list
    Click on the Matches button
    Assert Matches
    [Teardown]    Close Browser

Page Translations
    Open login page
    Type in email
    Type in password
    Click on the Sign in button
    Assert dashboard
    Click On The Polski Button
    Assert Polish Version
    Click On The English Button
    Assert English Version
    [Teardown]    Close Browser

*** Keywords ***
Open login page
    Open Browser    ${LOGIN URL}     ${BROWSER}
    Maximize Browser Window
    Title Should Be  Scouts panel - sign in
Type in email
    Input Text   ${EMAILINPUT}   user02@getnada.com
Type in password
    Input Text    ${PASSWORDINPUT}      Test-1234
Click on the Sign in button
    Click Element   xpath=//*[@type='submit']
Assert dashboard
    Wait Until Element Is Visible    ${PAGELOGO}
    Title Should Be    Scouts panel
    Capture Page Screenshot  screenshots/login/dashboard-start.png
Click on the Add Player button
    Click Element   xpath=//*[text()='Add player']
Type in Name
    Input Text    ${NAMEINPUT}      Jan
Type in Surname
    Input Text    ${SURNAMEINPUT}   Nowak
Type in Age
    Input Text    ${AGEINPUT}   2142002
Type in Main position
    Input Text    ${POSITIONINPUT}  attacker
Click on the Submit button
    Click Element    xpath=//*[@type='submit']
Assert adding a new player
    Wait Until Page Contains Element    xpath=//*[text()='Edit player Jan Nowak']
    Title Should Be    Edit player Jan Nowak
    Capture Page Screenshot    screenshots/add-player/new-player.png
Click on the Sign out button
    Click Element    xpath=//*[text()='Sign out']
Assert title
    Wait Until Element Is Visible   ${TITLE}
    Title Should Be    Scouts panel - sign in
    Capture Page Screenshot     screenshots/login/login-page.png
Click on the Players button
    Click Element    xpath=//*[text()='Players']
Select any player from the list
    Click Element    //*[@id="MUIDataTableBodyRow-0"]/td[1]
Type In Name new text
    Input Text    ${NAMEINPUT}  test
Assert edit a player
    Wait Until Page Contains Element    xpath=//*[@role='alert']
    Wait Until Element Is Visible   ${NOTIFICATIONTEXT}
    Capture Page Screenshot    screenshots/player-page/edit-player.png
Assert Players
    Wait Until Page Contains Element   xpath=//th[1]/span/button/span[1]/div/div[1]
Click on the Matches button
    Click Element   xpath=//ul[2]/div[2]/div[2]/span
Assert Matches
    Wait Until Page Contains Element   xpath=//main/a/button/span[1]
    Capture Page Screenshot    screenshots/player-page/matches-page.png
Assert Add a player
    Wait Until Page Contains Element    xpath=//form/div[1]/div/span
Click on the English button
    Click Element   xpath=//*[text()='English']
Assert English version
    Wait Until Element Is Visible   ${ENGLISHTEXT}
    Capture Page Screenshot     screenshots/dashboard/english-version.png
Click on the Polski button
    Click Element   xpath=//*[text()='Polski']
Assert Polish version
    Wait Until Element Is Visible    ${POLISHTEXT}
    Capture Page Screenshot     screenshots/dashboard/polish-version.png
