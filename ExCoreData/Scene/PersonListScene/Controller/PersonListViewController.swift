//
//  PersonListViewController.swift
//  ExCoreData
//
//  Created by 강동영 on 3/4/24.
//

import UIKit
import CoreData

final class PersonListViewController: UIViewController {
    private let rootview: PersonListView
    var people: [NSManagedObject] = []
    
    
    init(rootview: PersonListView) {
        self.rootview = rootview
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = rootview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "New List"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: action())
    }
    
    func action() -> UIAction {
        return UIAction(handler: { _ in
            self.present(self.createAlert(), animated: true)
        })
    }
    
    private func createAlert() -> UIAlertController {
        let alert = UIAlertController(title: "이름 입력", message: "이름을 입력하세요", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            print(alert.textFields?.first?.text)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alert.addTextField()
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        return alert
    }
}
