//
//  ShowCellTableViewCell.swift
//  OzomeTV
//
//  Created by VICTOR ALEJANDRO REZA RODRIGUEZ on 2/11/21.
//

import UIKit
import AlamofireImage

class ShowCellTableViewCell: UITableViewCell {

    static let reuseIdentifier: String = "kShowCellTableViewCell"
    private let minHeight: CGFloat = 80.0
    private let detailsAttributes: Dictionary<NSAttributedString.Key, Any> = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
                                     NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func filloutCell(with displayedShow: VMDisplayedShow) {
        titleLabel.text = displayedShow.name
        descriptionLabel.attributedText = displayedShow.summary.htmlAttributedString(detailsAttributes)
        timeLabel.text = displayedShow.airtime
        thumbnailImageView.image = UIImage(systemName: "arrow.down.doc")
        if let validURL = displayedShow.imageURL {
            thumbnailImageView.af.setImage(withURL: validURL)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.af.cancelImageRequest()
        thumbnailImageView.image = nil
    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        let size = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
        return CGSize(width: size.width, height: max(size.height, minHeight))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
