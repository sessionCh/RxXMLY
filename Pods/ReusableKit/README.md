# ReusableKit

![Swift](https://img.shields.io/badge/Swift-3.1-orange.svg)
[![CocoaPods](http://img.shields.io/cocoapods/v/ReusableKit.svg)](https://cocoapods.org/pods/ReusableKit)
[![Build Status](https://travis-ci.org/devxoul/ReusableKit.svg)](https://travis-ci.org/devxoul/ReusableKit)
[![Codecov](https://img.shields.io/codecov/c/github/devxoul/ReusableKit.svg)](https://codecov.io/gh/devxoul/ReusableKit)

Generic reusables for Cocoa. Currently supports `UITableView` and `UICollectionView`.

## At a Glance

#### Before 🤢

```swift
collectionView.register(UserCell.self, forCellWithReuseIdentifier: "userCell")
collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath) as! UserCell
```

1. A hard-coded string identifier can cause a human error.
2. A force downcasting should be avoided.

#### After 😊

```swift
let reusableUserCell = ReusableCell<UserCell>()
collectionView.register(reusableUserCell)
collectionView.dequeue(reusableUserCell) // UserCell
```

1. A string identifier is generated automatically using UUID and stored in the struct.
2. A generic can ensure the type of the dequeued cell statically.

## Example Usage

It is recommended to define reusable types as a static constants in an `enum` or a `struct`.

#### UITableView

```swift
// 1. define
enum Reusable {
  static let headerView = ReusableCell<SectionHeaderView>()
  static let userCell = ReusableCell<UserCell>()
}

// 2. register
tableView.register(Reusable.headerView)
tableView.register(Reusable.userCell)

// 3. dequeue
tableView.dequeue(Reusable.headerView, for: indexPath)
tableView.dequeue(Reusable.userCell, for: indexPath)
```

#### UICollectionView

```swift
// 1. define
enum Reusable {
  static let headerView = ReusableCell<SectionHeaderView>()
  static let photoCell = ReusableCell<PhotoCell>()
}

// 2. register
collection.register(Reusable.headerView, kind: .header)
collection.register(Reusable.photoCell)

// 3. dequeue
collection.dequeue(Reusable.headerView, kind: .header, for: indexPath)
collection.dequeue(Reusable.photoCell, for: indexPath)
```

#### RxSwift Extension

ReusableKit supports a RxSwift extension.

```swift
users // Observable<[String]>
  .bind(to: collectionView.rx.items(Reusable.userCell)) { i, user, cell in
    cell.user = user
  }
```

## Contrubiting

Pull requests are welcomed 💖

In order to create Xcode project, run:

```console
$ swift package generate-xcodeproj
```

## Installation

- **For iOS 8+ projects** with [CocoaPods](https://cocoapods.org):

    ```ruby
    pod 'ReusableKit'
    pod 'ReusableKit/RxSwift'  # with RxSwift extension
    ```

## License

**ReusableKit** is under MIT license. See the [LICENSE](LICENSE) file for more info.
