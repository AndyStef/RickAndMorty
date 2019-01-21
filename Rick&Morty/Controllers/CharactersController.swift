//
//  CharactersController.swift
//  Rick&Morty
//
//  Created by Andriy Stefanchuk on 28.06.18.
//  Copyright © 2018 Andriy Stefanchuk. All rights reserved.
//

import UIKit

class CharactersController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    private enum LayoutConstants {
        static let interCellsSpacing: CGFloat = 2.5
        static let numberOfItemsPerRow = 2
    }

    private var viewModel: CharactersViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()

        let textField = UITextField()
        //textField.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControlEvents#>)
    }

    func configure(_ textField: UITextField, selector: Selector) {
        textField.addTarget(self, action: selector, for: .touchDown)
    }
}

private extension CharactersController {
    private func configureViewModel() {
        viewModel = CharactersViewModel(delegate: self)
        viewModel.fetchCharacters()
    }
}

//MARK: - UICollectionViewDataSource
extension CharactersController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.charactersCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CharactersCollectionViewCell = collectionView.dequeueReusableCell(at: indexPath)
        cell.configure(with: viewModel.character(at: indexPath.item))
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension CharactersController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //MARK: - This is not very smart
        if indexPath.item == viewModel.charactersCount - 3 && viewModel.canLoadMore {
            viewModel.fetchCharacters()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsController = storyboard.instantiateViewController() as CharacterDetailsController
        detailsController.configure(with: viewModel.character(at: indexPath.item))
        navigationController?.pushViewController(detailsController, animated: true)
    }
}

//MARK: - UICollectionViewDataSource
extension CharactersController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstants.interCellsSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstants.interCellsSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interCellsInsets = CGFloat(LayoutConstants.numberOfItemsPerRow - 1) * LayoutConstants.interCellsSpacing
        let size = (collectionView.bounds.width - interCellsInsets)/CGFloat(LayoutConstants.numberOfItemsPerRow)
        return CGSize(width: size, height: size)
    }
}

//MARK: - CharactersViewModelDelegate
extension CharactersController: CharactersViewModelDelegate {
    func onFetchCompleted() {
        collectionView.reloadData()
        activityIndicator.stopAnimating()
    }

    func onFetchFailed(with reason: String) {
        Utils.showMessage(reason, view: view, anchor: view.topAnchor, dodoType: .error)
    }
}
