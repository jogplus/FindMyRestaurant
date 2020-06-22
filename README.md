# Find my Restaurant

## Overview

<img src="https://i.imgur.com/REBVGqt.gif" width=250><img src="https://i.imgur.com/HqCg1hS.gif" width=250>

### Description

This app helps groups of friends find a restaurant when they cannot agree on one.
Once setting a radius of restaurants, each friend gets one veto based on restaurant genre.
After accepting the terms to the "no-backsies" agreement, a restaurant is chosen that is within the radius and does not violate the vetos.

### App Evaluation

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

- User either creates or joins a session.
- Session creator sets the radius to search for restaurants
- Session joiners can join the session using the sessionId
- Users can vote for the categories that they do not want to got to
- Users are presented with a restaurant that is randomly selected from the remaining categories

**Optional Nice-to-have Stories**

- Allows them to make an account so that they could see their previous searches and results.

### 2. Screen Archetypes

- Create
- Join
- Screen with the sessionId or QR code
- Screen where you input the session code
- Screen with a map that lets you decide the radius of your search
- Screen that lets you enter categories/options of food you don't want
- Screen that shows the result on the map and also gives a small description

### 3. Navigation

**Flow Navigation** (Screen to Screen)

Starting screen

- Choose to create or join a session

Session Setup Screen

- Navigate to the screen that allows the session creator to set the radius of desired restaurants

Create Screen

- Navigates to the screen with the sessionId others use to join

Join Screen

- Navigates to the screen with an input box to put sessionId

After joining

- Navigates to the screen that lets you include categories on the types of food you don't

End screen

- After choosing options and categories, it takes you to the end screen which shows a map with a chosen restaurant and its description

### Digital Wireframes & Mockups

<img src="https://imgur.com/B9H2SFm.png" width=600>
<img src="https://imgur.com/TA0UjF8.png" width=600>

## Schema

### Models

- <b>Session</b>(<u>id</u>, userCount, canVote)
- <b>Category</b>(<u>sessionId</u>, <u>categoryId</u>, name, pluralName, shortName, iconURL)
- <b>Vote</b>(<u>sessionId</u>, <u>categoryId</u>)
- <b>Restaurant</b>(<u>sessionId</u>, <u>venue</u>)

### Networking

#### FourSqaure API

- GET https://api.foursquare.com/v2/venues/search
- GET https://api.foursquare.com/v2/venues/VENUE_ID
