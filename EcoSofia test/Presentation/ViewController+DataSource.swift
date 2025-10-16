import UIKit

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == homeView.topCollectionView {
            return viewModel.partners.count
        } else {
            return viewModel.categories.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == homeView.topCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCircleCell.reuseID, for: indexPath) as? TopCircleCell else {
                fatalError("Unable to dequeue TopCircleCell")
            }
            let partner = viewModel.partners[indexPath.item]
            cell.configure(imageName: partner.imageName)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BottomGridCell.reuseID, for: indexPath) as? BottomGridCell else {
                fatalError("Unable to dequeue BottomGridCell")
            }
            let category = viewModel.categories[indexPath.item]
            cell.configure(imageName: category.imageName, text: category.title)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader && collectionView == homeView.topCollectionView {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TopHeaderView.reuseID, for: indexPath) as? TopHeaderView else {
                fatalError("Unable to dequeue TopHeaderView")
            }
            header.configure(left: "Партнери", right: "Дивитися всіх")
            header.delegate = self
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == homeView.topCollectionView {
            return .zero
        }
        return .zero
    }
}

extension ViewController: TopHeaderViewDelegate {
    func topHeaderViewDidTapSeeAll() {
        let vc = PartnersViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
