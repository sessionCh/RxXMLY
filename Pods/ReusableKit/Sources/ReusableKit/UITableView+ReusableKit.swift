#if os(iOS)
import UIKit

extension UITableViewCell: CellType {
}

extension UITableView {

  // MARK: Cell

  /// Registers a generic cell for use in creating new table cells.
  public func register<Cell>(_ cell: ReusableCell<Cell>) {
    if let nib = cell.nib {
      self.register(nib, forCellReuseIdentifier: cell.identifier)
    } else {
      self.register(Cell.self, forCellReuseIdentifier: cell.identifier)
    }
  }

  /// Returns a generic reusable cell located by its identifier.
  public func dequeue<Cell>(_ cell: ReusableCell<Cell>) -> Cell? {
    return self.dequeueReusableCell(withIdentifier: cell.identifier) as? Cell
  }

  /// Returns a generic reusable cell located by its identifier.
  public func dequeue<Cell>(_ cell: ReusableCell<Cell>, for indexPath: IndexPath) -> Cell {
    return self.dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as! Cell
  }

  // MARK: View

  /// Registers a generic view for use in creating new table header or footer views.
  public func register<View>(_ cell: ReusableView<View>) {
    if let nib = cell.nib {
      self.register(nib, forHeaderFooterViewReuseIdentifier: cell.identifier)
    } else {
      self.register(View.self, forHeaderFooterViewReuseIdentifier: cell.identifier)
    }
  }

  /// Returns a generic reusable header of footer view located by its identifier.
  public func dequeue<View>(_ view: ReusableView<View>) -> View? {
    return self.dequeueReusableHeaderFooterView(withIdentifier: view.identifier) as? View
  }
}
#endif
