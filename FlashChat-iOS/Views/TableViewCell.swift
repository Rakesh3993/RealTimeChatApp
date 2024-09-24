//
//  TableViewCell.swift
//  FlashChat-iOS
//
//  Created by Rakesh Kumar on 01/05/24.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifier = "TableViewCell"
    
    private var textMessages: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .natural
        return label
    }()
    
    public lazy var customView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightgreen
        view.addSubview(textMessages)
        view.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            textMessages.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            textMessages.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            textMessages.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -3),
            textMessages.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        return view
    }()
    
    public var meLogoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "MeAvatar")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public var youLogoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "YouAvatar")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [youLogoImage, customView, meLogoImage])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .top
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.distribution = .fill
        NSLayoutConstraint.activate([
            customView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 50),
            customView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -50)
        ])
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [horizontalStackView].forEach(contentView.addSubview)
        addConstraints()
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Message){
        textMessages.text = model.body
    }
}
