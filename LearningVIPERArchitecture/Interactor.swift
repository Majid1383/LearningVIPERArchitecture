//
//  Interactor.swift
//  LearningVIPERArchitecture
//
//  Created by AbdulMajid Shaikh on 12/10/24.
//

import Foundation

//Class, Protocol
// Talks to --> Presenter 

protocol AnyInteractor{
    var presenter: AnyPresenter? {get set}
    func downloadCryptos()
    
}

class CryptoInteractor: AnyInteractor{
    
    var presenter: AnyPresenter?
    
    func downloadCryptos() {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/IA32-CryptoComposeData/main/cryptolist.json") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data , response, error in
            
            guard let data = data, error == nil else { 
                self.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.NetworkFailed))
                return }
            
            do{
                let crypto = try JSONDecoder().decode([Crypto].self, from: data)
                self.presenter?.interactorDidDownloadCrypto(result: .success(crypto))
            } catch {
                self.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.ParsingFailed))
            }
            
        }
        task.resume()
         
    }
}
