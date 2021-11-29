//
//  NewsFeedViewController.swift
//  vkClient
//
//  Created by Василий Слепцов on 22.11.2021.
//

import UIKit

final class NewsFeedViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    // Services
    private let newsFeedAPI = NewsFeedAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        newsFeedAPI.getNewsFeed { [weak self] news in
//            news.forEach { item in
//                debugPrint(item.photoUrl)
//            }
//        }
    }
}

extension NewsFeedViewController: UITableViewDelegate {
    
}
extension NewsFeedViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedTableViewCell.reusedIdentifier, for: indexPath) as? NewsFeedTableViewCell
        else {
            return UITableViewCell()
        }
        
        return cell
    }
}
