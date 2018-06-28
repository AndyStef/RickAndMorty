//
//  CharactersController.swift
//  Rick&Morty
//
//  Created by Andriy Stefanchuk on 28.06.18.
//  Copyright © 2018 Andriy Stefanchuk. All rights reserved.
//

import UIKit

class CharactersController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private var viewModel: CharactersViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
    }
}

private extension CharactersController {
    private func configureViewModel() {
        viewModel = CharactersViewModel(delegate: self)
        viewModel.fetchCharacters()
    }
}

//MARK: - UITableViewDelegate
extension CharactersController: UITableViewDelegate {

}

//MARK: - UITableViewDataSource
extension CharactersController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.charactersCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CharacterTableViewCell = tableView.dequeueReusableCell(at: indexPath)
        cell.configure(with: viewModel.character(at: indexPath.row))
        return cell
    }
}

//MARK: - CharactersViewModelDelegate
extension CharactersController: CharactersViewModelDelegate {
    func onFetchCompleted() {
        tableView.reloadData()
    }

    func onFetchFailed(with reason: String) {
        Utils.showMessage(reason, view: view, anchor: view.topAnchor, dodoType: .error)
    }
}
