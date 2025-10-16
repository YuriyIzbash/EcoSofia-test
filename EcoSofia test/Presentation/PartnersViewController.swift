import UIKit

final class PartnersViewController: UIViewController, UICollectionViewDataSource {

    private let partnersView = PartnersView()
    private let viewModel = PartnersViewModel()

    override func loadView() {
        view = partnersView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Партнери"
        partnersView.collectionView.dataSource = self
        partnersView.collectionView.register(TopCircleCell.self, forCellWithReuseIdentifier: TopCircleCell.reuseID)
    }

    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.partners.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCircleCell.reuseID, for: indexPath) as? TopCircleCell else {
            fatalError("Unable to dequeue TopCircleCell")
        }
        let partner = viewModel.partners[indexPath.item]
        cell.configure(imageName: partner.imageName)
        return cell
    }
}
