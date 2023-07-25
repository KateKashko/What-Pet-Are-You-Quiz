//
//  Question.swift
//  What Pet Are You? Quiz
//
//  Created by Kate Kashko on 25.07.2023.
//
import UIKit

struct Question {
    let title: String
    let responseType: ResponseType
    let answers: [Answer]
    
    static func getQuestions() -> [Question] {
        [
            Question(
                title: "What kind of food do you prefer?",
                responseType: .single,
                answers: [
                    Answer(title: "Steak", animal: .dog),
                    Answer(title: "Fish", animal: .cat),
                    Answer(title: "Carrot", animal: .rabbit),
                    Answer(title: "Corn", animal: .turtle)
                ]
            ),
            Question(
                title: "What do you like more?",
                responseType: .multiple,
                answers: [
                    Answer(title: "Swim", animal: .dog),
                    Answer(title: "Sleep", animal: .cat),
                    Answer(title: "Hug", animal: .rabbit),
                    Answer(title: "Eat", animal: .turtle)
                ]
            ),
            Question(
                title: "Do you like car trips?",
                responseType: .ranged,
                answers: [
                    Answer(title: "Hate", animal: .cat),
                    Answer(title: "Nervous", animal: .rabbit),
                    Answer(title: "Don't care", animal: .turtle),
                    Answer(title: "Adore", animal: .dog)
                ]
            )
        ]
    }
}

enum ResponseType {
    case single
    case multiple
    case ranged
}

struct Answer {
    let title: String
    let animal: Animal
}

enum Animal  {
    case dog
    case cat
    case rabbit
    case turtle
    
    var image: UIImage? {
        switch self {
            
        case .dog:
            return UIImage(named: "Dog")
        case .cat:
            return UIImage(named: "Cat")
        case .rabbit:
            return UIImage(named: "Rabbit")
        case .turtle:
            return UIImage(named: "Turtle")
        }
    }
    var definition: String {
        switch self {
        case .dog:
            return "You like being with friends. You surround yourself with people who you like and who are always ready to help."
        case .cat:
            return "You are on your mind. Love to walk on your own. You value solitude."
        case .rabbit:
            return "You like everything soft. You are healthy and full of energy."
        case .turtle:
            return "Your strength is in wisdom. Slow and thoughtful wins over long distances."
        }
    }
}
