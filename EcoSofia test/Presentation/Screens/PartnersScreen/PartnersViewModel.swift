import Foundation

final class PartnersViewModel {
    struct Partner {
        let imageName: String
    }

    private let basePartners: [Partner] = [
        Partner(imageName: "partnerCard1"),
        Partner(imageName: "partnerCard2"),
        Partner(imageName: "partnerCard3"),
        Partner(imageName: "partnerCard4")
    ]

    let partners: [Partner]

    init(duplicateTimes: Int = 3) {
        var array: [Partner] = []
        for _ in 0..<duplicateTimes {
            array.append(contentsOf: basePartners)
        }
        self.partners = array
    }
}
