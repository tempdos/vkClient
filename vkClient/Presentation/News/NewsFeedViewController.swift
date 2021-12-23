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
    
    private var newsItems: [Item] = []
    private var newsProfiles: [Profile] = []
    private var newsGroups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: NewsTextCell.reusedIdentifier, bundle: nil), forCellReuseIdentifier: NewsTextCell.reusedIdentifier)
        tableView.register(UINib(nibName: NewsPhotoCell.reusedIdentifier, bundle: nil), forCellReuseIdentifier: NewsPhotoCell.reusedIdentifier)
        tableView.register(UINib(nibName: NewsAuthorAndDateCell.reusedIdentifier, bundle: nil), forCellReuseIdentifier: NewsAuthorAndDateCell.reusedIdentifier)
        tableView.register(UINib(nibName: NewsLikesAndCommentsCell.reusedIdentifier, bundle: nil), forCellReuseIdentifier: NewsLikesAndCommentsCell.reusedIdentifier)
        getData()
    }
    
    func getData() {
        newsFeedAPI.getNewsFeed { [weak self] news in
            guard let self = self else { return }
            self.newsItems = news!.response.items
            self.newsGroups = news!.response.groups
            self.newsProfiles = news!.response.profiles
            
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return newsItems.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentNews = newsItems[section]
        var count = 1
        
        if currentNews.hasText { count += 1 }
        if currentNews.hasPhoto604 { count += 1 }
        if currentNews.hasLink { count += 1 }
        
        return  count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentNewsItem = newsItems[indexPath.section]
        
        switch indexPath.row {
        case 0: return newsInfoCell(indexPath: indexPath)
        case 1: return currentNewsItem.hasText ? newsTextCell(indexPath: indexPath) : newsPhotoCell(indexPath: indexPath)
        case 2: return currentNewsItem.hasLink ? newsLinkCell(indexPath: indexPath) : newsPhotoCell(indexPath: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    func newsInfoCell(indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsItemInfoCell", for: indexPath) as! NewsItemInfoTableViewCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        
        let currentNewsItem = newsItems[indexPath.section]
        
        switch newsItems[indexPath.section].sourceID.signum() {
        
        case 1: // Пост пользователя
            let currentNewsItemProfile = newsProfiles.filter{ $0.id == currentNewsItem.sourceID }[0]
            cell.configure(profile: currentNewsItemProfile, postDate: currentNewsItem.date)
            
        case -1: // Пост группы
            let currentNewsItemGroup = newsGroups.filter{ $0.id == abs(currentNewsItem.sourceID) }[0]
            cell.configure(group: currentNewsItemGroup, postDate: currentNewsItem.date)
            
        default: break
        }
        
        return cell
    }
    
    func newsTextCell(indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTextCell", for: indexPath) as! NewsTextCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        
        let currentNewsItem = newsItems[indexPath.section]
        
        if currentNewsItem.hasText {
            
            cell.configure(text: currentNewsItem.text,
                           expanded: expandedIndexSet.contains(indexPath.section),
                           readMoreHandler: {
                            self.tableView.beginUpdates()
                            self.tableView.endUpdates()
                            self.expandedIndexSet.insert(indexPath.section)
                           })
            return cell
            
        } else { return UITableViewCell() }
    }
    
    func newsLinkCell(indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsItemLinkCell", for: indexPath) as! NewsItemLinkCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        
        let currentNewsItem = newsItems[indexPath.section]
        
        if currentNewsItem.hasLink {
            
            cell.configure(link: currentNewsItem.attachments![0].link!)
            return cell
            
        } else { return UITableViewCell() }
    }
    
    func newsPhotoCell(indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsPhotoCell", for: indexPath) as! NewsPhotoCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        
        let currentNewsItem = newsItems[indexPath.section]
        
        if currentNewsItem.hasPhoto {
            
            cell.configure(url: currentNewsItem.attachments![0].photo!.photoAvailable!.url)
            return cell
            
        } else {
            
            return UITableViewCell()
            
        }
    }
}
