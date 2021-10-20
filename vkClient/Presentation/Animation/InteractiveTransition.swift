//
//  InteractiveTransition.swift
//  vkClient
//
//  Created by Василий Слепцов on 07.09.2021.
//

import UIKit

final class InteractiveTransition: UIPercentDrivenInteractiveTransition {

    var viewController: UIViewController? {
        didSet {
            let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handle(_:)))
            recognizer.edges = [.left]
            viewController?.view.addGestureRecognizer(recognizer)
        }
    }

    var isStarted: Bool = false
    var isFalse: Bool = false

    @objc func handle(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            isStarted = true
            viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            let transition = recognizer.translation(in: recognizer.view)
            let relative = transition.x / (recognizer.view?.bounds.width ?? 1)
            let progress = max(0, min(1, relative))
            self.isFalse = progress > 0.4
            update(progress)
        case .ended:
            isStarted = false
            isFalse ? finish() : cancel()
        case .cancelled:
            isStarted = false
            cancel()
        default:
            return
        }
    }
}
