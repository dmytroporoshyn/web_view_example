# Web View Example

A Flutter example project shows communication between a site in the web view and a Flutter app.

## Preparation

To run this project you need:
1. [Install Flutter](https://docs.flutter.dev/get-started/install "Install Flutter")
2. Write `flutter run` in the console inside project folder

## Descrption

For the Webview implementation, the project uses [flutter_inappwebview](https://pub.dev/packages/flutter_inappwebview/versions/6.0.0-beta.23 "flutter_inappwebview") package. This package provides all the necessary functionality to create good communication between the site and Flutter app.

There are a several different ways how this communication can be realised. All methods are describet in the [official package documentation](https://inappwebview.dev/docs/webview/javascript/communication "official package documentation").

This project uses a combination of two approaches and works great both on iOS and Android and has been successfully used in another production project.