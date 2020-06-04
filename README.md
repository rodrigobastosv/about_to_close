#  Introduction

Package created for the purpose of giving an easy option for those who want to easily prevent the user of leaving the app by mistake. AboutToClose help you to inform the user that he is about to close the app, so you give him a chance to tell if that's what he really wants to do.

# Basic Usage

You can use the package on the fly by simple wrapping the widget you want to prevent the behavior.

```dart
MaterialApp(
  title: 'Flutter Demo',
  theme: ThemeData(
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ),
  home: AboutToClose(
    dialogType: DialogType.material,
    dialogTitle: 'You are about to close the app. Are you sure you want to leave?',
    child: MyHomePage(title: 'Flutter Demo Home Page'),
  ),
);
```

![enter image description here](https://s7.gifyu.com/images/Peek-03-06-2020-22-23.gif)

You can customize all types of things like if you want a Material or Cupertino Dialog to open, if you ant animation or the strings and styles there are shown.