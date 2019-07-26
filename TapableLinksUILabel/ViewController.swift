//
//  ViewController.swift
//  TapableLinksUILabel
//
//  Created by Aman Aggarwal on 24/07/19.
//  Copyright © 2019 Aman Aggarwal. All rights reserved.
//

import UIKit

//MARK - Fonts Constants
struct Fonts {
    
    static func heavyFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name:"Avenir-Heavy", size: size)!
    }
    
    static func mediumFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name:"Avenir-Medium", size: size)!
    }
}

struct Colors {
    
    static let carmine = UIColor.init(red: 169.0/255.0, green: 1.0/255.0, blue: 25.0/255.0, alpha: 1.0)
    
    static let greyColor = UIColor.init(red: 108.0/255.0, green: 108.0/255.0, blue: 108.0/255.0, alpha: 1.0)
}

class ViewController: UIViewController {

    @IBOutlet weak var lblTermsAndConditions: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var textArray = [String]()
        var fontArray = [UIFont]()
        var colorArray = [UIColor]()
        textArray.append("I accept")
        textArray.append("the general conditions")
        textArray.append("and")
        textArray.append("the cancellation policies")
        
        fontArray.append(Fonts.mediumFontWithSize(size: 17.0))
        fontArray.append(Fonts.heavyFontWithSize(size: 17.0))
        fontArray.append(Fonts.mediumFontWithSize(size: 17.0))
        fontArray.append(Fonts.heavyFontWithSize(size: 17.0))
        
        colorArray.append(Colors.greyColor)
        colorArray.append(Colors.carmine)
        colorArray.append(Colors.greyColor)
        colorArray.append(Colors.carmine)
        
        self.lblTermsAndConditions.attributedText = getAttributedString(arrayText: textArray, arrayColors: colorArray, arrayFonts: fontArray)
        
        self.lblTermsAndConditions.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
        tapgesture.numberOfTapsRequired = 1
        self.lblTermsAndConditions.addGestureRecognizer(tapgesture)
                
    }
    
    //MARK:- tappedOnLabel
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let text = self.lblTermsAndConditions.text else { return }
        let conditionsRange = (text as NSString).range(of: "the general conditions")
        let cancellationRange = (text as NSString).range(of: "the cancellation policies")
        
        if gesture.didTapAttributedTextInLabel(label: self.lblTermsAndConditions, inRange: conditionsRange) {
            print("user tapped on condition text")
            
            let alertcontroller = UIAlertController(title: "Tapped on", message: "user tapped on condition text", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (alert) in
                
            }
            alertcontroller.addAction(alertAction)
            self.present(alertcontroller, animated: true)
            
        } else if gesture.didTapAttributedTextInLabel(label: self.lblTermsAndConditions, inRange: cancellationRange){
            print("user tapped on cancellation text")
            let alertcontroller = UIAlertController(title: "Tapped on", message: "user tapped on cancellation text", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (alert) in
                
            }
            alertcontroller.addAction(alertAction)
            self.present(alertcontroller, animated: true)

        }
    }


    //MARK:- getAttributedString
    func getAttributedString(arrayText:[String]?, arrayColors:[UIColor]?, arrayFonts:[UIFont]?) -> NSMutableAttributedString {
        
        let finalAttributedString = NSMutableAttributedString()
        
        for i in 0 ..< (arrayText?.count)! {
            
            let attributes = [NSAttributedString.Key.foregroundColor: arrayColors?[i], NSAttributedString.Key.font: arrayFonts?[i]]
            let attributedStr = (NSAttributedString.init(string: arrayText?[i] ?? "", attributes: attributes as [NSAttributedString.Key : Any]))
            
            if i != 0 {
                
                finalAttributedString.append(NSAttributedString.init(string: " "))
            }
            
            finalAttributedString.append(attributedStr)
        }
        
        return finalAttributedString
    }
}

