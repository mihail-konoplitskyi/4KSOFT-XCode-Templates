//
//  ___FILEHEADER___
//

import UIKit

class ___FILEBASENAME___: UIViewController {
    var mainView = ___VARIABLE_productName:identifier___View()
    
    private var currentSelectedIndex: Int = 0 {
        didSet {
            mainView.handleButtonsVisibility(currentPage: currentSelectedIndex)
            debugPrint("Currently on page: \(currentSelectedIndex)")
        }
    }
    
    private var scrollViewDataSource: [___VARIABLE_productName:identifier___Model]? {
        didSet {
            DispatchQueue.main.async {
                guard let scrollViewDataSource = self.scrollViewDataSource else {
                    return
                }
                
                self.mainView.initializeScrollView(models: scrollViewDataSource)
            }
        }
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    private func initViewController() {
        // do all initializations here
        mainView.scrollView.delegate = self
        
        scrollViewDataSource = fakeInitModel()
        
        mainView.nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        mainView.backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
    }
}

//MARK: - ScrollView delegate
extension ___FILEBASENAME___: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let currentSelectedIndex = Int(offsetX / width)
        
        self.currentSelectedIndex = currentSelectedIndex
        
    }
}

//MARK: - helpers and handlers
extension ___FILEBASENAME___ {
    /** This func was written to generate fake models, replace tableViewDataSource with your own model */
    private func fakeInitModel() -> [___VARIABLE_productName:identifier___Model] {
        var models = [___VARIABLE_productName:identifier___Model]()
        
        for i in 0 ... 20 {
            var model = ___VARIABLE_productName:identifier___Model()
            
            model.title = "Title for scrollView content view \(i)"
            model.description = "Description for scrollView content view \(i)"
            model.imageName = "testCellImage"
            
            models.append(model)
        }
        
        return models
    }
    
    @objc private func nextButtonTapped(_ sender: UIButton) {
        if currentSelectedIndex + 1 < mainView.scrollViewContentViews.count {
            moveScrollViewTo(page: currentSelectedIndex + 1)
        }
    }
    
    @objc private func backButtonTapped(_ sender: UIButton) {
        if currentSelectedIndex >= 1 {
            moveScrollViewTo(page: currentSelectedIndex - 1)
        }
    }
    
    private func moveScrollViewTo(page: Int) {
        var currentContentOffset = mainView.scrollView.contentOffset
        let width = mainView.scrollView.frame.width
        
        currentContentOffset.x = width * CGFloat(page)
        
        self.currentSelectedIndex = page
        mainView.scrollView.setContentOffset(currentContentOffset, animated: true)
    }
}
