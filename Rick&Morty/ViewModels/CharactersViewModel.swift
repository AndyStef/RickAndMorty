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

    init(delegate: CharactersViewModelDelegate) {
        self.delegate = delegate
    }

    var charactersCount: Int {
        return characters.count
    }

    func character(at index: Int) -> Character {
        return characters[index]
    }

    func fetchCharacters() {
        Alamofire.request(ApiRouter.characters)
            .validate()
            .responseJSON(completionHandler: { response in
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

                    self.characters.append(contentsOf: decodedResponse.results)
                    self.delegate?.onFetchCompleted()
                }
            })
    }
}
