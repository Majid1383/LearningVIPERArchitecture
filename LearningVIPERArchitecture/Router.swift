//
//  Router.swift
//  LearningVIPERArchitecture
//
//  Created by AbdulMajid Shaikh on 12/10/24.
//

import Foundation
import UIKit

//Class, Protocol
//EntryPoint

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? {get}
    static func startExecution() -> AnyRouter
}

class CrytoRouter : AnyRouter{
    
    var entry : EntryPoint?
    
    static func startExecution() -> any AnyRouter {
        
        let router = CrytoRouter()
        var view : AnyView = CryptoViewController()
        var presenter : AnyPresenter = CryptoPresenter()
        var interactor : AnyInteractor = CryptoInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        router.entry = view as? EntryPoint
        
        return router
    }
}
