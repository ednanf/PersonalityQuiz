//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Ednan R. Frizzera Filho on 25/05/23.
//

import UIKit

class ResultsViewController: UIViewController {

// MARK: - IBOutlets
    
    @IBOutlet var resultAnswerLabel: UILabel!
    @IBOutlet var resultDefinitionLabel: UILabel!
    
// MARK: - Properties
    var responses: [Answer]
    
    
// MARK: - Setup
    // Custom initializer because responses doesn't have an initial value nor it is even assigned a value in an initializer.
    init?(coder: NSCoder, responses: [Answer]) {                           // The coder parameter is provided and used by UIKit
        self.responses = responses
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        
        calculatePersonalityResult()
    }

    
// MARK: - Functions
    
    func calculatePersonalityResult() {
        let frequencyOfAnswers = responses.reduce(into: [:]) {              // reduce is a method that iterates over each item, combining them into a single value using the code we provide.
            (counts, answer) in counts[answer.type, default: 0] += 1        // It takes 2 parameters, "(counts and answer) in", the first parameter is the item we're reducing into;
        }                                                                   // while the second parameter is the item from the collection for current iteration.
        
        let frequentAnswersSorted = frequencyOfAnswers.sorted(by:
        { (pair1, pair2) in
            return pair1.value > pair2.value
        })
        
        // Determines the most frequent answer
        let mostCommonAnswer = frequentAnswersSorted.first!.key
        
        // Updates the labels
        resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
        resultDefinitionLabel.text = mostCommonAnswer.definition
    }
    
    
    
}
