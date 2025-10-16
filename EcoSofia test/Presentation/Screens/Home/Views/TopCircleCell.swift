import UIKit

final class TopCircleCell: UICollectionViewCell {
    static let reuseID = "TopCircleCell"
    static let placeholderImageName = "placeholder"
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        contentView.layer.cornerRadius = 35
        contentView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(imageName: String) {
        if let customImage = UIImage(named: imageName) {
            imageView.image = customImage
        }
        else if let systemImage = UIImage(systemName: imageName) {
            imageView.image = systemImage
        }
        else {
            imageView.image = UIImage(named: TopCircleCell.placeholderImageName)
        }
    }
}
