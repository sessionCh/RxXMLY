#if !COCOAPODS
import ReusableKit
#endif

import RxCocoa
import RxSwift

#if os(iOS)
import UIKit

extension Reactive where Base: UICollectionView {
  public func items<S: Sequence, Cell: UICollectionViewCell, O: ObservableType>(
    _ reusableCell: ReusableCell<Cell>
  ) -> (_ source: O)
    -> (_ configureCell: @escaping (Int, S.Iterator.Element, Cell) -> Void)
    -> Disposable
    where O.E == S {
    return { source in
      return { configureCell in
        return self.items(cellIdentifier: reusableCell.identifier, cellType: Cell.self)(source)(configureCell)
      }
    }
  }
}
#endif
