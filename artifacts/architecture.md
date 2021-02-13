Populate each section with information as it applies to your project. If a section does not apply, explain why. Include diagrams (or links to diagrams) in each section, as appropriate.  For example, sketches of the user interfaces along with an explanation of how the interface components will work; ERD diagrams of the database; rough class diagrams; context diagrams showing the system boundary; etc. Do _not_ link to your diagrams, embed them directly in this document by uploading the images to your GitHub and linking to them. Do _not_ leave any section blank.

# Program Organization

You should have your context, container, and component (c4model.com) diagrams in this section, along with a description and explanation of each diagram and a table that relates each block to one or more user stories. 

See Code Complete, Chapter 3 and https://c4model.com/

System Context

![](/c4Model-System%20Context.jpg)

Containers

![](/c4Model-Containers.jpg)

Components

![](/c4Model-Components-2.jpg)

# Code Design

You should have your UML Class diagram and any other useful UML diagrams in this section. Each diagram should be accompanied by a brief description explaining what the elements are and why they are in the diagram. For your class diagram, you must also include a table that relates each class to one or more user stories. 

See Code Complete, Chapter 3 and https://c4model.com/

# Data Design

If you are using a database, you should have a basic Entity Relationship Diagram (ERD) in this section. This diagram should describe the tables in your database and their relationship to one another (especially primary/foreign keys), including the columns within each table. 

See Code Complete, Chapter 3

# Business Rules

You should list the assumptions, rules, and guidelines from external sources that are impacting your program design. 

See Code Complete, Chapter 3

# User Interface Design

You should have one or more user interface screens in this section. Each screen should be accompanied by an explaination of the screens purpose and how the user will interact with it. You should relate each screen to one another as the user transitions through the states of your application. You should also have a table that relates each window or component to the support using stories. 

See Code Complete, Chapter 3

# Resource Management

See Code Complete, Chapter 3

# Security

See Code Complete, Chapter 3

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

See Code Complete, Chapter 3

# Internationalization/Localization

The app is based on an American sports league (NBA) and it is only meant for use in the United States. No translations from English are needed.

# Input/Output

The only inputs required from the user are their personal account information. In case of incorrect inputs, errors are detected at the input field.

# Error Processing

See Code Complete, Chapter 3

# Fault Tolerance

See Code Complete, Chapter 3

# Architectural Feasibility

See Code Complete, Chapter 3

# Overengineering

See Code Complete, Chapter 3

# Build-vs-Buy Decisions

This section should list the third party libraries your system is using and describe what those libraries are being used for.

See Code Complete, Chapter 3

# Reuse

See Code Complete, Chapter 3

# Change Strategy

See Code Complete, Chapter 3
