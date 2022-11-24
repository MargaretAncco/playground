import Foundation // for Date

enum TypePet{
    case dog
    case cat
    case bird
    case rodent
    case other
}
extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents) ?? nil
    }
    static func yearsBetween(startDate: Date, endDate: Date)-> Int{
        let calendar = Calendar(identifier: .gregorian)
        let date1 = calendar.startOfDay(for: startDate)
        let date2 = calendar.startOfDay(for: endDate)
        let components = calendar.dateComponents([.day], from: date1, to: date2)
            return (components.day ?? 0 ) / 365
    }
}
class Pet{
    var race: String? = ""
    var birthDay: Date? = Date()
    var imageProfileUrl: String = ""
    var type: TypePet = TypePet.cat
    public var name: String = ""
    var yearsOld: Int {
        get{
            let date = Date()
            if let birthDay = birthDay{
                return Date.yearsBetween(startDate: birthDay, endDate: date)
            }
            return 0
        }
    }
    var smallDescription : String {
        return "\(self.name) is a(n) \(self.type) and it is \(self.yearsOld) year(s) old."
    }
    init(name: String){
        self.name = name
    }
    
    init(name: String, type: TypePet){
        self.name = name
        self.type = type
    }
    init(name: String, type: TypePet, birthDay: Date){
        self.name = name
        self.type = type
        self.birthDay = birthDay
    }
}

if let date = Date.from(year: 2021, month: 11, day: 23){
    var myPet = Pet(name: "Paco", type: TypePet.bird, birthDay: date)
    print (myPet.smallDescription)
}
