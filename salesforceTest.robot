# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Main Script
    # [tags]                    Lead
    Home
    GoTo                      ${login_url}/lightning/setup/SetupOneHome/home
    # Step 1
    TypeText                  Quick Find                  all sites\n
    ClickText                 All Sites
    ClickText                 Builder                     anchor=Customer Support
    SwitchWindow              2
    ${popup}                  IsText                      What's New
    Run Keyword If            ${popup}                    ClickText                   OK
    VerifyText                Publish

    # Step 2
    ClickItem                 Page Structure
    ClickItem                 Delete                      anchor=Embedded Messaging                               partial_match=False
    ClickText                 Delete                      anchor=Cancel               partial_match=False
    VerifyNoText              Embedded Messaging

    # Step 3
    ClickText                 Publish
    VerifyText                Publish your site?          timeout=60
    ClickText                 Publish                     anchor=Cancel
    VerifyText                Got It                      timeout=60
    ClickText                 Got It
    CloseWindow
    SwitchWindow              1
    # RefreshPage
    # Step 4
    # Iteration for Merchant Support Experience
    ClickText                 Builder                     anchor=Merchant Support
    SwitchWindow              2
    ${popup}                  IsText                      What's New
    Run Keyword If            ${popup}                    ClickText                   OK
    VerifyText                Publish

    # Step 4.2
    ClickItem                 Page Structure
    ClickItem                 Delete                      anchor=Embedded Messaging                               partial_match=False
    ClickText                 Delete                      anchor=Cancel               partial_match=False
    VerifyNoText              Embedded Messaging

    # Step 4.3
    ClickText                 Publish
    VerifyText                Publish your site?          timeout=60
    ClickText                 Publish                     anchor=Cancel
    VerifyText                Got It                      timeout=60
    ClickText                 Got It
    CloseWindow
    SwitchWindow              1

    # Step 4-again
    TypeText                  Quick Find                  my domain\n
    ClickText                 My Domain
    ${orgDomain}              GetText                     //table[@class\="detailList"]                           between=Domain Name???Domain Suffix
    # Log To Console          ${orgDomain}

    # Step 5
    TypeText                  Quick Find                  cors
    ClickText                 CORS
    # Step 6
    ClickText                 Edit                        anchor=pronto21
    TypeText                  Origin URL Pattern          https://${orgDomain}
    ClickText                 Save                        partial_match=False
    VerifyText                Allowed Origins List
    # Step 7
    TypeText                  Quick Find                  trusted urls
    ClickText                 Trusted URLs                partial_match=False
    # Pronto21
    ClickText                 Edit                        anchor=Pronto21
    TypeText                  URL                         https://${orgDomain}.my.salesforce-scrt.com
    ClickText                 Save                        partial_match=False
    # ProntoSite
    ClickText                 Edit                        anchor=ProntoSite
    TypeText                  URL                         https://${orgDomain}.my.site.com
    ClickText                 Save                        partial_match=False
    VerifyText                https://${orgDomain}.my.salesforce-scrt.com
    VerifyText                https://${orgDomain}.my.site.com
    # Step 8
    TypeText                  Quick Find                  messaging setting
    ClickText                 Messaging Settings          partial_match=False
    ClickCheckbox             MessagingOnOff              on
    VerifyCheckboxValue       MessagingOnOff              on
    # Step 9
    TypeText                  Quick Find                  einstein setup
    ClickText                 Einstein Setup              partial_match=False


    ClickCheckbox             Turn on EinsteinOnOff       on
    VerifyText                Einstein is on.

    # Step 10, 11, 12, 13
    FOR                       ${i}                        IN RANGE                    50                          # Will try 10 times
        TypeText              Quick Find                  agent                       # Types "agent" in search field
        ${status}=            Run Keyword And Return Status                           VerifyText                  Agents                 timeout=5
        Return From Keyword If                            ${status}                   # Exit if text is found

        RefreshPage
        Sleep                 5
    END
    ClickText                 Agents
    VerifyText                Get to Know Agent
    ClickCheckbox             Basic optionOnOff           on
    Sleep                     30
    RefreshPage

    Usetable                  Agent Name
    VerifyText                Agentforce (Default)
    VerifyText                Customer Support Service Agent
    VerifyText                Merchant Support Agent
    VerifyText                Restaurant Manager



    ClickText                 Show actions                anchor=Agentforce (Default)
    ClickText                 Edit
    ClickText                 Open in Builder
    VerifyText                Put your topics to the test

    ${activate_present}       IsText                      Activate
    IF                        ${activate_present}
        ClickText             Activate
        VerifyText            Deactivate
    END

    ClickItem                 Back
    ClickText                 Show actions                anchor=Customer Support Service Agent
    ClickText                 Edit
    ClickText                 Open in Builder
    VerifyText                Put your topics to the test

    ${activate_present}       IsText                      Activate
    IF                        ${activate_present}
        ClickText             Activate
        VerifyText            Deactivate
    END


    ClickItem                 Back

    ClickText                 Show actions                anchor=Merchant Support Agent
    ClickText                 Edit
    ClickText                 Open in Builder
    VerifyText                Put your topics to the test

    ${activate_present}       IsText                      Activate
    IF                        ${activate_present}
        ClickText             Activate
        VerifyText            Deactivate
    END


    ClickItem                 Back

    ClickText                 Show actions                anchor=Restaurant Manager
    ClickText                 Edit
    ClickText                 Open in Builder
    VerifyText                Put your topics to the test

    ${activate_present}       IsText                      Activate
    IF                        ${activate_present}
        ClickText             Activate
        VerifyText            Deactivate
    END



    ClickItem                 Back


    #Step 14
    TypeText                  Quick Find                  einstein bots
    ClickText                 Einstein Bots               partial_match=False
    ClickCheckbox             Einstein Bots               on
    VerifyCheckboxValue       Einstein Bots               on
    # Step 15
    TypeText                  Quick Find                  embedded service deployments
    ClickText                 Embedded Service Deployments                            partial_match=False
    
    
    # Step 16
    # GetTextCount              Show
    UseTable                  Deployment Type
    ClickCell                 r1c5
    ClickText   Delete               anchor=View  
    ClickText   Delete               anchor=Cancel  
    VerifyText                       was deleted
    RefreshPage
    UseTable                        Deployment Type
    ClickCell    r1c5  
    ClickText   Delete               anchor=View  
    Clicktext                        Delete                        anchor=Cancel
    VerifyText                       was deleted
    # Step 17
    ClickText    New Deployment
    UseModal    On
    ClickText    Messaging for In-App and WebPersistent conversations via an embedded window on your mobile app or website.Selected
    ClickText    Next
    ClickText    WebWebWeb deployment selected
    ClickText    Next
    TypeText    *Embedded Service Deployment Name    Customer Support
    TypeText    Example: yourcompany.com             input_text=${orgDomain}.my.site.com


    VerifyText                        *Messaging Channel           timeout=3
    TypeText    *Messaging Channel    customer support agent
    ClickText    Customer Support Agent    anchor=User
    VerifyText                      Save
    
    ClickText    Save
    VerifyNoText    Hang tight...          timeout=120
    VerifyText    Branding
    #Step 18
    

    ClickText    Publish
    #VerifyText    We're 
    ${timeNow}    Get Current Date       result_format=%m/%d/%Y, %I:%M:%S
    Log To Console                       ${timeNow}
    ${eighthrsAgo}                        Subtract Time From Date     ${timeNow}   08:00             date_format=%m/%d/%Y, %I:%M:%S             result_format=%m/%d/%Y, %I:%M:%S
    # ${delta}                        Subtract Date From Date           ${timeNow}                     ${eighthrsAgo}       date1_format=%m/%d/%Y, %I:%M:%S  date2_format=%m/%d/%Y, %I:%M:%S  result_format=%m/%d/%Y, %I:%M:%S                  
    ${todayDate}                        Get Current Date              result_format=%-m/%-d/%Y
    VerifyText    Published on: ${todayDate}

    FOR    ${attempt}    IN RANGE    20
        ${message_present}   IsText    After you activate
        Exit For Loop If    not ${message_present}
        RefreshPage
        Sleep    30s
    END
    VerifyText              Test your custom messaging experience in a Visualforce page.
    
    ClickText              Test Messaging             anchor=3                     
    SwitchWindow           2
    VerifyText    Test Your Messaging Deployment

    # step 20

    ClickItem     Hello, have a
    VerifyText    Hi, I'm an AI service assistant. How can I help you?             timeout=40

    CloseWindow
    SwitchWindow              1
    # Step 21
    TypeText                  Quick Find                  all sites
    ClickText                 All Sites                   

    ClickText                 Builder                     anchor=Customer Support
    SwitchWindow              2
    ${popup}                  IsText                      What's New
    Run Keyword If            ${popup}                    ClickText                   OK
    VerifyText                Publish
    # Step 22
    ClickItem                 Components
    DragDrop                  Embedded Messaging          HTML Editor                 dragtime=2.0
    Sleep                     60
    # Step 23
    ClickText                 Publish
    VerifyText                Publish your site?          timeout=60
    ClickText                 Publish                     anchor=Cancel
    VerifyText                Got It                      timeout=60
    ClickText                 Got It
    CloseWindow
    SwitchWindow              1


    # SECOND ITERATION
    # Step 15
    TypeText                  Quick Find                  embedded service deployments
    ClickText                 Embedded Service Deployments                            partial_match=False
    
    
    # Step 16
    # GetTextCount              Show
    # UseTable                  Deployment Type
    # ClickCell                 r1c5
    # ClickText   Delete               anchor=View  
    # ClickText   Delete               anchor=Cancel  
    # VerifyText                       was deleted
    # RefreshPage
    # UseTable                        Deployment Type
    # ClickCell    r1c5  
    # ClickText   Delete               anchor=View  
    # Clicktext                        Delete                        anchor=Cancel
    # VerifyText                       was deleted
    # Step 17
    ClickText    New Deployment
    UseModal    On
    ClickText    Messaging for In-App and WebPersistent conversations via an embedded window on your mobile app or website.Selected
    ClickText    Next
    ClickText    WebWebWeb deployment selected
    ClickText    Next
    TypeText    *Embedded Service Deployment Name    Merchant Agent
    TypeText    Example: yourcompany.com             input_text=${orgDomain}.my.site.com


    VerifyText                        *Messaging Channel           timeout=3
    TypeText    *Messaging Channel    merchant support agent
    ClickText    Merchant Support Agent    anchor=User
    VerifyText                      Save
    
    ClickText    Save
    VerifyNoText    Hang tight...          timeout=120
    VerifyText    Branding
    #Step 18
    

    ClickText    Publish
    Sleep        30
    #VerifyText    We're processing
    ${timeNow}    Get Current Date       result_format=%m/%d/%Y, %I:%M:%S
    Log To Console                       ${timeNow}
    ${eighthrsAgo}                        Subtract Time From Date     ${timeNow}   08:00             date_format=%m/%d/%Y, %I:%M:%S             result_format=%m/%d/%Y, %I:%M:%S
    # ${delta}                        Subtract Date From Date           ${timeNow}                     ${eighthrsAgo}       date1_format=%m/%d/%Y, %I:%M:%S  date2_format=%m/%d/%Y, %I:%M:%S  result_format=%m/%d/%Y, %I:%M:%S                  
    ${todayDate}                        Get Current Date              result_format=%-m/%-d/%Y
    #VerifyText    Published on: ${todayDate}
    Log To Console                      ${message_present}
    FOR    ${attempt}    IN RANGE    40
        ${message_present}   IsText    After you activate
        Exit For Loop If    not ${message_present}
        RefreshPage
        Sleep    30s
    END
    VerifyText              Test your custom messaging experience in a Visualforce page.
    # SwitchWindow            1
    ClickText              Test Messaging             anchor=3                     
    SwitchWindow           2
    VerifyText    Test Your Messaging Deployment

    # step 20

    ${isNotExpanded}          IsItem                     Minimize Chat Window
    Run Keyword If  ${isNotExpanded}  ClickItem     Expand the chat window
    VerifyText    Hi, I'm an AI service assistant. How can I help you?

    CloseWindow
    SwitchWindow              1
    # Step 21
    TypeText                  Quick Find                  all sites
    ClickText                 All Sites                   

    ClickText                 Builder                     anchor=Merchant Support
    SwitchWindow              2
    ${popup}                  IsText                      What's New
    Run Keyword If            ${popup}                    ClickText                   OK
    VerifyText                Publish
    # Step 22
    ClickItem                 Components
    DragDrop                  Embedded Messaging          HTML Editor                 dragtime=2.0
    Sleep                     60
    # Step 23
    ClickText                 Publish
    VerifyText                Publish your site?          timeout=60
    ClickText                 Publish                     anchor=Cancel
    VerifyText                Got It                      timeout=60
    ClickText                 Got It
    CloseWindow
    SwitchWindow              1

    # Data Cloud Setup
    # Step 1
    GoTo                      ${data_cloud_setup_url}
    ClickText                 Get Started
    FOR    ${attempt}    IN RANGE    80
        ${message_present}   IsText    Automated Steps
        Exit For Loop If    not ${message_present}
        RefreshPage
        Sleep    30s
    END
    VerifyText              View Home Org Details
    
    # Step 2
    TypeText    Quick Find    Permission Sets
    ClickText    Permission Sets
    ClickText    Data Cloud User
    ClickText    Manage Assignments
    ClickText    Add Assignments
    ClickItem    checkbox     merchant_support
    ClickItem    checkbox     agentforce_service
    ClickItem    checkbox     restaurant
    ClickText    Assign
    ClickText    Done
    # Step 3
    Home
    GoTo                    ${login_url}/packaging/installPackage.apexp?p0\=04tWs000000Mgrp
    ClickText    All
    ClickText    Install
    VerifyText    Installation Complete!                  timeout=40
    ClickText    Done
    
    # Step 4a
    GoTo                      ${data_cloud_setup_url}
    ClickText                 Other Connectors

    ClickText    New    anchor=Refresh
    ClickText    Amazon S3Retrieve a file from Amazon Simple Storage Service
    ClickText    Next
    TypeText    Enter Bucket Name    pronto-food-delivery
    TypeSecret    Enter AWS access key.    enter key
    TypeSecret    Enter AWS secret access key.   enter secret
    TypeText    Enter connection name...    Pronto AWS Creds
    ClickText    Save
    # Step 4b
    LaunchApp                  Data Cloud
    ClickText                  Data Streams
    ClickText                  New
    UseModal                   on
    ClickText                  Salesforce CRM
    ClickText                  Next
    ClickText                  Pronto_Salesforce_Contacts        timeout=40
    ClickText                  Next
    Sleep                      10
    ClickText                  Next
    Sleep                      10
    ClickText                  Deploy
    #Sleep                      30
    VerifyNoText               New Data Stream                   timeout=40
    UseModal                   off
    # Step 4c1
    ClickText                  Data Streams
    ClickText                  New
    UseModal                   on
    
    
    ClickText    Amazon S3Retrieve a file from Amazon Simple Storage Service
    ClickText    Next    anchor=Select your Amazon S3 connection and choose your object(s).
    TypeText    *File Name    pronto_customers.csv
    TypeText    Import from Directory    data
    ClickText    Next    anchor=Select your Amazon S3 connection and choose your object(s).
    TypeText    *Data Lake Object Label    AWS S3 Pronto Customers
    ClickText    Select an Option    anchor=*Primary Key
    ClickText    Customer_ID    anchor=New Data Stream
    ClickText    Next    anchor=New Data Stream - Stage Not Started
    ClickText    Deploy         timeout=40
    VerifyNoText               New Data Stream                   timeout=40
    UseModal     off
    # Step 4c2
    ClickText                  Data Streams
    ClickText                  New
    UseModal                   on
    
    
    ClickText    Amazon S3Retrieve a file from Amazon Simple Storage Service
    ClickText    Next    anchor=Select your Amazon S3 connection and choose your object(s).
    TypeText    *File Name    pronto_order_line_items.csv
    TypeText    Import from Directory    data
    ClickText    Next    anchor=Select your Amazon S3 connection and choose your object(s).
    ClickText    Select an Option    anchor=*Primary Key
    ClickText    Order_Item_ID    anchor=New Data Stream
    TypeText    *Data Lake Object Label    AWS S3 Pronto Order Line Items
    ClickText    Next    anchor=New Data Stream - Stage Not Started
    ClickText    Deploy         timeout=40
    VerifyNoText               New Data Stream                   timeout=40
    UseModal     off
    
    # Step 4c3
    Home
    ClickText                  Data Streams
    ClickText                  New
    UseModal                   on
    ClickText    Amazon S3Retrieve a file from Amazon Simple Storage Service
    ClickText    Next    anchor=Select your Amazon S3 connection and choose your object(s).
    TypeText    *File Name    pronto_orders.csv
    TypeText    Import from Directory    data
    ClickText    Next    anchor=Select your Amazon S3 connection and choose your object(s).
    ClickText    Select an Option    anchor=*Primary Key
    ClickText    Customer_ID    anchor=New Data Stream
    TypeText    *Data Lake Object Label    AWS S3 Pronto Orders 
    ClickText    Next    anchor=New Data Stream - Stage Not Started
    ClickText    Deploy         timeout=40
    VerifyNoText               New Data Stream                   timeout=40
    UseModal     off
    
    # 4d
    LaunchApp                  Data Cloud
    Refresh Data Stream        AWS S3 Pronto Orders
    Refresh Data Stream        AWS S3 Pronto Order Line Items
    Refresh Data Stream        AWS S3 Pronto Customers
    Refresh Data Stream        Contact_Home

    #Step 4d2
    # LaunchApp                   Data Cloud
    # ClickText                   Identity Resolutions
    # ClickText                   New
    # UseModal                    on
    # ClickText                   Install from Datakits
    # ClickText                   Next
    # ClickText                   Select Item   anchor=Customer Name and Email
    # ClickText                   Next
    # ClickText                   Save
    # VerifyNoText                New Ruleset
    # UseModal                    off
    # ClickText                   Run Ruleset                      timeout=30
    # Step 5
    Home
    GoTo                    ${login_url}/packaging/installPackage.apexp?p0\=04tWs000000R2VZ
    ClickText    All
    ClickText    Install                        timeout=100
    VerifyText   Installation Complete!
    ClickText    Done
    
    # Step 6
    LaunchApp    Data Cloud
    ClickText    Show more navigation items
    ClickText    Data Graphs
    ClickText    New
    ClickText    Use a Data KitCreate a Data Graph from a Data Kit
    ClickText    Next
    ClickText    Pronto Data Graph
    
