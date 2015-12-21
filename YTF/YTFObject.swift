//
//  YTFObject.swift
//  NativeProjectBootstrap
//
//  Created by ingouackaz on 13/10/2015.
//  Copyright © 2015 Fancy Pants Games. All rights reserved.
//

import UIKit
import Alamofire

class YTFObject {

    
    var videoDescription : String = ""
    var videoId : String = ""

    var videoTitle : String = ""

    var videoPublishedAt : String = ""

    var videoUrlThumbnail: UIImage?
    var videoCount: String = ""

    var videoDate : NSDate = NSDate()

    
    
    init (videoDescription:String, title:String, videoId:String, videoPublishedAt:String, imageUrl:String, viewCount:String) {
    
        self.videoDescription = videoDescription
        self.videoTitle = title
        self.videoId = videoId
        self.videoPublishedAt = videoPublishedAt
        self.videoUrlThumbnail =  downloadImage(imageUrl)
        self.videoCount = viewCount
        
        self.videoDate = videoPublishedAt.toDateTime()
    }
    
    func getViewCount(){
    
        
     let url = YTFYoutubeCountVideo(self.videoId)
        
        print("url \(url)")

        Alamofire.request(.GET, url)
        
        
        
        Alamofire.request(.GET, url)
            .responseSwiftyJSON ({ (request, response, json, error) -> Void in
                
                let viewCount : String = json["items"][0]["statistics"]["viewCount"].stringValue
                
                
              //
                self.videoCount = (Int(viewCount)?.addSpaceSeparator)! + " vues"
                
               // print("response \(viewCount) ")
                
            })
    
    }
    
    
}
