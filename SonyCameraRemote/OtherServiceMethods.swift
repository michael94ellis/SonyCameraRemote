//
//  OtherServiceMethods.swift
//  SonyCameraRemote
//
//  Created by Michael Ellis on 11/23/20.
//

import Foundation

enum SystemServiceMethods {
    static let getVersions = "getVersions"
    static let getMethodTypes = "getMethodTypes"
}

enum AVContentServiceMethods {
    static let getSchemeList = "getSchemeList"
    static let getSourceList = "getSourceList"
    /// (v1.2)
    static let getContentCount = "getContentCount"
    /// (v1.3)
    static let getContentList = "getContentList"
    static let setStreamingContent = "setStreamingContent"
    static let startStreaming = "startStreaming"
    static let pauseStreaming = "pauseStreaming"
    static let seekStreamingPosition = "seekStreamingPosition"
    static let stopStreaming = "stopStreaming"
    static let requestToNotifyStreamingStatus = "requestToNotifyStreamingStatus"
    /// (v1.1)
    static let deleteContent = "deleteContent"
    static let getVersions = "getVersions"
    static let getMethodTypes = "getMethodTypes"
}
