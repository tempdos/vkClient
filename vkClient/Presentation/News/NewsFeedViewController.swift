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
    private var news: [News] = []
    private var groups: [NewsGroup] = []
    private var profiles: [NewsProfile] = []
    
    private enum NewsFeedContents {
        case text
        case photo
        case author
        case likes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
        tableView.register(UINib(nibName: NewsTextCell.reusedIdentifier, bundle: nil), forCellReuseIdentifier: NewsTextCell.reusedIdentifier)
        tableView.register(UINib(nibName: NewsPhotoCell.reusedIdentifier, bundle: nil), forCellReuseIdentifier: NewsPhotoCell.reusedIdentifier)
        tableView.register(UINib(nibName: NewsAuthorAndDateCell.reusedIdentifier, bundle: nil), forCellReuseIdentifier: NewsAuthorAndDateCell.reusedIdentifier)
        tableView.register(UINib(nibName: NewsLikesAndCommentsCell.reusedIdentifier, bundle: nil), forCellReuseIdentifier: NewsLikesAndCommentsCell.reusedIdentifier)
        
        tableView.reloadData()
        
        
    }
    
    func getData() {
        newsFeedAPI.getNewsFeed { [weak self] news, groups, profiles in
            guard let self = self else { return }
            self.news = news
            self.groups = groups
            self.profiles = profiles
            
            if news.count > 0 {
                
            }
        }
    }
}

extension NewsFeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if news.count == 0 {
            (cell as? NewsTextCell)?.configure(newsText: "Test")
        } else {
            (cell as? NewsTextCell)?.configure(newsText: news[0].text)
        }
        (cell as? NewsPhotoCell)?.newsImage.load(url: URL(string: "http://test.ru/image.jpeg")!)
        (cell as? NewsAuthorAndDateCell)?.configure(author: "Vasilii Sleptsov", date: "06 December 2021")
        (cell as? NewsLikesAndCommentsCell)?.configure(likes: 5, comments: 10)
    }
}
extension NewsFeedViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: return tableView.dequeueReusableCell(withIdentifier: NewsTextCell.reusedIdentifier, for: indexPath)
        case 1: return tableView.dequeueReusableCell(withIdentifier: NewsPhotoCell.reusedIdentifier, for: indexPath)
        case 2: return tableView.dequeueReusableCell(withIdentifier: NewsAuthorAndDateCell.reusedIdentifier, for: indexPath)
        case 3: return tableView.dequeueReusableCell(withIdentifier: NewsLikesAndCommentsCell.reusedIdentifier, for: indexPath)
        default:
            debugPrint("No cell chosen")
            return tableView.dequeueReusableCell(withIdentifier: NewsTextCell.reusedIdentifier, for: indexPath)
        }
    }
}
