//
//  ___FILEHEADER___
//

import UIKit

class ___FILEBASENAME___: UIViewController {
    var mainView = ___VARIABLE_productName:identifier___View()
    
    private var collectionViewDataSource: [___VARIABLE_productName:identifier___Model]? {
        didSet {
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
    }
    
    private var selectedRow: Int = 0 {
        didSet {
            print("Selected row: \(selectedRow)")
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
        mainView.collectionView.registerReusableCell(___VARIABLE_productName:identifier___CollectionViewCell.self)
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        
        collectionViewDataSource = fakeInitModel()
        
        mainView.selectRandomRowButton.addTarget(self, action: #selector(selectRandomRowButtonTapped(_:)), for: .touchUpInside)
    }
}

//MARK: - tableView dataSource/delegate
extension TestScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewDataSource?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ___VARIABLE_productName:identifier___CollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let row = indexPath.row
        
        if let model = collectionViewDataSource?[row] {
            cell.model = model
        }
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let selectedRow = mainView.collectionViewFlowLayout.currentCenteredPage {
            self.selectedRow = selectedRow
        }
    }
}

//MARK: - helpers and handlers
extension ___FILEBASENAME___ {
    /** This func was written to generate fake models, replace tableViewDataSource with your own model */
    private func fakeInitModel() -> [___VARIABLE_productName:identifier___Model] {
        var models = [___VARIABLE_productName:identifier___Model]()
        
        for _ in 0 ... 20 {
            var model = ___VARIABLE_productName:identifier___Model()
            
            model.imageName = "testCellImage"
            
            models.append(model)
        }
        
        return models
    }
    
    @objc private func selectRandomRowButtonTapped(_ sender: UIButton) {
        guard let collectionViewDataSource = self.collectionViewDataSource else {
            debugPrint("Critical bug - collectionViewDataSource is NIL")
            return
        }
        
        let randomRow = Int.random(in: 0..<collectionViewDataSource.count)
        self.mainView.collectionViewFlowLayout.scrollToPage(atIndex: randomRow, animated: true)
        
        self.selectedRow = randomRow
    }
}
