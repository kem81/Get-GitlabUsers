# Get-GitlabUsers
Get all Gitlab users using the API and PowerShell

This script was created as part of an internal quarterly review of all users access to our local Gitlab container instance. The aim is to disable any users that haven't signed in for over 30 days. This script was used as part of a wider process that runs in a Gitlab pipeline containing several stages with the final stage being a manual approval to remove the users.

Below is a guide to create an access token in Gitlab in order to run this script (copied and pasted from my Confluence guide for the L2 and L1 engineers).....

--------------------------------------------------------------------------------------------------------------------------------

This article is intended to provide a solution to requests from clients/project teams for a list of members with access to groups or projects. It uses the GitLab api via PowerShell to export the members to a csv file. The code below will need to be modified to the specific group/request from the client.

Requirements: 


The attached PowerShell script (in the repo)

Postman (download and install, no admin required)

Access to GitLab


Login to the Gitlab portal and create an access token
Click on your profile pic>Settings>Access Tokens
Give your token a name and select the scopes


Click Create personal access token


Make sure to copy the token as this will be the only time you can retrieve it from GitLab (I recommend saving it Keepass or any other password management app you use)


Next, open Postman. You will need this to find the ID number of the group you want to export the members from.

Paste the following url into a new workspace: 

https://LOCAL GITLAB ENDPOINT/api/v4/groups?per_page=100

Also, under ‘Authorization’ tab, select ‘Bearer Token’ and paste in the access token you created in the previous step.

Click Send



This will give you the list of group ID’s


For this example we will get the group members for ‘Any Group Here’ which is the first group in the list.

we can see the ID=450 for the aadc group



Paste the following url into a new tab in Postman

https://LOCAL GITLAB ENDPOINT/api/v4/groups/450/members/all?per_page=100

Click Send

We can see the results below


Next we will take the url and access token and paste them into the attached PowerShell script.
You will also need to replace the last highlighted export location to a folder specific to your device.


This has exported the users to a csv file with the name, state and access level as headers


You will need to compare or add/replace the access level column to something that is more human readable. The key/legend for the access levels is below


No access (0)

Minimal access (5) (Introduced in GitLab 13.5.)

Guest (10)

Reporter (20)

Developer (30)

Maintainer (40)

Owner (50). Valid for projects in GitLab 14.9 and later. 