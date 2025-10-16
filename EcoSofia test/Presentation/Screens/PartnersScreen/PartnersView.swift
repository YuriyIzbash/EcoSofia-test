import UIKit

final class PartnersView: UIView {
    let collectionView: UICollectionView = {
        let layout = PartnersView.makeLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .appBackground
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .appBackground
        setup()
    }

    private func setup() {
        addSubview(collectionView)
        let guide = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
}

extension PartnersView {
    static func makeLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(70), heightDimension: .absolute(70))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let groupWidth: CGFloat = 334
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(groupWidth), heightDimension: .absolute(70))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 4)
        group.interItemSpacing = .fixed(18)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            let containerWidth = environment.container.effectiveContentSize.width
            let leadingInset = max(0, (containerWidth - groupWidth) / 2)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 18
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: leadingInset, bottom: 0, trailing: 0)
            section.orthogonalScrollingBehavior = .none
            return section
        }
        return layout
    }
}
