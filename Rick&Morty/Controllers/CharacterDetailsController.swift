//
//  CharacterDetailsController.swift
//  Rick&Morty
//
//  Created by Andriy Stefanchuk on 28.06.18.
//  Copyright © 2018 Andriy Stefanchuk. All rights reserved.
//

import UIKit

class CharacterDetailsController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    var headerView: DetailCharacterHeaderView!
    private var tableHeaderViewHeight: CGFloat {
        return view.frame.height / 4 * 3
    }

    private var character: Character?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHeaderView()
    }

    func configure(with character: Character) {
        self.character = character
    }
}

private extension CharacterDetailsController {
    private func configureHeaderView() {
        headerView = tableView.tableHeaderView as! DetailCharacterHeaderView
        headerView.imageUrl = character?.imageUrl
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        tableView.contentInset = UIEdgeInsets(top: tableHeaderViewHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0.0, y: -tableHeaderViewHeight)
        updateHeaderView()
    }

    private func updateHeaderView() {
        var headerRect = CGRect(x: 0.0, y: -tableHeaderViewHeight, width: tableView.bounds.width, height: tableHeaderViewHeight)
        if tableView.contentOffset.y < 0 {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        headerView.frame = headerRect
    }


}

//MARK: - UITableViewDataSource
extension CharacterDetailsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Test text"
        return cell
    }
}

//MARK: - UITableViewDelegate
extension CharacterDetailsController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
}
