//
//  ViewController.swift
//  Project18
//
//  Created by Edgaras Blauzdys on 2023-01-12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("I'm inside the viewDidLoad() method!")
        print(1, 2, 3, 4, 5, separator: "-")
        //this will produce no line break after print()
        print("Some message", terminator: "")

        //asserts will be ignored on release version!
        //Will do nothing
        assert(1 == 1, "Math failure!")
        //Will fail, condition is not met
        assert(1 == 2, "Math failure!")
        
        //assert(myReallySlowMethod() == true, "The slow method returned false, which is a bad thing!")
        
        //type p i into console to print current i value
        for i in 1...100 {
            print("Got number \(i). ")
        }
    }


}

