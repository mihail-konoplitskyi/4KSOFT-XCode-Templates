//
//  ___FILEHEADER___
//

import Foundation
import UIKit

class ___FILEBASENAME___: UITableViewCell, Reusable {
    var model: ___VARIABLE_productName:identifier___Model? {
        didSet {
            handleUI()
        }
    }
    
    private let cellImageView: UIImageView = {
        let obj = UIImageView()
        obj.backgroundColor = .gray
        obj.clipsToBounds = true
        return obj
    }()
    
    private let cellTitleLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .black
        return obj
    }()
    
    private let cellDescriptionLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .black
        return obj
    }()
    
    private let separator: UIView = {
        let obj = UIView()
        obj.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return obj
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        
        contentView.addSubview(cellImageView)
        contentView.addSubview(cellTitleLabel)
        contentView.addSubview(cellDescriptionLabel)
        contentView.addSubview(separator)
        
        cellImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.equalTo(16)
            make.size.equalTo(50)
        }
        
        cellTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(cellImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(cellImageView).multipliedBy(0.67)
        }
        
        cellDescriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(cellTitleLabel)
            make.centerY.equalTo(cellImageView).multipliedBy(1.33)
        }
        
        separator.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cellImageView.layer.cornerRadius = cellImageView.bounds.height/2
    }
}

//MARK: - helpers and handlers
extension ___FILEBASENAME___ {
    private func handleUI() {
        guard let model = model else {
            return
        }
        
        cellImageView.image = UIImage(named: model.imageName)
        cellTitleLabel.text = model.title
        cellDescriptionLabel.text = model.description
    }
}
