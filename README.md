<p align="center">
  <img src="hopebox.png">
</p>

<p align="center">
  <img src="Hopebox 1.gif">
  <img src="Hopebox 2.gif">
</p>

### What is hopebox? 
Hopebox is a cross-platform iOS/Android app that focuses on the tracking and improvement of mental health. Hopebox provides a(n):
- Mood entry
- Journal entry
- Calendar view (Monthly, Fortnighly, Weekly)
  - Queries the respective user's database to receive their mood and journal entries from certain dates
- Analytics page
  - Creates an infographic chart of how often a user's been feeling a certain mood - pickable time periods allowed!
- Individual profile
  - For each user within the database, which keeps track of their mood and journal entries

Hopebox also gives it's users the option to have their emotions automatically deduced based off what they wrote in the journal entry. To do this, we utilise Microsoft Azure's Sentiment Analysis service and communicate with their APIs within our application.

Hopebox uses:
- **Dart** as our main software language,
- **Flutter** as our main software development kit,
- **Firebase** as our backend database,

### Developers
- Danny Guo (@dannyg97)
  - Roles: Journal entry, UI/UX designer
- Ho Kim (@z5117018)
  - Roles: Sentiment Analysis integration, calendar, analytics
- Kaveh Faghani (@Kavehfaghani)
  - Roles: Mood entry, calendar
- Kevin Feng (@kfengc27)
  - Roles: Login/register authentication, analytics
