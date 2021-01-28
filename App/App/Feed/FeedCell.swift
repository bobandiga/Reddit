//
//  FeedCell.swift
//  App
//
//  Created by Максим Шаптала on 27.01.2021.
//

import UIKit

final class FeedCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var bodyLabel: UILabel?
    @IBOutlet private weak var numberOfComments: UILabel?
    @IBOutlet private weak var thumbImageView: LoadImageView?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        thumbImageView?.cancelLoad()
        bodyLabel?.text = nil
        titleLabel?.text = nil
        numberOfComments?.text = nil
    }
    
    var model: FeedPost? {
        didSet {
            guard let model = model else { return }
            
            setupTitle(for: model.author, date: model.createdDate)
            setupBody(for: model.title)
            setupComments(for: model.comments)
            setupImageView(for: model.thumbPath)
        }
    }
    
    func endDisplay() {
        thumbImageView?.cancelLoad()
        bodyLabel?.text = nil
        titleLabel?.text = nil
        numberOfComments?.text = nil
    }
    
}

private extension FeedCell {
    func setupImageView(for string: String?) {
        guard let imageView = thumbImageView else { return }
        guard let urlString = string else {
            return
        }
        imageView.loadImage(string: urlString)
    }
    
    func setupTitle(for author: String?, date: String?) {
        guard let label = titleLabel else { return }
        let string = NSMutableAttributedString(string: "")
        if let authorString = author {
            string.append(NSAttributedString(string: authorString, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]))
        }
        
        if author != nil && date != nil {
            string.append(NSAttributedString(string: "\u{2000}"))
        }
    
        if let dateString = date {
            string.append(NSAttributedString(string: dateString, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .thin)]))
        }
        
        label.attributedText = string
    }
    
    func setupComments(for int: Int?) {
        guard let label = numberOfComments else { return }
        if let number = int, number > 0 {
            label.attributedText = NSAttributedString(string: "\(number) comments", attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue])
        } else {
            label.attributedText = NSAttributedString(string: "no comments", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
    
    func setupBody(for string: String?) {
        guard let label = bodyLabel else { return }
        label.text = string
    }
}

extension FeedCell {
    static var id: String {
        return "FeedCell"
    }
}
