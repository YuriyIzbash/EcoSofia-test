import UIKit

final class HomeView: UIView {
    let topCollectionView: UICollectionView = {
        let layout = HomeLayouts.makeTopLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        return cv
    }()

    let bottomTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .appText
        label.text = "Категорії"
        return label
    }()

    let bottomCollectionView: UICollectionView = {
        let layout = HomeLayouts.makeBottomLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .appBackground
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .appBackground
        setupLayout()
    }

    private func setupLayout() {
        addSubview(topCollectionView)
        addSubview(bottomTitleLabel)
        addSubview(bottomCollectionView)

        let guide = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            // Top collection view: size 375x121 with horizontal padding 18, top 12, bottom 4 (height fixed to 121)
            topCollectionView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 12),
            topCollectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 18),
            topCollectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -18),
            topCollectionView.heightAnchor.constraint(equalToConstant: 121)
        ])

        NSLayoutConstraint.activate([
            // Bottom title label: 16pt below top block, leading 16, top padding 12 within its block, height 16
            bottomTitleLabel.topAnchor.constraint(equalTo: topCollectionView.bottomAnchor, constant: 16),
            bottomTitleLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            bottomTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: guide.trailingAnchor, constant: -16),
            bottomTitleLabel.heightAnchor.constraint(equalToConstant: 16)
        ])

        NSLayoutConstraint.activate([
            // Bottom collection view: inside the second block of height 522
            bottomCollectionView.topAnchor.constraint(equalTo: bottomTitleLabel.bottomAnchor, constant: 12),
            bottomCollectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            bottomCollectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16),
            bottomCollectionView.heightAnchor.constraint(equalToConstant: 522 - 12 - 16 - 12),
        ])
    }
}
