//
//  ___FILEHEADER___
//

import UIKit

class ___FILEBASENAME___: UIViewController {
    var mainView = ___VARIABLE_productName:identifier___View()
    
    private var tableViewDataSource: [___VARIABLE_productName:identifier___Model]? {
        didSet {
            DispatchQueue.main.async {
                self.mainView.tableView.reloadData()
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
        mainView.tableView.registerReusableCell(___VARIABLE_productName:identifier___TableViewCell.self)
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        tableViewDataSource = fakeInitModel()
    }
}

//MARK: - tableView dataSource/delegate
extension ___FILEBASENAME___: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ___VARIABLE_productName:identifier___TableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let row = indexPath.row
        
        if let model = tableViewDataSource?[row] {
            cell.model = model
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - helpers and handlers
extension ___FILEBASENAME___ {
    /** This func was written to generate fake models, replace tableViewDataSource with your own model */
    private func fakeInitModel() -> [___VARIABLE_productName:identifier___Model] {
        var models = [___VARIABLE_productName:identifier___Model]()
        
        for i in 0 ... 20 {
            var model = ___VARIABLE_productName:identifier___Model()
            
            model.title = "Title for cell \(i)"
            model.description = "Description for cell \(i)"
            model.imageName = "testCellImage"
            
            models.append(model)
        }
        
        return models
    }
}
