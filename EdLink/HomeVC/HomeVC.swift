//
//  ViewController.swift
//  EdLink
//
//  Created by Muhammad Faruuq Qayyum on 08/01/21.
//

import UIKit
import SDWebImage

class HomeVC: UITableViewController {
    
    typealias DataSource = UITableViewDiffableDataSource<Int, Model.Results>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, Model.Results>
    
    var item: [Model.Results] = []
    private var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchingData()
        configureTableViewDataSource()
        navigationController?.navigationBar.isHidden = true
    }
    
}

extension HomeVC {
    
    fileprivate func fetchingData() {
        let endpoint = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=88a8b9b29d2fd7cd6c976f0b79c01ca3&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1")
        let session = URLSession.shared
        session.dataTask(with: endpoint!) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                DispatchQueue.global(qos: .userInitiated).async {
                    do {
                        let fetched = try JSONDecoder().decode(Model.self, from: data!)
                        DispatchQueue.main.async {
                            print(fetched.results[0].poster_path)
                            fetched.results.forEach { (item) in
                                let newItem = Model.Results(original_title: item.original_title, overview: item.overview, poster_path: item.poster_path)
                                self.item.append(newItem)
                                print(item)
                                self.applySnapshot(item: self.item)
                            }
                            
                        }
                    } catch let err {
                        print(err.localizedDescription)
                    }
                }
            }
        }.resume()
    }
    
    fileprivate func configureTableViewDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
            
            let cell = self.nibBundle?.loadNibNamed("HomeCell", owner: self, options: nil)?.first as! HomeCell
            let imgBaseUrl = "https://image.tmdb.org/t/p/w500"
            let finalUrl = ("\(imgBaseUrl)" + "\(item.poster_path)")
            
            cell.mainImage.sd_setImage(with: URL(string: finalUrl), placeholderImage: #imageLiteral(resourceName: "scroll2"), options: [.highPriority, .preloadAllFrames, .scaleDownLargeImages])
            cell.mainTitle.text = item.original_title
            cell.subtitle.text = item.overview
            return cell
        })
    }
    
    fileprivate func applySnapshot(item: [Model.Results]) {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(item)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}

extension HomeVC {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 514
    }
}

