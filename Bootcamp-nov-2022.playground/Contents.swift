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
    static func yearsBetween(startDate: Date, endDate: Date){
        let time = startDate.timeIntervalSince(endDate)
//        time.
    }
}
class Pet{
    var race: String = ""
    var birthDay: Date? = Date()
    var imageProfileUrl: String = ""
    var type: TypePet = TypePet.cat
    public var name: String = ""
    var yearsOld: Int {
        get{
            return 0
        }
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

if let date = Date.from(year: 2021, month: 07, day: 07){
    var myPet = Pet(name: "Paco", type: TypePet.bird, birthDay: date)
    print (myPet.type)
}
