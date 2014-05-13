# StreetEZ

StreetEZ is a sample apartment listing application built by [Andrew Kayvanfar](https://www.andrewkayvanfar.com) based off [StreetEasy](http://www.streeteasy.com).  The live version of the sample application is available here: [StreetEZ] (http://www.streetez.me)

## Technical Overview

This web application is built in Ruby on Rails with front end features in Backbone.js and also unobtrusive JavaScript.  Technical features include:

* Twilio text messaging to verify a human user
* Facebook login using OAuth
* Custom SQL queries
* Nested forms
* Uploading of pictures using Paperclip
* Rental searches conducted using UJS
* Messaging fully implemented in Backbone.js
* Customized interactive map using Mapbox's Javascript API
* Polymorphic Notification model that automatically generates messages to the user based on his / her actions

* Application designed to work with or without JavaScript enabled

## Functionality Overview

#### General Features

Users do not need to sign in to view the rentals listed on StreetEZ. Signing in is only required to view information that is user specific, such as managing listings or creating / attending open houses.

#### Search

From the homepage or from the rentals index page, a user can search for apartments by a variety of criteria, including Neighborhood, price range, number of bedrooms, and number of bathrooms. All of these parameters are optional and can be used in any combination. Searches use custom SQL queries to find apartment matching the specified parameters. Search results are displayed next to an interactive map that uses Mapbox's JavaScript API.

#### Rentals

From any rental listing page, a user can view the various photos of that apartment, see details for the listing, and also elect to attend any of the open houses that are scheduled for that given listing. Should the user want more information, they can send a message to the owner of the listing as well. If the user wants to be able to quickly find this listing again, he / she can save the rental listing to his / her profile for quick reference in the future.

#### Listing an Apartment

A user can list their apartment and upload images once signed in. A nested form creates and updates a rental listing with addresses stored in a table separate from the rental. Photos don't have to be uploaded individually, but many can be selected at once from the browse window. Once the new rental listing is created, a user can manage that listing on their 'My Account' page.

#### Open Houses

Users can schedule open houses for the listings they own. They can manage these open houses on their 'My Account' page. Users can also attend open houses that have been posted and see a list of those open houses on their 'My Account' page. Users can cancel open houses or select not to attend an open house they have already signed up for.

#### Notifications

Users can stay informed of their various interactions with each other and the app. Notifications will be flagged as 'new' until they are clicked on, allowing users to easily navigate between new and old notifications.


## Upcoming Improvements

* Allow drag and drop photo upload
* Implement password reset
* Make calendar interface for open houses more interactive
* Add photo carrousel to rental listings
* Allow user to see attendees of his / her open houses