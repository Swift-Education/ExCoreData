//
//  PersonListView.swift
//  ExCoreData
//
//  Created by 강동영 on 8/17/24.
//

import UIKit

final class PersonListView: UIView {
    private let tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PersonListCell.self,
            forCellReuseIdentifier: PersonListCell.reuseIdentifier)
        return tableView
    }()
    
    private let emptyLabel: UILabel = {
        let label: UILabel = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "리스트가 비어있습니다."
        return label
    }()
    
    private var peopleNames: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.dataSource = self
        tableView.delegate = self
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(tableView)
        let backview = UIView()
        tableView.addSubview(backview)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension PersonListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        peopleNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonListCell.reuseIdentifier, for: indexPath)
        
        guard let convertedCell = cell as? PersonListCell else { return cell }
        let name = peopleNames[indexPath.row]
        
        convertedCell.config(with: name)
        return convertedCell
    }
}
