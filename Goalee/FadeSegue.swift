//
//  FadeSegue.swift
//  Goalee
//
//  Created by Mohammad Al-Ahdal on 2017-03-02.
//  Copyright © 2017 Mohammad Al-Ahdal. All rights reserved.
//

import UIKit

class FadeSegue: UIStoryboardSegue {
    
    override func perform() {
        
        self.source.view.addSubview(self.destination.view)
        //print(destination.view.center.y)
        //self.destination.view.center.y += self.source.view.frame.height/2
        //print(destination.view.center.y)
        self.destination.view.alpha = 0.0
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            () in
            self.source.view.center.y -= self.source.view.frame.height/2
            //self.source.view.center.y -= 0
            //self.destination.view.center.y -= self.destination.view.frame.height/2
            self.source.view.alpha -= 1.0
            //self.destination.view.alpha += 1.0
        }, completion: {
            (finished) in
            self.destination.view.removeFromSuperview()
            let dispTime = DispatchTime(uptimeNanoseconds: DispatchTime.now().uptimeNanoseconds + UInt64(0.001 * Double(NSEC_PER_SEC)))
            
            DispatchQueue.main.asyncAfter(deadline: dispTime, execute: {
                () in
                self.source.present(self.destination, animated: false, completion: {
                    () in
                    UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                        () in
                        //self.source.view.center.y -= self.source.view.frame.height/2
                        //self.source.view.center.y -= 0
                        //self.destination.view.center.y -= self.destination.view.frame.height/2
                        self.destination.view.alpha += 1.0
                        //self.destination.view.alpha += 1.0
                    }, completion:nil)
                })
            })
        })
    }
    
}
