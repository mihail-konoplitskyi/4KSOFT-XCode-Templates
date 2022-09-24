//
//  ___FILEHEADER___
//

import Foundation
import UIKit

class ___FILEBASENAME___: UICollectionViewCell, Reusable {
    var model: ___VARIABLE_productName:identifier___Model? {
        didSet {
            handleUI()
        }
    }
    
    private let cellImageView: UIImageView = {
        let obj = UIImageView()
        obj.backgroundColor = .gray
        obj.clipsToBounds = true
        obj.layer.cornerRadius = 18
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .clear
        
        contentView.addSubview(cellImageView)
        
        cellImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // do work here when you need ready subview's frame
    }
}

//MARK: - helpers and handlers
extension ___FILEBASENAME___ {
    private func handleUI() {
        guard let model = model else {
            return
        }
        
        cellImageView.image = UIImage(named: model.imageName)
    }
}
