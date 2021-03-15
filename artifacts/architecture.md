# Architecture.md

# Program Organization

System Context
---

![](/artifacts/c4Model-System%20Context.jpg)

Each Broke Bets App user has opportunity to create betting contests among friends and, while doing, so the Broke Bets App acts as the primary element in the scope of this context diagram. It is interacting directly with firebase, which acts as a service to store information about data, matches, etc. and handles them via cloud functions (R020, R021, R022, R024). The firebase is acting as the supporting element that connected with Broke Bets App that will read and write data.

Containers
---

![](/artifacts/c4Model-Containers.jpg)

When a user wishes to interact with the information regarding their account or contests, they communicate with the Firebase database to change or view the information. The game information is stored in the database with the ESPN web scraper each time a score changes and when the game finishes (R020, R022, R024).

Components
---

![](/artifacts/c4Model-Components-2.jpg)

The components consists of 3 containers: the mobile application, firebase, and the web scraper. The mobile application is responsible for displaying all relevant data to the user and allows the user to interact with the appropriate data. Firebase controlls all permanent save data and will send out data to the listeners in the mobile application (R020). The webscraper contains the Headless Browser component, the Diff/Caching component and the CronJob component (R022, R024). The CronJob component triggers events to find the next schedule for the NBA and then starts the Headless Browser component before the first game. The Headless Browser component then scrapes data from ESPN when the data changes to eventually be stored in Firebase (R022). The Diff/Caching component compares the data to previously captured data (if any) and then stores the appropriate data in Firebase (R024).

| Component | User Stories this block relates to  | Description       |
| ---               | ---                                 | ---               |
| Mobile Application | U001 - U030 | The mobile application component traces back to all the user stories, the app is what makes possible all the requirements a user would want |
| Web Scraper Server | U010, U014 | The web scraper server is traceable to the user stories that have to do with getting the game information such as teams, scores, time left, etc.  |
| Firebase | U003 - U010, U011, U012, U013, U015 - U030 | The Firebase component is related to every aspect in which information is stored. It shares traceability with the web scraper's user stories, since all the game information is written on the database. It also traces back to the stories regarding login information, contest attributes, invitations, and statistics. |

# Code Design

![](/artifacts/Class_Diagram.jpg)

Class Diagram Description
---

We will be using the MVVM pattern for our frontend and so almost all of our classes will be View Models. Our Views and Models will all be Structs. 

| Class Name        | User Stories this class relates to  | Description       |
| ---               | ---                                 | ---               |
| CreateNewContestVM | U004, U019, U022 | View model for the full screen modal that allows a user to create a new contest with another user. |
| ContestsVM | U020, U021, U025 | View model that for the contests view which retreives all of the user's upcoming, in-progress, and completed contests. |
| ContestsBetslipVM | U010, U016, U024 | View model for the contest betslip screen which merges the current scores of the associated games for the bets in the contest with the actual bet information so that the view can show a list of games with the user's corresponding bets.  |
| DraftsVM | U008, U023, U029 | View model for the drafts view which fetches all of the draft that a user is currently participating in. |
| DraftPickSelectionVM | U029, U030 | View model for the draft pick selection view that fetches all of the previous picks that have been made in that draft (if applicable) and updates the data model when the user selects a draft pick if it is their turn. |
| EntireBetslipVM | U010 | View model for the betslip view that merges the current scores of the associated games for all the bets a user has in any of their contests with the actual bet information so that the view can show a list of games with the user's corresponding bets. |
| RecievedInvitationsVM | U005, U011, U026 | View model for the recieved tab of the invitation screen which fetches all the contest invitations that a user has received that have not been accepted or rejected yet. |
| SentInvitationsVM | U012 | View model for the recieved tab of the invitation screen which fetches all the contest invitations that a user has sent that have not been accepted or rejected yet by the other user. |
| StatisticsVM | U013, U018 | View model for the statistics screen which fetches all the statistics that detail the user's performance on the app. |
| AccountVM | U028 | View model for the account view that fetches the user's profile information and allows for the user to logout |
| LoginVM | U015, U006| View model for the login view that signs in the user using an email/password or their Apple account |
| CreateAccountVm | U007 | View model for the create account view that allows a user to create a new account |
| CreateUsernameVm | U027 | View model for the create username view that allows for a user who signed in with Apple for the first time to select a username that their account should be associated with. |


# Data Design

![](/artifacts/ERD-2.jpg)

Data Design Description

We will be storing all of our data in Cloud Firestore which is a NoSQL database (R020). All of the bordered boxes in our data model diagram represent Firestore Collections. Each Collection shows the data fields that will be associated with each Document in a Collection. We will attach real-time listeners to queries for many of those collections so that the data being displayed on a user's app will be properly synced with the most up-to-date data (R024). Every collection will be able to be read and written to by a user except for the Associated_Contests_For_Games collection and the Unfinished_Games collection. Those collections will be written to by our Web scraping server and be read by Cloud Functions that have triggers in place for when a game has ended so that we can clean up certain data automatically (R022). 



Data handling info: All of our data will be stored in Cloud Firestore (R022), except for some cached data that will be stored on the user's phone. Any cached data will be handling completely by Firebase. 

---


# Business Rules

Since this is a competitive betting app, data needs to be accurate and completely synced up. For this reason, we are using Firebase's Realtime Database service. Each player's current contest information will always be up to date (R022, R024).
We also need to make sure the NBA scores are updated frequently (every minute) to maintain relevant data for the user.

# User Interface Design

![](/artifacts/UI.png)

UI Description
---
- Main Screen
  - This screen allows the user to sign in with their Apple ID
  - If when signing in with Apple, the user's username is not found, they will be navigated to the "Create a Username" screen to create a new username

- The "Create a Username" screen will be used to create a new username for the user if necessary
  - When the user clicks the "Continue" button, the name they have (or haven't) entered will be validated. If the username is not already taken, and the username is between 6 and 16 characters long, then this will transition them to the Contests screen
  - If the user clicks the "Continue" button and the name is taken, red text should appear underneath the username textfield that says "Username already taken" and they should then be able to try a different/unique username.

- Upon successfully logging in, the user will be brought to the “Contests” tab
- In the “Contests”, “Bet Slip”, “Invitations”, “Drafts” and “Statistics” pages, the user will be able to navigate to any of those 5 pages by selecting the appropriate icon on the bottom tab bar.
- The contest tab will display all the contests the user is or has been involved in
  - The top right plus button will allow the user to start a new contest
  - The top tab bar allows the user to switch views between “Upcoming”, “In progress”, and "Completed” contests
  - Each completed or in progress contest will display the player’s score compared to the user in the categories of “drafted wins”, “forced wins” and “total wins” and display the amount of bets remaining
  - Each upcoming contest will display the username for the user's opponent, the total number of bets associated with the contest, as well as the start time for the earliest game that is associated with that contest

- In the new contest screen, The user can select a player to compete with
  - To navigate back to the contest screen, the user can click the icon in the top left corner
  - If the search bar is blank, the table view will be populated with recent players
  - Upon entering text into the search bar, the list view will populate with user’s display names
  - If the user clicks a player, the are selecting them to compete in a contest with and the user will be transitioned the contest confirmation screen

- The contest confirmation screen will allow the user to confirm that they’ve selected the correct player
  - The user can change the number of rounds by clicking the stepping
  - The user can select when the contest invitation expires by selecting the DatePicker on the right
  - Once the information is finalized/reviewed, the player can click the send invite button to send the invite to the player.

- The Bet Slip screen shows all of the bets under a certain category
  - The top section allows the user to switch views between “Upcoming”, “In progress”, and "Completed”
  - Each bet slip will display the type of bet, the side of the bet (indicated by ‘+’ or ‘-‘) and the number of contests correlated with that particular bet

- The Invitations screen will allow the user to view contest requests and see the status of contests requests they have sent out
  - The user will be able to switch between “Recieved” and “Sent” to view send or recieved invitations
  - Each invitation will display the person who sent it, the person who it’s sent to, the status of the invitation (awaiting response, accepted), and the number of rounds

- The Drafts screen will show all the drafts of contests that aren’t complete
  - Each Draft View will contain the opposing player who is involved, the draft round number, and a text that says either “Your turn” or “Their Turn” as well as t    text that displays the last pick that was drafted (if applicable)

- The Statistics page will include statistics about the user regarding their wins and losses in previous contests, as well as other minor stats
  - Each row will contain the statistic on the right correlating to the descrption on the left

| UI Component      | User Stories this UI relates to     | Description       |
| ---               | ---                                 | ---               |
| Sign in | U001, U006, U015 | The user views a loading screen upon opening the app and can login on multiple devices using either email and password or an Apple account |
| Create Account | U007 | If the user does not have an account they can make one here |
| Contest | U003, U020, U025 | A user can view upcoming, current and previous contests that they are involved in |
| Bet Slip | U010, U021, U024 | Users can view the scores of games they are watching and how they impact their contests |
| Invitations | U005, U011, U012, U022 | The user can see, send and accept invitations. Invitations do expire. |
| Drafts | U008, U014, U023 | Drafts are placed against opponents when it's their turn. Drafts do expire. |
| Statistics | U013, U018 | The app stores statistics and displays them to the user |
| New contest | U004, U016 | The user can search and/or select a player to start a contest with |
| New contest 2 | U019 | The user can edit details before creating a contest |

# Resource Management

The application is not memory-constrained, so the Firebase database can handle all the accounts, bets, and the rest of the app information. The CronJob component from the web scraper (R022) is prevented from overloading the server by killing the child process in case a CronJob process is still active when trying to run again.

# Security

BrokeBets
---
Users will not have explicit access to other user’s data. All data requests will be made stricly through the app only with a valid FireBase account tied to the user. The data will be displayed, but rewrites of data will only happen within the app for each personal user. We will not manually encrypt usernames or passwords, and will only save them through Firebase (R020).

Apple
---
Apple includes security on all of its levels including hardware, system and data protection and the app level. Specifically, Apple’s App security promises security for each of its apps against attacks and checks them fro viruses/malware before approval. It also covers other areas natively such as Application firewall, app notarization, and system integrity protection.

  More details can be found in the following links:
  - https://www.apple.com/legal/privacy/en-ww/
  - https://support.apple.com/guide/security/app-security-overview-sec35dd877d0/web

Firebase
---
Firebase is certified under major privacy and security standards and follows ISO and SOC compliance. Firebase encrypts all their data and restricts access and monitors access to all data (R020, R022).

  More information can be found below:
  - https://firebase.google.com/support/privacy

# Performance

The latency between a new score in a game and an update on the app is the sum of the time of two events: an update on ESPN to the Firebase web scraping server, and from the scraper to the database to the user (R022). The app's total latency goal is 5 seconds.

# Scalability

There is a one-to-many relationship between the live scores of NBA games and the app users who have contests with bets associated with those games. Thus, no matter how many users are using the app the web scraper server component/container will only have to write live score data to a constant number of locations (R022).

For updating the scores of the head-to-head contest, it is not as scalable because the number of updates that our cloud function will have to do whenever a game ends is proportional to the number of contests associated with each game. So, as the number of users increases, the constests increases, and the workload of the cloud function that updates the state of the contest will also increase (R024).

# Interoperability

This field does not apply.
All data is transfered through firebase, so no direct communication occurs (R020, R022). And since all data is formatted in Entities and Relationships, no data sent is ambiguous.

# Internationalization/Localization

The app is based on an American sports league (NBA) and it is only meant for use in the United States. No translations from English are needed.
Swift strickly uses Unicode and all strings in Swift are encoded in Unicode, so all of our code and strings will be in Unicode.

# Input/Output

The only inputs required from the user are their personal account information. In case of incorrect inputs, errors are detected at the input field (R023).

# Error Processing

Our program will take a detective error approach and will notify the user if and when the data is not found. We'll incorporate active error detection whenever possible and use UI dialogues when incorrect data is entered. The program will not continue unless the user entered field is entered correctly. For data retrival, users will be notified when a value is nil by a simple dialogue box. For instance, if the user's contest data could not be retrieved, a dialogue box would describe the error and they can select the one option that says "okay". All error messages will follow the same format with the description outlining the error. Classes should always check optional variables and follow the outlined error process if nil (R023).

# Fault Tolerance

If the program detects an error, the fault thrown would be more of a resetting the data to a default state such as name would be defaulted to "John Doe" and the score's value can be set to 0. If the program doesn't detect the error and the value is nil, then by xcode conventions, the program will crash automatically.

# Architectural Feasibility

The architecture is feasible because because the resources are good enough for the amount of users which is 5, and firebase along with web scraper will not be impacted negatively due to that (R020, R021, R022).

# Overengineering

The architecture will match the requirements the simplest and most efficient way possible so that programmers will not be overengineering their classes.

# Build-vs-Buy Decisions


We are deciding to build most of our components except for certain Backend components. The third party components we plan to use are Firebase Auth for user authentication (R021), Cloud Firestore for storing our app's data and real-time data (R020), and Cloud Functions for executing small pieces of code that will clean up the database and update certain documents when a game has finished. All of these services are a part of the Firebase platform which will not cost us anything because we will be using their free tier. 

Our decision is twofold:
- Using Firebase allows us to focus most of our attention on the front end and the web scraping service instead of worrying about maintaining and scaling an app server, database server (R022).
- Using Firebase Auth makes it so we don't have to store a user's passwords or validate JSON Web Tokens which will make our app more secure since Google is more capable of implementing authentication services than we are (R021). 

# Reuse

This section does not apply.
We will not be resusing any old software or hardware.

# Change Strategy

Version number will be incremented per week and correlated to the project's Sprint number. New features will be incorporated as additional Views (or screens). Each new change will correlate to a new View Model. 
Updates to the codebase will be tracked and kept current through GitHub. Only working software will be pushed.
