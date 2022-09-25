//
//  ___FILEHEADER___
//

import UIKit
import SnapKit

class ___FILEBASENAME___: UIView {
    var scrollViewContentViews = [___VARIABLE_productName:identifier___ScrollViewContentView]()
    
    // declare all UI elements here
    let scrollView: UIScrollView = {
        let obj = UIScrollView()
        obj.backgroundColor = .white
        obj.isPagingEnabled = true
        return obj
    }()
    
    var backButton: UIButton = {
        let obj = UIButton(type: .system)
        obj.setTitle("BACK", for: .normal)
        obj.backgroundColor = .gray
        obj.tintColor = .white
        obj.isUserInteractionEnabled = false
        obj.alpha = 0
        return obj
    }()
    
    var nextButton: UIButton = {
        let obj = UIButton(type: .system)
        obj.setTitle("NEXT", for: .normal)
        obj.backgroundColor = .gray
        obj.tintColor = .white
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
        addSubview(scrollView)
        addSubview(backButton)
        addSubview(nextButton)
        
        // make constraints for subviews here
        scrollView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(400)
        }
        
        backButton.snp.makeConstraints { make in
            make.left.equalTo(33)
            make.height.bottom.equalTo(nextButton)
            make.width.equalToSuperview().multipliedBy(0.333)
        }
        
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(60)
            make.top.equalTo(scrollView.snp.bottom).offset(30)
            make.height.equalTo(50)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // do work here when you need ready subview's frame
        scrollView.contentSize.width = scrollView.bounds.width * CGFloat(scrollViewContentViews.count)
    }
}

//MARK: - helpers and handlers
extension ___FILEBASENAME___ {
    // declare all helper functions here
    func initializeScrollView(models: [___VARIABLE_productName:identifier___Model]) {
        //clearing scrollView subviews if it was already initialized
        scrollViewContentViews.forEach({$0.removeFromSuperview()})
        
        models.enumerated().forEach { index, model in
            let contentView = ___VARIABLE_productName:identifier___ScrollViewContentView()
            contentView.model = model
            scrollViewContentViews.append(contentView)
            
            scrollView.addSubview(contentView)
            contentView.snp.makeConstraints { make in
                make.top.width.height.equalToSuperview()
                
                if index == 0 {
                    make.leading.equalToSuperview()
                } else {
                    make.leading.equalTo(scrollViewContentViews[index-1].snp.trailing)
                }
            }
        }
    }
    
    func handleButtonsVisibility(currentPage: Int) {
        UIView.animate(withDuration: 0.3) {
            self.backButton.alpha = (currentPage == 0 ? 0 : 1)
            self.backButton.isUserInteractionEnabled = (currentPage == 0 ? false : true)
            
            if currentPage == 0 {
                self.nextButton.snp.remakeConstraints { make in
                    make.left.right.equalToSuperview().inset(60)
                    make.top.equalTo(self.scrollView.snp.bottom).offset(30)
                    make.height.equalTo(50)
                }
            } else {
                self.nextButton.snp.remakeConstraints { make in
                    make.right.equalTo(-33)
                    make.height.equalTo(50)
                    make.top.equalTo(self.scrollView.snp.bottom).offset(30)
                    make.width.equalToSuperview().multipliedBy(0.333)
                }
            }
            
            self.layoutIfNeeded()
        }
    }
}
