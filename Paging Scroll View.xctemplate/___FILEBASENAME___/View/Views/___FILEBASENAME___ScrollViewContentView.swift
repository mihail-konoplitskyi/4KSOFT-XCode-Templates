//
//  ___FILEHEADER___
//


import Foundation
import UIKit

class ___FILEBASENAME___: UIView {
    var model: ___VARIABLE_productName:identifier___Model? {
        didSet {
            handleUI()
        }
    }
    
    private let imageView: UIImageView = {
        let obj = UIImageView()
        obj.backgroundColor = .gray
        obj.clipsToBounds = true
        return obj
    }()
    
    private let titleLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .white
        obj.font = UIFont.systemFont(ofSize: 32)
        obj.numberOfLines = 3
        obj.textAlignment = .center
        return obj
    }()
    
    private let descriptionLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .white
        obj.font = UIFont.systemFont(ofSize: 22)
        obj.numberOfLines = 0
        obj.textAlignment = .center
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
        backgroundColor = .white
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
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
        
        imageView.image = UIImage(named: model.imageName)
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
}
