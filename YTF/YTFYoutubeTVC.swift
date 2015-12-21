//
//  YoutubeTVC.swift
//  NativeProjectBootstrap
//
//  Created by ingouackaz on 13/10/2015.
//  Copyright © 2015 Fancy Pants Games. All rights reserved.
//

import UIKit
import SwiftOverlays
import Alamofire
//import XCDYouTubeKit

class YTFYoutubeTVC: UITableViewController {

    
    var _feed : [YTFObject] = []
    var channelId : String?
    var parentNavigationController : UINavigationController?
    var _playerNC : UINavigationController?
    var countIndex : Int = 0
    var _isRequesting : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = UIImageView(image: UIImage(named: "yt-title"))

        UINavigationBar.appearance().translucent = true
        UINavigationBar.appearance().alpha = 0.7
        countIndex = 0

        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:YTFNavBarTitleColor]
        
      //  self.tableView.backgroundView = UIImageView(image:  UIImage(named: "fond-jaune")!)
        self.startPlaylistVideosRequest()
    }
    
    
    
    @IBAction func backAction(sender: AnyObject) {
    
        self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    
    func startPlaylistVideosRequest(){
    
        _isRequesting = true
        let text = "Chargement en cours ..."
        self.showWaitOverlayWithText(text)
        
        if let theChannelId = channelId {
        
        let url = YTFYoutubeUrlChannel + theChannelId
        request(.GET, url)
        .responseSwiftyJSON ({ (request, response, json, error) -> Void in

            let items = json["items"].arrayValue
            let feedSize : Int = items.count

            
            
            self._feed.removeAll()
            

            for (index,obj) in items.enumerate(){
            
                print("obj \(obj)")

                let vTitle : String = obj["snippet"]["title"].stringValue
                let vPublishedAt : String = obj["snippet"]["publishedAt"].stringValue
                let vID : String = obj["id"]["videoId"].stringValue
                let vimageUrl : String = obj["snippet"]["thumbnails"]["medium"]["url"].stringValue
                
                let videoObj : YTFObject = YTFObject(videoDescription: "", title: vTitle, videoId: vID, videoPublishedAt: vPublishedAt, imageUrl:vimageUrl,viewCount: "")
                
                if(obj["id"]["kind"].stringValue == "youtube#video"){
                    self._feed.append(videoObj)

                }
            
                
            }
            self.removeAllOverlays()
            
            self._feed.sortInPlace({ $0.videoDate.compare($1.videoDate) == .OrderedDescending })
            self.tableView.reloadData()
            
        })
        }
    }
    
    func startRequestViewCount(videoDescription:String, title:String, videoId:String, videoPublishedAt:String, imageUrl:String,feedSize:Int, index:Int) {
    
        
        let url:String =  YTFYoutubeCountVideo(videoId)
    
        request(.GET, url)
            .responseSwiftyJSON ({ (request, response, json, error) -> Void in
                
                let videoObj : YTFObject = YTFObject(videoDescription: videoDescription, title: title, videoId: videoId, videoPublishedAt: videoPublishedAt, imageUrl:imageUrl,viewCount: "")
                
                self.countIndex++

                self._feed.append(videoObj)
                
                if(self.countIndex + 1 == feedSize){
                    self.removeAllOverlays()
                    self._feed.sortInPlace({ $0.videoDate.compare($1.videoDate) == .OrderedDescending })
                    self.tableView.reloadData()

                }

            })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  self._feed.count
    }

    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        return UITableViewAutomaticDimension
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0){
            let cell = tableView.dequeueReusableCellWithIdentifier("TopCell", forIndexPath: indexPath) as! YoutubeTopCell
            
            let video =  _feed[indexPath.row]

            
            cell.titleLabel.text = video.videoTitle
            cell.thumbImageView.image = video.videoUrlThumbnail!
            cell.viewCountLabel.text = video.videoCount

            
            // Configure the cell...
            
            return cell
        
        }
        else{
        
            let cell = tableView.dequeueReusableCellWithIdentifier("NormalCell", forIndexPath: indexPath) as! YoutubeNormalCell
            
            let video =  _feed[indexPath.row]
            
            cell.titleLabel.text = video.videoTitle
            cell.thumbImageView.image = video.videoUrlThumbnail!
            cell.viewCountLabel.text = video.videoCount
            
            
            // Configure the cell...
            
            return cell
        }
        
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let video =  _feed[indexPath.row]

        print("video iD \(video.videoId)")
       // let videoPlayerViewController : XCDYouTubeVideoPlayerViewController = XCDYouTubeVideoPlayerViewController(videoIdentifier: video.videoId)
        
        
      //  _playerNC = UINavigationController(rootViewController: videoPlayerViewController)
      //  _playerNC!.navigationBarHidden =  true
       //
      //  NSNotificationCenter.defaultCenter().addObserver(self, selector:"playerPlaybackDidFinish", name: MPMoviePlayerPlaybackDidFinishNotification, object: nil)

        
    //    self.parentNavigationController?.presentViewController(_playerNC!, animated: true, completion: nil)

    }
    
    func playerPlaybackDidFinish(){
    
        _playerNC!
            .dismissViewControllerAnimated(true, completion: nil)
    }

    
    func getViewCount(idString:String){
        
        
        let url = YTFYoutubeCountVideo(idString)
        
        print("url \(url)")
        
        request(.GET, url)
            .responseSwiftyJSON ({ (request, response, json, error) -> Void in
                
                let viewCount : String = json["items"][0]["statistics"]["viewCount"].stringValue
                
               // viewCount.decodeEnt()
                
                
                //
                
                // print("response \(viewCount) ")
                
            })
        
    }
    

}
