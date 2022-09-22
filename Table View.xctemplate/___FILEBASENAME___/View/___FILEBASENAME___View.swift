//
//  ___FILEHEADER___
//

import UIKit
import SnapKit

class ___FILEBASENAME___: UIView {
    // declare all UI elements here
    let tableView: UITableView = {
        let obj = UITableView()
        obj.separatorStyle = .none
        obj.rowHeight = UITableView.automaticDimension
        obj.backgroundColor = .white
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
        addSubview(tableView)
        
        // make constraints for subviews here
        tableView.snp.makeConstraints { make in
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
    // declare all helper functions here
}
