import UIKit

struct HomeLayouts {
    static func makeTopLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(70), heightDimension: .absolute(70))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(70), heightDimension: .absolute(70))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(19)

        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 19
            section.orthogonalScrollingBehavior = .continuous
            
            let containerWidth = environment.container.effectiveContentSize.width
            let bottomGroupWidth = CGFloat(164 * 2 + 15)
            let leadingInset = max(0, (containerWidth - bottomGroupWidth) / 2)
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: leadingInset, bottom: 16, trailing: 0)

            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(16))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]

            return section
        }
        return layout
    }

    static func makeBottomLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(164), heightDimension: .absolute(107))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupWidth = 164 * 2 + 15
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(CGFloat(groupWidth)), heightDimension: .absolute(107))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(15)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16

        section.contentInsetsReference = .none
        section.contentInsets = .zero

        section.contentInsets = .zero
        section.interGroupSpacing = 16

        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            let containerWidth = environment.container.effectiveContentSize.width
            let groupWidth = CGFloat(164 * 2 + 15)
            let inset = max(0, (containerWidth - groupWidth) / 2)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 16
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: inset, bottom: 0, trailing: inset)
            return section
        }
        return layout
    }
}
