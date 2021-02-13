Populate each section with information as it applies to your project. If a section does not apply, explain why. Include diagrams (or links to diagrams) in each section, as appropriate.  For example, sketches of the user interfaces along with an explanation of how the interface components will work; ERD diagrams of the database; rough class diagrams; context diagrams showing the system boundary; etc. Do _not_ link to your diagrams, embed them directly in this document by uploading the images to your GitHub and linking to them. Do _not_ leave any section blank.

# Program Organization

You should have your context, container, and component (c4model.com) diagrams in this section, along with a description and explanation of each diagram and a table that relates each block to one or more user stories. 

See Code Complete, Chapter 3 and https://c4model.com/

System Context

![](/artifacts/c4Model-System%20Context.jpg)

Containers

![](/artifacts/c4Model-Containers.jpg)

Components

![](/artifacts/c4Model-Components-2.jpg)

# Code Design

You should have your UML Class diagram and any other useful UML diagrams in this section. Each diagram should be accompanied by a brief description explaining what the elements are and why they are in the diagram. For your class diagram, you must also include a table that relates each class to one or more user stories. 

See Code Complete, Chapter 3 and https://c4model.com/

# Data Design

If you are using a database, you should have a basic Entity Relationship Diagram (ERD) in this section. This diagram should describe the tables in your database and their relationship to one another (especially primary/foreign keys), including the columns within each table. 

See Code Complete, Chapter 3

# Business Rules

You should list the assumptions, rules, and guidelines from external sources that are impacting your program design. 

Since this is a competitive betting app, data needs to be accurate and completely synced up. For this reason, we are using Firebase's Realtime Database service. Each player's current contest information will always be up to date.
We also need to make sure the NBA scores are updated frequently (every minute) to maintain relevant data for the user.

# User Interface Design

You should have one or more user interface screens in this section. Each screen should be accompanied by an explaination of the screens purpose and how the user will interact with it. You should relate each screen to one another as the user transitions through the states of your application. You should also have a table that relates each window or component to the support using stories. 

See Code Complete, Chapter 3

# Resource Management

The application is not memory-constrained, so the Firebase database can handle all the accounts, bets, and the rest of the app information. The CronJob component from the webscraper is prevented from overloading the server by killing the child process in case a CronJob process is still active when trying to run again.

# Security

BrokeBets
---
Users will not have explicit access to other user’s data. All data requests will be made stricly through the app only with a valid FireBase account tied to the user. The data will be displayed, but rewrites of data will only happen within the app for each personal user.

Apple
---
Apple includes security on all of its levels including hardware, system and data protection and the app level. Specifically, Apple’s App security promises security for each of its apps against attacks and checks them fro viruses/malware before approval. It also covers other areas natively such as Application firewall, app notarization, and system integrity protection.

  More details can be found in the following links:
  - https://www.apple.com/legal/privacy/en-ww/
  - https://support.apple.com/guide/security/app-security-overview-sec35dd877d0/web

Firebase
---
Firebase is certified under major privacy and security standards and follows ISO and SOC compliance. Firebase encrypts all their data and restricts access and monitors access to all data.

  More information can be found below:
  - https://firebase.google.com/support/privacy

# Performance

The latency between a new score in a game and an update on the app is the sum of the time of two events: an update on ESPN to the Firebase web scraping server, and from the scraper to the database to the user. The app's total latency goal is 5 seconds.

# Scalability

There is a one-to-many relationship between the live scores of NBA games and the app users who have contests with bets associated with those games. Thus, no matter how many users are using the app the web scraper server component/container will only have to write live score data to a constant number of locations.

For updating the scores of the head-to-head contest, it is not as scalable because the number of updates that our cloud function will have to do whenever a game ends is proportional to the number of contests associated with each game. So, as the number of users increases, the constests increases, and the workload of the cloud function that updates the state of the contest will also increase.

# Interoperability

This field does not apply.
All data is transfered through firebase, so no direct communication occurs. And since all data is formatted in Entities and Relationships, no data sent is ambiguous.

# Internationalization/Localization

The app is based on an American sports league (NBA) and it is only meant for use in the United States. No translations from English are needed.

# Input/Output

The only inputs required from the user are their personal account information. In case of incorrect inputs, errors are detected at the input field.

# Error Processing

Our program will take a detective error approach and will notify the user if and when the data is not found. We'll incorporate active error detection whenever possible and use UI dialogues when incorrect data is entered. The program will not continue unless the user entered field is entered correctly. For data retrival, users will be notified when a value is nil by a simple dialogue box. For instance, if the user's contest data could not be retrieved, a dialogue box would describe the error and they can select the one option that says "okay". All error messages will follow the same format with the description outlining the error. Classes should always check optional variables and follow the outlined error process if nil.

# Fault Tolerance

If the program detects an error, the fault thrown would be more of a resetting the data to a default state such as name would be defaulted to "John Doe" and the score's value can be set to 0. If the program doesn't detect the error and the value is nil, then by xcode conventions, the program will crash automatically.

# Architectural Feasibility

The architecture is feasible because because the resources are good enough for the amount of users which is 5, and firebase along with webscraper will not be impacted negatively due to that.

# Overengineering

The architecture will match the requirements the simplest and most efficient way possible so that programmers will not be overengineering their classes.

# Build-vs-Buy Decisions

We are deciding to build all of our components except firebase. We plan to use firebase with its free plan.
Our decision is twofold:
- This is a school project, so we want it to be free to develop
- Since our project is a custom app, most of our features and designs will be uniquely implemented
Part of our project will be to build the UI and coordinating functions, so we have decided not to purchase any outside UI resources.

# Reuse

This section does not apply.
We will not be resusing any old software or hardware.

# Change Strategy

Version number will be incremented per week and correlated to the project's Sprint number. New features will be incorporated as additional Views (or screens). Each new change will correlate to a new View Model. 
Updates to the codebase will be tracked and kept current through GitHub. Only working software will be pushed.
