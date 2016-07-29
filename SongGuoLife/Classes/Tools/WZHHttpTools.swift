//
//  WZHHttpTools.swift
//  SongGuoLife
//
//  Created by 王振晗 on 16/7/12.
//  Copyright © 2016年 王振晗. All rights reserved.
//

import UIKit
import AFNetworking

enum RequestType {
    case GET,POST
}


class WZHHttpTools: AFHTTPSessionManager {
    //将工具类封装成单例对象
    static let shareInstance : WZHHttpTools = {
        
        let tools = WZHHttpTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        return tools
    }()
}
// MARK:- 封装网络工具类
extension WZHHttpTools {
    
    func requestData(requestType : RequestType , urlString : String, parameters : [String : NSObject],resultCallBack : (result : AnyObject?, error : NSError?) -> ()) {
        
        //请求成功之后的回调
        let successCallBack = ({ (dataTask : NSURLSessionDataTask, result : AnyObject?) in
            resultCallBack(result: result, error: nil)
        })
        
        //请求失败之后的回调
        let failureCallBack = ({ (dataTask : NSURLSessionDataTask?, error : NSError) in
            resultCallBack(result: nil, error: error)
        })
        
        
        if requestType == .GET {
            //GET请求
            GET(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        } else {
            //POST请求
            POST(urlString, parameters: parameters, progress: nil, success: successCallBack, failure:failureCallBack)
        }
        
    }
}

