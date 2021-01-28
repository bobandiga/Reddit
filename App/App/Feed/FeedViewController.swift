//
//  FeedViewController.swift
//  App
//
//  Created by Максим Шаптала on 27.01.2021.
//

import UIKit

final class FeedViewController: UITableViewController {
    
    private lazy var feedManager: FeedManager = MockFeedManager()
    private lazy var controll: UIRefreshControl = { [unowned self] in
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(didRefreshControll), for: .valueChanged)
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = controll
    }
    
    //
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedManager.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.id, for: indexPath) as? FeedCell else {
            fatalError()
        }
        cell.selectionStyle = .none
        cell.model = feedManager.dataSource[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == feedManager.dataSource.count - 1 {
            showSpinner()
            feedManager.loadMore { [unowned self] (posts) in
                hideSpinner()
                tableView.reloadData()
            }
        }
    }
    
}

private extension FeedViewController {
    
    @objc
    func didRefreshControll() {
        feedManager.loadFirst { [unowned self] in
            refreshControl?.endRefreshing()
            tableView.reloadData()
        }
    }
    
    func showSpinner() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
    }
    
    func hideSpinner() {
        tableView.tableFooterView?.isHidden = true
    }
    
}