//
//  ___FILEHEADER___
//

import UIKit
import SnapKit

class ___FILEBASENAME___: UIView {
    // declare all UI elements here
    let collectionViewFlowLayout: CarouselFlowLayout = {
        let obj = CarouselFlowLayout()
        obj.itemSize = CGSize(width: 180, height: 180)
        obj.spacingMode = .fixed(spacing: 18)
        obj.animationMode = .scale(sideItemScale: 0.75, sideItemAlpha: 1, sideItemShift: 0)
        obj.scrollDirection = .horizontal
        return obj
    }()
    
    lazy var collectionView: UICollectionView = {
        let obj = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        obj.backgroundColor = .clear
        obj.showsHorizontalScrollIndicator = false
        return obj
    }()
    
    let selectRandomRowButton: UIButton = {
        let obj = UIButton(type: .system)
        obj.setTitle("Select random row", for: .normal)
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
        addSubview(selectRandomRowButton)
        
        // make constraints for subviews here
        collectionView.snp.makeConstraints { make in
            make.left.right.centerY.equalToSuperview()
            make.height.equalTo(200)
        }
        
        selectRandomRowButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom).offset(20)
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
