//
//  SceneDelegate.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 27/02/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private(set) var mainCoordintor: SOMainCoordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        // Ideally view should be created and assigned to window
        // That view should be assigned as coordinators root view
        // To keep everything simple here, I am just grabbing the root view from storyboard
        guard let rootVC = self.window?.rootViewController else {
            fatalError("The root view controller is missing")
        }
        
        // Start coordinator with a root view
        mainCoordintor = SOMainCoordinator(viewController: rootVC)
        mainCoordintor.start()
    }

}

