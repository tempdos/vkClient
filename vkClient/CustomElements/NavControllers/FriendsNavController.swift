//
//  FriendsNavController.swift
//  vkClient
//
//  Created by Василий Слепцов on 07.09.2021.
//

import UIKit

final class FriendsNavController: UINavigationController {
    
    let interactiveTransition = InteractiveTransition()

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

extension FriendsNavController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {

        return interactiveTransition.isStarted ? interactiveTransition : nil
    }

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .pop:
            if navigationController.viewControllers.first != toVC {
                interactiveTransition.viewController = toVC
            }
            return PopTransition()
        case .push:
            interactiveTransition.viewController = toVC
            return PushTransition()
        default:
            return nil
        }
    }
}
