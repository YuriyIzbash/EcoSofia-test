import UIKit

protocol TopHeaderViewDelegate: AnyObject {
    func topHeaderViewDidTapSeeAll()
}

final class TopHeaderView: UICollectionReusableView {
    
    static let reuseID = "TopHeaderView"
    
    weak var delegate: TopHeaderViewDelegate?
    
    private let leftLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .appText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rightLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .appText
        label.textAlignment = .right
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [leftLabel, rightLabel])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleSeeAllTap))
        rightLabel.addGestureRecognizer(tap)
    }

    @objc private func handleSeeAllTap() {
        delegate?.topHeaderViewDidTapSeeAll()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        setupGestures()
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(left: String, right: String) {
        leftLabel.text = left
        rightLabel.text = right
    }
}
