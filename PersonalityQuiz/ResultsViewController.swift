//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Ednan R. Frizzera Filho on 25/05/23.
//

import UIKit

class ResultsViewController: UIViewController {

    var responses: [Answer]
    
    // Custom initializer because responses doesn't have an initial value nor it is even assigned a value in an initializer.
    init?(coder: NSCoder, responses: [Answer]) {        // The coder parameter is provided and used by UIKit
        self.responses = responses
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
