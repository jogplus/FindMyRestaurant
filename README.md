# Find my Restaurant

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
This app helps groups of friends find a restaurant when they cannot agree on one. 
Once setting a radius of restaurants, each friend gets one veto based on restaurant genre. 
After accepting the terms to the "no-backsies" agreement, a restaurant is chosen that is within the radius and does not violate the vetos.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:**
Restaurant, Food
- **Mobile:**
This app is mainly meant for mobile users as it is supposed to be accessible no matter where you are. 
- **Story:**
Analyzes users food and restaurant choices and analyzes them to find the perfect restaurant that fits everyones' demands. 
- **Market:**
Anyone can use this app. For instance, if you are planning a family dinner, or want to go out with a group of friends.
- **Habit:**
Friends who are trying to find a place to eat.
- **Scope:**
Young adults.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

User either creates or joins a session that has already been started. If you create, you are given a session or a QR code that your friends can use. If you join, you have to enter a session code to enter.

**Optional Nice-to-have Stories**

Allows them to make an account so that they could see their previous searches and results.

### 2. Screen Archetypes

Create
Join
Screen with the session or QR code
Screen where you input the session code
Screen with a map that lets you decide the radius of your search
Screen that lets you enter categories/options of restaurants/food you want
Screen that shows the result on the map and also gives a small description

### 3. Navigation

**Tab Navigation** (Tab to Screen)
None

**Flow Navigation** (Screen to Screen)

Starting screen
  - either choose create or join
 
 If create 
  - navigates to the screen with the session code
  
 If join
  - navigates to the screen with an input box to put session code
  
 After creating
   - navigates to the screen with a map to select the radius of search
   
  After joining
    - navigates to the screen that lets you include categories on the types of food you want
    
  End screen
    - After choosing options and categories, it takes you to the end screen which shows a map with a chosen restaurant and its descrioption
## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="YOUR_WIREFRAME_IMAGE_URL" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
