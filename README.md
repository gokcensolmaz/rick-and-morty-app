# Rick and Morty App

<img src="https://github.com/gokcensolmaz/rick-and-morty-app/assets/61111670/8ad69b03-577e-469f-86a9-15c7586db70b" alt="Splash Screen" width="30%" height="30%">

This is a Rick and Morty app that utilizes the Rick and Morty API to display various information about characters and locations from the show. The app consists of three main screens: Splash Screen, Home Screen, and Character Detail Screen.

## Splash Screen
The Splash Screen is the initial screen of the app and shows a gif, image, and text. If it's the first run of the app, it displays "Welcome!" Otherwise, it displays "Hello!" for returning users. After 5 seconds, the screen navigates to the Home Screen.

## Home Screen
The Home Screen displays a logo at the top and a tab bar showing different locations fetched from the API. Each tab represents a location, and when a location is selected, it shows a list of residents from that location. The character cards in the list display character images, names, and genders.

<img src="https://github.com/gokcensolmaz/rick-and-morty-app/assets/61111670/8bde4518-656f-435b-99a1-d2795604863d" alt="Home Screen" width="30%" height="30%">

## Character Detail Screen
The Character Detail Screen shows detailed information about a specific character. It displays the character's image, status, species, gender, location, and episodes they appear in.

<img src="https://github.com/gokcensolmaz/rick-and-morty-app/assets/61111670/c2075a13-0543-44bf-b32b-855c63939993" alt="Character Detail" width="30%" height="30%">

## How to Run the App
1. Clone this repository to your local machine.
2. Make sure you have Flutter and Dart installed.
3. Run `flutter pub get` to install the required packages.
4. Run the app using `flutter run`.
Please ensure that you have a working internet connection to fetch data from the API.

## Dependencies Used
- `flutter_gif` - To display gifs in the Splash Screen.
- `provider` - To manage state and handle API requests.
- `http` - To perform HTTP requests to the API.
- `intl` - To format dates.

### Author
This app was developed by Gökçen Solmaz. Feel free to contact me if you have any questions or suggestions for the app.
You are free to modify and use it as you wish. Happy coding!
