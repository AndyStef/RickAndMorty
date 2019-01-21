//
//  CharactersViewModel.swift
//  Rick&Morty
//
//  Created by Andriy Stefanchuk on 28.06.18.
//  Copyright © 2018 Andriy Stefanchuk. All rights reserved.
//

import Alamofire

protocol CharactersViewModelDelegate: class {
    func onFetchCompleted()
    func onFetchFailed(with reason: String)
}

class CharactersViewModel {
    private weak var delegate: CharactersViewModelDelegate?

    private var characters: [Character] = []
    private var totalCount = 0
    private var nextPageUrlString = ""
    private var isFetchInProgress = false

    init(delegate: CharactersViewModelDelegate) {
        self.delegate = delegate
    }

    var charactersCount: Int {
        return characters.count
    }

    var canLoadMore: Bool {
        return !nextPageUrlString.isEmpty && !isFetchInProgress
    }

    func character(at index: Int) -> Character {
        return characters[index]
    }

    func fetchCharacters() {
        guard !isFetchInProgress else { return }
        isFetchInProgress = true

        if characters.isEmpty {
            try? fetchCharacters(with: ApiRouter.characters.asURLRequest())
        } else {
            guard charactersCount != totalCount else {
                isFetchInProgress = false
                return
            }

            guard let url = URL(string: nextPageUrlString) else {
                delegate?.onFetchFailed(with: "Invalid next page URL")
                return
            }
            let urlRequest = URLRequest(url: url)
            fetchCharacters(with: urlRequest)
        }
    }

    private func fetchCharacters(with urlRequest: URLRequest) {
        Alamofire.request(urlRequest)
            .validate()
            .responseJSON(completionHandler: { response in
                self.isFetchInProgress = false
                switch response.result {
                case .failure(let error):
                    self.delegate?.onFetchFailed(with: error.localizedDescription)
                case .success:
                    guard let jsonData = response.data else {
                        self.delegate?.onFetchFailed(with: DataResponseError.noData.reason)
                        return
                    }
                    guard let decodedResponse = try? JSONDecoder().decode(BaseResponse<Character>.self, from: jsonData) else {
                        self.delegate?.onFetchFailed(with: DataResponseError.decoding.reason)
                        return
                    }

                    self.updatePagingInfo(with: decodedResponse.info)
                    self.characters.append(contentsOf: decodedResponse.results)
                    self.delegate?.onFetchCompleted()
                }
            })
    }

    private func updatePagingInfo(with info: PagingInfo) {
        totalCount = info.generalCount
        nextPageUrlString = info.nextUrlString
    }
}
