# PQMenuBar

[![CI Status](http://img.shields.io/travis/pqteru/PQMenuBar.svg?style=flat)](https://travis-ci.org/pqteru/PQMenuBar)
[![Version](https://img.shields.io/cocoapods/v/PQMenuBar.svg?style=flat)](http://cocoapods.org/pods/PQMenuBar)
[![License](https://img.shields.io/cocoapods/l/PQMenuBar.svg?style=flat)](http://cocoapods.org/pods/PQMenuBar)
[![Platform](https://img.shields.io/cocoapods/p/PQMenuBar.svg?style=flat)](http://cocoapods.org/pods/PQMenuBar)

PQMenuBar is a Light-weight Menu Bar for iOS App.

  - Easy to use
  - Customizable menu size
  - Customizable menu item features
  - Paging available

![Screenshot](/PQMenuBar_screenshot.png?raw=true "PQMenuBar_screenshot" =250x)

## Usage
```objective-c
menu = [[PQMenuBar alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 180)];

PQMenuBarItem *itemA = [[PQMenuBarItem alloc] initWithTitle:@"testA"
                                              image:[UIImage imageNamed:@"photo"]
                                              target:self
                                              action:@selector(actionA:)];

PQMenuBarItem *itemB = [[PQMenuBarItem alloc] initWithTitle:@"testB"
                                              image:nil
                                              target:self
                                              action:@selector(actionB:)];
[menu addMenuItem:itemA];
[menu addMenuItem:itemB];
[menu show];
```

Setting columns and rows
```objective-c
[menu setColumn:3 andRow:3];
```
Default columns is 4 and rows is 2

Set hide paging, default is NO
```objective-c
[menu hidePaging:YES];
```

Set its delegate
```objective-c
menu.delegate = self;
```

Method that can be implemented
```objective-c
- (void)menuBar:(PQMenuBar *)menubar didSelectAtIndex:(int)index;
```

## Example
To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Installation

PQMenuBar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```objective-c
pod "PQMenuBar"
```

## Author

pqteru, pqteru@gmail.com

## License

PQMenuBar is available under the MIT license. See the LICENSE file for more info.
