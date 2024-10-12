//
//  Presenter.swift
//  LearningVIPERArchitecture
//
//  Created by AbdulMajid Shaikh on 12/10/24.
//

import Foundation
//Class, Protocol
// Talks to --> Interactor, Router, View

enum NetworkError: Error{
    case NetworkFailed
    case ParsingFailed
}


protocol AnyPresenter{
    var router: AnyRouter? {get set}
    var interactor: AnyInteractor? {get set}
    var view: AnyView? {get set}
    
    func interactorDidDownloadCrypto(result: Result<[Crypto],Error>)
}

class CryptoPresenter: AnyPresenter{
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet{
            interactor?.downloadCryptos()
        }
    }
    
    var view: AnyView?
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], any Error>) {
        
        switch result {
        case .success(let cryptos):
            view?.update(with: cryptos)
            
        case .failure(_):
            view?.update(with: "Try again Later!")
        }
    }
    
    
}
