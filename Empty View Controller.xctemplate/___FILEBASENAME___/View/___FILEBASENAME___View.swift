//
//  ___FILEHEADER___
//

import UIKit
import SnapKit

class ___FILEBASENAME___: UIView {
    // declare all UI elements here
    private let myLabel: UILabel = {
        var obj = UILabel()
        obj.text = "Hello world!"
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
        addSubview(myLabel)
        
        // make constraints for subviews here
        myLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
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
