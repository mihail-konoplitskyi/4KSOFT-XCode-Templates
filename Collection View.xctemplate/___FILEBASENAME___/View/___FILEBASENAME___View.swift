//
//  ___FILEHEADER___
//

import UIKit
import SnapKit

class ___FILEBASENAME___: UIView {
    // declare all UI elements here
    let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let obj = UICollectionViewFlowLayout()
        obj.itemSize = CGSize(width: 180, height: 180)
        obj.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        obj.minimumLineSpacing = 10
        obj.scrollDirection = .horizontal
        return obj
    }()
    
    lazy var collectionView: UICollectionView = {
        let obj = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        obj.backgroundColor = .clear
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        // do all view's configurations here
        backgroundColor = .white
        
        // add all subviews here
        addSubview(collectionView)
        
        // make constraints for subviews here
        collectionView.snp.makeConstraints { make in
            make.left.right.centerY.equalToSuperview()
            make.height.equalTo(200)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // do work here when you need ready subview's frame
    }
}

//MARK: - helpers and handlers
extension ___FILEBASENAME___ {
    // declare all helper functions here
}
