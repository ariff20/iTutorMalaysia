//
//  CheckInternet.swift
//  iTutor
//
//  Created by Sharifah Nazreen Ashraff ali on 30/03/2016.
//  Copyright © 2016 Syed Mohamed Ariff. All rights reserved.
//

import Foundation
import UIKit

struct CheckInternet
{
    static func checkInternet(flag:Bool, completionHandler:(internet:Bool) -> Void)
    {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let url = NSURL(string: "https://www.google.com/")
        let request = NSMutableURLRequest(URL: url!)
        
        request.HTTPMethod = "HEAD"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        
        NSURLConnection.sendAsynchronousRequest(request, queue:NSOperationQueue.mainQueue(), completionHandler:
            {(response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
                let rsp = response as! NSHTTPURLResponse?
                
                completionHandler(internet:rsp?.statusCode == 200)
        })
    }
    static func reportLoginFailureWithShake(view:UIView,controller:UIViewController) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.delegate = controller
        animation.duration = 0.10
        animation.repeatCount = 6
        animation.autoreverses = true
        
        let fromPoint = CGPointMake(view.center.x - 20.0, view.center.y)
        animation.fromValue = NSValue(CGPoint: fromPoint)
        
        let toPoint = CGPointMake(view.center.x + 20.0, view.center.y)
        animation.toValue = NSValue(CGPoint: toPoint)
        
       view.layer.addAnimation(animation, forKey: "position")
    }
}