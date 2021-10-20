//
//  AnimateLogin.swift
//  vkClient
//
//  Created by Василий Слепцов on 30.08.2021.
//

import UIKit


class AnimateLogin: UIViewController {
    
    @IBOutlet var animateStackView: UIStackView!
    private let dot1 = UIView()
    private let dot2 = UIView()
    private let dot3 = UIView()
    private lazy var dots = [dot1, dot2, dot3]
    private var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStack()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
    
    func configureStack() {
        animateStackView.axis = .horizontal
        animateStackView.spacing = 145 / 2
        animateStackView.alignment = .center
        animateStackView.distribution = .fill
        
        dots.forEach {
            $0.layer.backgroundColor = CGColor(red: 150, green: 0, blue: 0, alpha: 1)
            $0.layer.cornerRadius = 35 / 2
            $0.alpha = 0
            $0.layer.masksToBounds = true
            animateStackView.addArrangedSubview($0)
            $0.widthAnchor.constraint(equalToConstant: 35).isActive = true
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor).isActive = true
        }
    }
    
    func animate() {
        UIView.animateKeyframes(withDuration: 3,
                                delay: 0,
                                options: [],
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/6) {
                                            self.dot1.alpha = 1
                                            self.dot1.transform = CGAffineTransform(scaleX: 2, y: 2)
                                        }
                                        UIView.addKeyframe(withRelativeStartTime: 1/6, relativeDuration: 1/6) {
                                            self.dot1.alpha = 0.2
                                            self.dot1.transform = CGAffineTransform(scaleX: 1, y: 1)
                                        }
                                        UIView.addKeyframe(withRelativeStartTime: 2/6, relativeDuration: 1/6) {
                                            self.dot2.alpha = 1
                                            self.dot2.transform = CGAffineTransform(scaleX: 2, y: 2)
                                        }
                                        UIView.addKeyframe(withRelativeStartTime: 3/6, relativeDuration: 1/6) {
                                            self.dot2.alpha = 0.2
                                            self.dot2.transform = CGAffineTransform(scaleX: 1, y: 1)
                                        }
                                        UIView.addKeyframe(withRelativeStartTime: 4/6, relativeDuration: 1/6) {
                                            self.dot3.alpha = 1
                                            self.dot3.transform = CGAffineTransform(scaleX: 2, y: 2)
                                        }
                                        UIView.addKeyframe(withRelativeStartTime: 5/6, relativeDuration: 1/6) {
                                            self.dot3.alpha = 0.2
                                            self.dot3.transform = CGAffineTransform(scaleX: 1, y: 1)
                                        }
                                },
                                completion: {_ in
                                    self.count += 1
                                    if self.count >= 2 {
                                        self.performSegue(withIdentifier: "moveToMain", sender: self)
                                    } else {
                                        self.animate()
                                    }
                                    
                                })
    }
}
