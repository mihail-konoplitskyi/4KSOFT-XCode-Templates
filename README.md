# XCode Templates by 4K-SOFT written with Swift

[![Swift](https://img.shields.io/badge/Swift-5.3_5.4_5.5_5.6-orange?style=flat-square)](https://img.shields.io/badge/Swift-5.3_5.4_5.5_5.6-Orange?style=flat-square)
[![Platforms](https://img.shields.io/badge/Platforms-macOS_iOS-yellowgreen?style=flat-square)](https://img.shields.io/badge/Platforms-macOS_iOS_tvOS-Green?style=flat-square)
[![Platforms](https://img.shields.io/badge/license-MIT-blue)](https://img.shields.io/badge/license-MIT-blue)

XCode Templates was created to save time for iOS/MacOS developers that are usually spending time copy-pasting same code from another projects just to create new screen with simple UI elements. With XCode Templates this process can be significantly automated. 

In every template I'm using only programmatical view, no xib/storyboard. 

Feel free to leave your [wishes](https://github.com/mihail-konoplitskyi/4KSOFT-XCode-Templates/issues/new) and [comments](https://github.com/mihail-konoplitskyi/4KSOFT-XCode-Templates/issues/new).

- [How to start using](#how-to-start-using)
- [Screenshots](#screenshots)
- [Future plans](#future-plans)

## How to start using

- Create "Templates" directory 

  ```bash
    $ mkdir ~/Library/Developer/Xcode/Templates
  ```

- Open "Templates" directory that you just created

  ```
    $ cd ~/Library/Developer/Xcode/Templates
  ```
  
- Clone repository 

  ```
    $ git clone https://github.com/mihail-konoplitskyi/4KSOFT-XCode-Templates.git
  ```

- Restart XCode if it was opened

- Open XCode project, press CMD+N, scroll down to 4KSOFT-XCode-Templates and use needed template

  ![How to select template](https://github.com/mihail-konoplitskyi/4KSOFT-XCode-Templates/blob/master/images/select_template.png)

- Add newly created module to a project 

  ![Copy module](https://github.com/mihail-konoplitskyi/4KSOFT-XCode-Templates/blob/master/images/add_module.png)

  ![Copy module 2](https://github.com/mihail-konoplitskyi/4KSOFT-XCode-Templates/blob/master/images/add_module_2.png)

- Remove module reference from a project (remove reference, not a directory)

  ![Remove reference](https://github.com/mihail-konoplitskyi/4KSOFT-XCode-Templates/blob/master/images/remove_reference.png)

- Templates are using different third-party frameworks. You can find installation guide below: 
  - [SnapKit](https://github.com/SnapKit/SnapKit#installation) (DSL to make Auto Layout easy on both iOS and OS X)
  
## Screenshots

#### Empty View Controller
  ![Empty View Controller Screenshot](https://github.com/mihail-konoplitskyi/4KSOFT-XCode-Templates/blob/master/images/EmptyViewControllerScreenshot.png)

#### Custom TableViewCell
  ![Custom Table View Cell](https://github.com/mihail-konoplitskyi/4KSOFT-XCode-Templates/blob/master/images/CustomTableViewCellScreenshot.png)

#### Custom CollectionViewCell
  ![Custom Table View Cell](https://github.com/mihail-konoplitskyi/4KSOFT-XCode-Templates/blob/master/images/CustomCollectionViewCellScreenshot.png)

## Projects that were built with XCode Templates:

  - [Hide Expert VPN](https://apps.apple.com/gb/app/hide-expert-vpn/id1616168170?platform=iphone)
  - [Sona](https://apps.apple.com/gb/app/sona-healthy-sleep/id1617545266)

## Future plans

All iOS/MacOS developers are spending tons of time doing absolutely identical work. This repository was created to solve this problem. In a close future I will create most recent templates for developers needs. 

After most recent templates will be created with UIKit, I'll start preparing AppKit templates for MacOS and SwiftUI templates. 
