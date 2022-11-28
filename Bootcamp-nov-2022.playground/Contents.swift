import Foundation
let input = "la historia de mi vida"

var dictionaryLetterCount: [Character: Int] = [Character: Int]()
var orderLetters: [Character] = [Character]()
for char in input{
    if dictionaryLetterCount[char] != nil{
        dictionaryLetterCount[char]!+=1
    }else{
        dictionaryLetterCount[char]=1
        orderLetters.append(char)
    }
}
for (index,char) in orderLetters.enumerated(){
    if let value = dictionaryLetterCount[char] {
        if char != Character(" "){
            print("\(orderLetters[index]) = \(value)")
        }
    }
}
