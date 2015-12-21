//
//  Constant.swift
//  NativeProjectBootstrap
//
//  Created by ingouackaz on 08/10/2015.
//  Copyright © 2015 Fancy Pants Games. All rights reserved.
//

import UIKit

var nibView = NSBundle.mainBundle().loadNibNamed("HomeIcon", owner: nil, options: nil)[0] as! UIView

let YTFIconImages : [UIImage] = [UIImage(named: "menu-youtube")!, UIImage(named: "menu-jeu")!,UIImage(named: "menu-reseaux")!,UIImage(named: "menu-son")!]

let YTFDevice : Int = UIDevice.currentDevice().modelId.rawValue


let YTFAppSetting : NSDictionary = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("ApplicationSetting", ofType: "plist")!)!

var YTFNavBarColorStr : String = YTFAppSetting["navigationBarHexaColor"] as! String
var YTFNavBarTitleColorStr : String = YTFAppSetting["navigationBarHexaTitleColor"] as! String

var YTFYoutubeAPIKey : String = YTFAppSetting["YoutubeAPIKey"] as! String
var YTFYoutubeChannelId : String = YTFAppSetting["YoutubeChannelId"] as! String
var YTFYoutubePlayslistId : String = YTFAppSetting["YoutubePlayslistId"] as! String




var YTFNavBarColor : UIColor = UIColor(rgba: YTFNavBarColorStr)
var YTFNavBarTitleColor : UIColor = UIColor(rgba: YTFNavBarTitleColorStr)

let YTFYoutubeUrlChannel : String = "https://www.googleapis.com/youtube/v3/search?order=date&part=snippet&maxResults=25&key=\(YTFYoutubeAPIKey)&channelId="


let YTFYoutubeChannelsUrls : [Dictionary<String,String>] = YTFAppSetting["YoutubeChannelsUrls"] as! [Dictionary<String,String>]





let YTFSoundsName : [String] = YTFAppSetting["SoundsName"] as! [String]

let YTFImgSoundNamePrefix : String = "imgSoundCover"
enum YTFIcon : String {
    case Jeu = "Jeu", Photo = "Photo", Youtube = "Youtube", Reseaux = "Reseaux", Son = "Son"
    
    static let allValues = [Son,Youtube, Jeu,Reseaux,Photo]
}

var YTFFacebookId : String = YTFAppSetting["FacebookId"] as! String
var YTFFacebookPageName : String = YTFAppSetting["FacebookPageName"] as! String

var YTFInstagramUsername : String = YTFAppSetting["InstagramUsername"] as! String
var YTFTwitterUsername : String = YTFAppSetting["TwitterUsername"] as! String

var YTFVineId : String = YTFAppSetting["VineId"] as! String


//YTFYoutubeCountVideo


func YTFYoutubeCountVideo(videoId:String) -> String {
    let str :String =  "https://www.googleapis.com/youtube/v3/videos?part=statistics&id=\(videoId)&key=\(YTFYoutubeAPIKey)"
    
    return str
}

struct SocialNetworkUrl {
    let scheme: String
    let page: String
    
    func openPage() {
        let schemeUrl = NSURL(string: scheme)!
        if UIApplication.sharedApplication().canOpenURL(schemeUrl) {
            UIApplication.sharedApplication().openURL(schemeUrl)
        } else {
            UIApplication.sharedApplication().openURL(NSURL(string: page)!)
        }
    }
}

enum SocialNetwork {
    case Facebook, GooglePlus, Twitter, Instagram
    func url() -> SocialNetworkUrl {
        switch self {
        case .Facebook: return SocialNetworkUrl(scheme: "fb://profile/\(YTFFacebookId)", page: "https://www.facebook.com/\(YTFFacebookPageName)")
        case .Twitter: return SocialNetworkUrl(scheme: "twitter:///user?screen_name=\(YTFTwitterUsername)", page: "https://twitter.com/\(YTFTwitterUsername)")
        case .GooglePlus: return SocialNetworkUrl(scheme: "gplus://plus.google.com/u/0/PageId", page: "https://plus.google.com/PageId")
        case .Instagram: return SocialNetworkUrl(scheme: "instagram://user?username=\(YTFInstagramUsername)", page:"https://www.instagram.com/\(YTFInstagramUsername)")
    
        
        }
    }
    func openPage() {
        self.url().openPage()
    }
}


func downloadImage(urlString:String)-> UIImage {
    
    var active : UIImage = UIImage()
    print("url \(urlString)")
    
    if let data = NSData(contentsOfURL: NSURL(string:urlString)!){
        
        active =  UIImage(data: data)!

        print("img saved \(urlString)")
        return active
    }
    else {
        return active
    }
    // save in coredata
    
}