//
//  ImageTableViewCell.swift
//  UITableViewSettings
//
//  Created by Alexey Davidenko on 28.02.2022.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    static let identifier = "ImageTableCell"

    private let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()

    private let infoImageView: UIImageView = {
        let infoImageView = UIImageView()
        infoImageView.tintColor = .systemRed
        infoImageView.contentMode = .scaleAspectFit
        return infoImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.addSubview(label)
        contentView.addSubview(infoImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = contentView.frame.size.height - 12
        let infoSize: CGFloat = contentView.frame.size.height - 1
        iconContainer.frame = CGRect(x: 20, y: 6, width: size, height: size)

        let imageSize:CGFloat = size / 1.5
        let infoImageSize: CGFloat = infoSize / 1.5
        iconImageView.frame = CGRect(x: (size - imageSize) / 2, y: (size - imageSize) / 2, width: imageSize, height: imageSize)

        infoImageView.frame = CGRect(x: contentView.frame.size.width - infoImageView.frame.size.width - 40, y: (infoSize - infoImageSize) / 2, width: infoImageSize, height: infoImageSize)
        label.frame = CGRect(x: 35 + iconContainer.frame.size.width,
                             y: 0,
                             width: contentView.frame.size.width - 20 - iconContainer.frame.size.width,
                             height: contentView.frame.size.height)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        iconContainer.backgroundColor = nil
        iconImageView.image = nil
        label.text = nil
        infoImageView.image = nil
    }

    public func configure(with model: SettingsInfoImageOption) {
        iconContainer.backgroundColor = model.iconBackGroundColor
        iconImageView.image = model.icon
        label.text = model.title
        infoImageView.image = model.infoImage
    }
}
