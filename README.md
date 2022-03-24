# einstein
- Danil Shalagin
- Du Tham Lieu (Thomas)
- Valentin Chernyshov
---------

Link to [apk](./build/app/outputs/flutter-apk/app-release.apk)
Test successful for: Samsung Galaxy A8, Realme x5, Honor 8 lite, and Smart Pixel 4 API 30

## About einstein
It's basically a minimalist Twitter with Tinder like cards intead of the tweets

## Build
First download the repo
`git clone git@github.com:pierrepicaud/einstein.git`

Then get the dependencies
`flutter pub get`

Finally build for android
`flutter build apk`

## Functionality
- [ ] Users can login/logout using Twitter
    - [x] UI
    - [ ] Back end
- [ ] Users can post tweets
- [x] Can move cards around
- [ ] User can access their profile
    - [x] UI
    - [ ] Back end
- [ ] Users can interact with Tweets via actions on cards
- [x] Firebase login for testing purposes
- [x] Login with firebase
    email: test@test.com
    password: asdfgh
- Click signin with Twitter to skip

### Pages
![image text](./images/images.jpeg)

### Basic (12%)
- [x] Readme (+1)
    - [x] Description of a project
    - [x] How to build
    - [x] List of screens
    - [x] List of features
- [x] Application builds successfully for Android: APK (or link to it) is attached to readme (+1)
- [x] Main screen somehow ready (at least some features) (+1)
- [x] One more screen exists except main screen (+1)
- [x] Custom stateless and Stateful widgets (+1)
- [x] App has at least one ListView on any screen (+1)
- [x] Any networking (REST API, Firebase, etc) (+1)
- [x] Each team member is involved in development. Each member has commits and additions/deletions in Github Insights. (+3)
- [x] Application is reasonable (+2)

### Advanced (8%)
- [ ] Github release is created with description of features that are already implemented (+1)
- [ ] Use some advanced widgets from lecture (+1)
- [ ] Builds successfully for iOS (+1)
- [x] flutter_lints rules are enabled (+1), and no errors and warnings (+2)
- [x] Use async functions and await keyword (+2)
- [x] Decomposition of widgets is used. Screens decomposed into a few widgets with isolated responsibilities (+2)
- [x] UI files separated from logic files (+2)
- [ ] Some approach for creating data-classes is used (freezed/built_value/code template) (+2)
- [ ] 3+ screens with some reasonable content (+2)
