//
//  ViewController.swift
//  EcoSofia test
//
//  Created by yuriy on 16. 10. 25.
//

import UIKit

final class ViewController: UIViewController {
    

    // MARK: - Views
    private let topCollectionView: UICollectionView = {
        let layout = ViewController.makeTopLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        return cv
    }()

    private let bottomTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .appText
        label.text = "Категорії"
        return label
    }()

    private let bottomCollectionView: UICollectionView = {
        let layout = ViewController.makeBottomLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        return cv
    }()

    // MARK: - Data
    private let topPartnerImages = [
        "partnerCard1",
        "partnerCard2",
        "partnerCard3",
        "partnerCard4"
    ]
    private let bottomCardImages = [
        "card1",
        "card2",
        "card3",
        "card4",
        "card5",
        "card6",
        "card7",
        "card8"
    ]
    private let bottomTitles = [
        "Страхування",
        "Преміум",
        "Заклади",
        "Лабораторії",
        "Комунальні \nпослуги",
        "Зв’язок",
        "Розваги",
        "Транспорт"
    ]

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBackground
        setupCollectionViews()
        setupLayout()
    }
}

// MARK: - Setup
private extension ViewController {
    func setupCollectionViews() {
        // Top collection registrations
        topCollectionView.register(TopCircleCell.self, forCellWithReuseIdentifier: TopCircleCell.reuseID)
        topCollectionView.register(TopHeaderView.self,
                                   forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                   withReuseIdentifier: TopHeaderView.reuseID)
        topCollectionView.dataSource = self
        topCollectionView.isScrollEnabled = false
        topCollectionView.alwaysBounceVertical = false
        topCollectionView.showsVerticalScrollIndicator = false

        // Bottom collection registrations
        bottomCollectionView.register(BottomGridCell.self, forCellWithReuseIdentifier: BottomGridCell.reuseID)
        bottomCollectionView.dataSource = self
    }

    func setupLayout() {
        // Add subviews
        view.addSubview(topCollectionView)
        view.addSubview(bottomTitleLabel)
        view.addSubview(bottomCollectionView)

        // Constraints
        let guide = view.safeAreaLayoutGuide

        // Top collection view: size 375x121 with horizontal padding 18, top 12, bottom 4 (height fixed to 121)
        NSLayoutConstraint.activate([
            topCollectionView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 12),
            topCollectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 18),
            topCollectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -18),
            topCollectionView.heightAnchor.constraint(equalToConstant: 121)
        ])

        // Bottom title label: 16pt below top block, leading 16, top padding 12 within its block, height 16
        // We place it 16pt below topCollectionView's bottom
        NSLayoutConstraint.activate([
            bottomTitleLabel.topAnchor.constraint(equalTo: topCollectionView.bottomAnchor, constant: 16),
            bottomTitleLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            bottomTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: guide.trailingAnchor, constant: -16),
            bottomTitleLabel.heightAnchor.constraint(equalToConstant: 16)
        ])

        // Bottom collection view: inside the second block of height 522
        NSLayoutConstraint.activate([
            bottomCollectionView.topAnchor.constraint(equalTo: bottomTitleLabel.bottomAnchor, constant: 12), // 12 from text
            bottomCollectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            bottomCollectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16),
            bottomCollectionView.heightAnchor.constraint(equalToConstant: 522 - 12 - 16 - 12),
            // Explanation: Total block height is 522. Title has top 12 and height 16, then 12 spacing to grid.
            // We fix the grid height so the block overall aligns with the requested 522 height visually.
        ])
    }
}

// MARK: - Layouts
private extension ViewController {
    static func makeTopLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(70), heightDimension: .absolute(70))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(70), heightDimension: .absolute(70))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(19)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 19
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 4, trailing: 0)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(16))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        section.boundarySupplementaryItems = [header]

        return UICollectionViewCompositionalLayout(section: section)
    }

    static func makeBottomLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(164), heightDimension: .absolute(107))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupHeight: CGFloat = 107
        let groupWidth: CGFloat = 164 * 2 + 15
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(groupWidth),
                                               heightDimension: .absolute(groupHeight))

        let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { _, environment in
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
            group.interItemSpacing = .fixed(15)

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 16

            let containerWidth = environment.container.effectiveContentSize.width
            let horizontalInset = max(0, floor((containerWidth - groupWidth) / 2))
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: horizontalInset, bottom: 0, trailing: horizontalInset)
            return section
        }

        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
}

// MARK: - DataSource
extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === topCollectionView { return topPartnerImages.count }
        return bottomCardImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === topCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCircleCell.reuseID, for: indexPath) as! TopCircleCell
            let imageName = topPartnerImages[indexPath.item]
            cell.configure(imageName: imageName)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BottomGridCell.reuseID, for: indexPath) as! BottomGridCell
            let imageName = bottomCardImages[indexPath.item]
            let title = bottomTitles[indexPath.item]
            cell.configure(imageName: imageName, text: title)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView === topCollectionView && kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TopHeaderView.reuseID, for: indexPath) as! TopHeaderView
            header.configure(left: "Партнери", right: "Дивитися всіх")
            return header
        }
        return UICollectionReusableView()
    }
}

// MARK: - Cells & Supplementary Views
private final class TopCircleCell: UICollectionViewCell {
    static let reuseID = "TopCircleCell"

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 35
        contentView.layer.masksToBounds = true
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func configure(imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
}

private final class TopHeaderView: UICollectionReusableView {
    static let reuseID = "TopHeaderView"

    private let leftLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        l.textColor = .appText
        l.text = "Партнери"
        return l
    }()

    private let rightLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        l.textColor = .appText
        l.textAlignment = .right
        l.text = "Дивитися всіх"
        return l
    }()

    private let stack: UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .horizontal
        s.alignment = .fill
        s.distribution = .equalSpacing
        return s
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stack)
        stack.addArrangedSubview(leftLabel)
        stack.addArrangedSubview(rightLabel)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func configure(left: String, right: String) {
        leftLabel.text = left
        rightLabel.text = right
    }
}

private final class BottomGridCell: UICollectionViewCell {
    static let reuseID = "BottomGridCell"

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    private let label: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        l.textAlignment = .center
        l.textColor = .appCategoryText
        l.numberOfLines = 2
        l.lineBreakMode = .byWordWrapping
        return l
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func configure(imageName: String, text: String) {
        imageView.image = UIImage(named: imageName)
        label.text = text
    }
}

