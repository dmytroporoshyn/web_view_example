# Web View Example

A Flutter example project shows communication between a site in the web view and a Flutter app.

## Preparation

To run this project you need:
1. [Install Flutter](https://docs.flutter.dev/get-started/install "Install Flutter")
2. Write `flutter run` in the console inside project folder

## Descrption

For the Webview implementation, the project uses [flutter_inappwebview](https://pub.dev/packages/flutter_inappwebview/versions/6.0.0-beta.23 "flutter_inappwebview") package. This package provides all the necessary functionality to create good communication between the site and Flutter app.

There are a several different ways how this communication can be realised. All methods are described in the [official package documentation](https://inappwebview.dev/docs/webview/javascript/communication "official package documentation").

This project uses a combination of two approaches and works great both on iOS and Android and has been successfully used in another production project.

### Web side
Code of the web part located in the [assets/index.html](https://github.com/dmytroporoshyn/web_view_example/blob/master/assets/index.html "assets/index.html") and provide minimum functionality to make everything work.

###Flutter side
Main part of the Flutter code located in [lib/main.dart](https://github.com/dmytroporoshyn/web_view_example/blob/master/lib/main.dart "lib/main.dart"). The code contain comments that can help to understand a prince of work


------------

**Contact me if you have any questions:
**Dmytro Poroshyn dmytro.p@dreambit.io