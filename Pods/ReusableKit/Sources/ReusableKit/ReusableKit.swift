#if os(iOS)
import UIKit

public protocol CellType: class {
  var reuseIdentifier: String? { get }
}

/// A generic class that represents reusable cells.
public struct ReusableCell<Cell: CellType> {
  public typealias Class = Cell

  public let `class`: Class.Type = Class.self
  public let identifier: String
  public let nib: UINib?

  /// Create and returns a new `ReusableCell` instance.
  ///
  /// - parameter identifier: A reuse identifier. Use random UUID string if identifier is not provided.
  /// - parameter nib: A `UINib` instance. Use this when registering from xib.
  public init(identifier: String? = nil, nib: UINib? = nil) {
    self.identifier = nib?.instantiate(withOwner: nil, options: nil).lazy
      .flatMap { ($0 as? CellType)?.reuseIdentifier }
      .first ?? identifier ?? UUID().uuidString
    self.nib = nib
  }

  /// A convenience initializer.
  ///
  /// - parameter identifier: A reuse identifier. Use random UUID string if identifier is not provided.
  /// - parameter nibName: A name of nib.
  public init(identifier: String? = nil, nibName: String) {
    let nib = UINib(nibName: nibName, bundle: nil)
    self.init(identifier: identifier, nib: nib)
  }
}

public protocol ViewType: class {
}

/// A generic class that represents reusable views.
public struct ReusableView<View: ViewType> {
  public typealias Class = View

  public let `class`: Class.Type = Class.self
  public let identifier: String
  public let nib: UINib?

  /// Create and returns a new `ReusableView` instance.
  ///
  /// - parameter identifier: A reuse identifier. Use random UUID string if identifier is not provided.
  /// - parameter nib: A `UINib` instance. Use this when registering from xib.
  public init(identifier: String? = nil, nib: UINib? = nil) {
    self.identifier = identifier ?? UUID().uuidString
    self.nib = nib
  }

  /// A convenience initializer.
  ///
  /// - parameter identifier: A reuse identifier. Use random UUID string if identifier is not provided.
  /// - parameter nibName: A name of nib.
  public init(identifier: String? = nil, nibName: String) {
    let nib = UINib(nibName: nibName, bundle: nil)
    self.init(identifier: identifier, nib: nib)
  }
}
#endif
