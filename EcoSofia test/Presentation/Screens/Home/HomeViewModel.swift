import Foundation

class HomeViewModel {
    struct Partner {
        let imageName: String
    }
    
    struct Category {
        let imageName: String
        let title: String
    }
    
    let partners: [Partner]
    let categories: [Category]
    
    init() {
        self.partners = [
            Partner(imageName: "partnerCard1"),
            Partner(imageName: "partnerCard2"),
            Partner(imageName: "partnerCard3"),
            Partner(imageName: "partnerCard4")
        ]
        
        self.categories = [
            Category(imageName: "card1", title: "Страхування"),
            Category(imageName: "card2", title: "Преміум"),
            Category(imageName: "card3", title: "Заклади"),
            Category(imageName: "card4", title: "Лабораторії"),
            Category(imageName: "card5", title: "Комунальні \nпослуги"),
            Category(imageName: "card6", title: "Зв’язок"),
            Category(imageName: "card7", title: "Розваги"),
            Category(imageName: "card8", title: "Транспорт")
        ]
    }
}
