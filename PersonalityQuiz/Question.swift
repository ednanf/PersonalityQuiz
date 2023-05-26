//
//  Question.swift
//  PersonalityQuiz
//
//  Created by Ednan R. Frizzera Filho on 25/05/23.
//

// This file defines all the structures necessary for this app!

//
//                    var text: String                 case multiple
//                  /                                /
// struct Question – var type: ResponseType -------- case single
//                  \                                \
//                   \                                 case ranged
//                    \                                                       case dog
//                      var answers: [Answer] - var text: String            /   case cat
//                                            \                           /   /
//                                              var type: AnimalType ---------- case rabbit                                case dog
//                                                                   \        \                                          /
//                                                                    \         case turtle                            /    case cat
//                                                                     \                                             /    /
//                                                                      var definition: String --- switch self  ---------- case rabbit
//                                                                                                                        \
//                                                                                                                          case turtle

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]               // If the array was of type String, it would be difficult to associate an answer with a particular result.
}

enum ResponseType {
    case single, multiple, ranged       // Defines all 3 input methods.
}

struct Answer {
    var text: String
    var type: AnimalType                // Ties the answer to a specific result.
}

enum AnimalType: Character {
    case dog = "🐩", cat = "🐈", rabbit = "🐇", turtle = "🐢"
    
    // Quiz's outcome - It's easier to have it inside this enum.
    var definition: String {
        switch self {
        case .dog:
            return "You are incredibly outgoing. You surround yourself with the people you love and enjoy activities with your friends."
        case .cat:
            return "Mischievous, yet mild-tempered, you enjoy doing things on your own terms."
        case .rabbit:
            return "You love everything that's soft. You are healtgy and full of energy."
        case .turtle:
            return "You are wise beyond your years, and you focus on the details. Slow and steady wins the race."
        }
    }
}


