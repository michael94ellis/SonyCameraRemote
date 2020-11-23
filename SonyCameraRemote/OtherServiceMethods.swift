//
//  OtherServiceMethods.swift
//  SonyCameraRemote
//
//  Created by Michael Ellis on 11/23/20.
//

import Foundation

enum SystemServiceMethods {
    getVersions getMethodTypes
}

enum AVContentServiceMethods {
    getSchemeList
    getSourceList
    getContentCount (v1.2)
    getContentList (v1.3)
    setStreamingContent
    startStreaming
    pauseStreaming
    seekStreamingPosition
    stopStreaming
    requestToNotifyStreamingStatus
    deleteContent (v1.1)
    getVersions getMethodTypes
}
