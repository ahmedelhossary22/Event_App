# Event_App
The Event App is a Flutter-based mobile application that allows users to create, manage, and explore events easily.
It’s designed with Firebase as the backend for authentication and real-time data management.
Each user can sign up or log in (with email/password), and their events are stored securely in Firestore — meaning every user has their own personalized list of events.

Features

 User Authentication

Create a new account using email and password and google 

Sign in securely with Firebase Authentication

Each account has its own private event list

 Event Management

Create new events with title, description, category, and date

View all your events in real-time

Update or delete existing events

Mark events as favourites

 Firebase Integration

Firebase Authentication for user accounts

Firestore Database for storing and retrieving event data

Realtime sync for instant updates

 Localization

Supports multiple languages (Arabic 🇪🇬 & English 🇬🇧)

Automatically adapts based on user’s selected language


Theming

Light and Dark mode themes with a clean UI design

 
 How It Works

User signs up → Firebase creates a new account

Firestore automatically starts empty for that new user

User adds events → Events are stored under Firestore’s events_table

When logging in again, the app retrieves that user’s saved events only


🧩ack)

Dart Language
