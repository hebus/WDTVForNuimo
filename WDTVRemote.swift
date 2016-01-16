//
//  WDTVRemote.swift
//  NuimoDemoOSX
//
//  Created by Olivier on 14/01/2016.
//

import Foundation
import NuimoSwift

public class WDTVRemote : NSObject{
    
    static let sharedInstance = WDTVRemote()
    
    
    func sendNuimoGestureEvent(event: NuimoGestureEvent){
        var stringPost:String
        switch(event.gesture.identifier){
        case "RotateLeft","SwipeLeft":
            stringPost = self.Left
        case "RotateRight","SwipeRight":
            stringPost = self.Right
        case "SwipeUp":
            stringPost = self.Up
        case "SwipeDown":
            stringPost = self.Down
        case "ButtonPress":
            stringPost = self.Power
        default:
            stringPost = "c"
        }

        httpRequest(stringPost)
    }

    private func remoteCommand(input:String) -> String{
        return "{\"remote\":\"\(input)\"}"
    }

    private func httpRequest(input:String){
        // use : wdtvlive.local if your model is a WDTV LIVE instead
        let urlPath: String = "http://wdtv.local/cgi-bin/toServerValue.cgi"
        let url: NSURL = NSURL(string: urlPath)!
        let request1: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        request1.HTTPMethod = "POST"
        
        let data = input.dataUsingEncoding(NSUTF8StringEncoding)
        
        // il faut spécifier cette ligne pour que les guillemets soient correctement
        // reconnu par le WDTV
        request1.setValue("application/json", forHTTPHeaderField: "content-type")
        request1.timeoutInterval = 60
        request1.HTTPBody=data
        request1.HTTPShouldHandleCookies=false
        
        NSURLConnection.sendAsynchronousRequest(request1, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) in
            let string = NSString(data: data!, encoding: NSISOLatin1StringEncoding)
            print("Command \(input)")
            print("Response \(string!)")
        }
    }

    // WDTV remote commands list
    var Power: String{ return remoteCommand("w")}
    var Home: String{ return remoteCommand("o")}
    var Subtitle: String{ return remoteCommand("\\")}
    var Audio: String{ return remoteCommand(",")}
    var Rewind: String{ return remoteCommand("[")}
    var Forward: String{ return remoteCommand("]")}
    var Stop: String{ return remoteCommand("t")}
    var Play: String{ return remoteCommand("p")}
    var Previous: String{ return remoteCommand("H")}
    var Next: String{ return remoteCommand("I")}
    var Back: String{ return remoteCommand("T")}
    var Options: String{ return remoteCommand("G")}
    var PreviousPage: String{ return remoteCommand("U")}
    var NextPage: String{ return remoteCommand("D")}
    var Up: String{ return remoteCommand("u")}
    var Down: String{ return remoteCommand("d")}
    var Left: String{ return remoteCommand("l")}
    var Right: String{ return remoteCommand("r")}
    var Select: String{ return remoteCommand("n")}
    var Mute: String{ return remoteCommand("M")}
    var Setup: String{ return remoteCommand("s")}
    var Eject: String{ return remoteCommand("X")}
    var A: String{ return remoteCommand("x")}
    var B: String{ return remoteCommand("y")}
    var C: String{ return remoteCommand("z")}
    var D: String{ return remoteCommand("A")}
}