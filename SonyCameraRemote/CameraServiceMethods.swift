//
//  CameraServiceMethods.swift
//  SonyCameraRemote
//
//  Created by Michael Ellis on 11/22/20.
//

import Foundation

enum CameraServiceMethods {
    /// get the supported shoot modes.
    /// The client should use "getAvailableShootMode" to get the available parameters at the moment.
    static let getSupportedShootMode = "getSupportedShootMode"
    /// Current Shoot Mode
    static let getShootMode = "getShootMode"
    /// Set Shoot Mode
    static let setShootMode = "setShootMode"
    /// get current shoot mode and the available shoot modes at the moment.
    static let getAvailableShootMode = "getAvailableShootMode"
    
    /// tell device to take a picture
    static let actTakePicture = "actTakePicture"
    /// provides a function to call on to know when to wait while the camera is taking a picture
    static let awaitTakePicture = "awaitTakePicture"
    
    startContShooting
    stopContShooting
    startMovieRec
    stopMovieRec
    startAudioRec
    stopAudioRec startIntervalStillRec
    stopIntervalStillRec
    startLoopRec
    stopLoopRec
    startLiveview
    stopLiveview
    startLiveviewWithSize
    getLiveviewSize
    getSupportedLiveviewSize getAvailableLiveviewSize
    setLiveviewFrameInfo
    getLiveviewFrameInfo
    actZoom
    
    setZoomSetting
    getZoomSetting
    getSupportedZoomSetting
    getAvailableZoomSetting
    actHalfPressShutter
    cancelHalfPressShutter
    setTouchAFPosition
    getTouchAFPosition
    cancelTouchAFPosition
    actTrackingFocus
    cancelTrackingFocus
    setTrackingFocus
    getTrackingFocus
    
    
    getSupportedTrackingFocus
    getAvailableTrackingFocus
    setContShootingMode
    getContShootingMode
    getSupportedContShootingMode
    getAvailableContShootingMode
    setContShootingSpeed
    getContShootingSpeed
    getSupportedContShootingSpeed
    getAvailableContShootingSpeed
    setSelfTimer
    
    getSelfTimer
    getSupportedSelfTimer
    getAvailableSelfTimer
    setExposureMode
    getExposureMode
    getSupportedExposureMode
    
    getAvailableExposureMode
    setFocusMode
    getFocusMode
    getSupportedFocusMode
    getAvailableFocusMode
    setExposureCompensation
    getExposureCompensation
    getSupportedExposureCompensation
    
    getAvailableExposureCompensation
    setFNumber
    getFNumber
    getSupportedFNumber
    getAvailableFNumber
    setShutterSpeed
    getShutterSpeed
    getSupportedShutterSpeed
    getAvailableShutterSpeed
    setIsoSpeedRate
    getIsoSpeedRate
    getSupportedIsoSpeedRate
    
    getAvailableIsoSpeedRate
    setWhiteBalance
    getWhiteBalance
    getSupportedWhiteBalance
    getAvailableWhiteBalance
    actWhiteBalanceOnePushCustom
    setProgramShift
    getSupportedProgramShift
    
    setFlashMode
    
    getFlashMode
    
    getSupportedFlashMode
    getAvailableFlashMode
    setStillSize
    getStillSize
    getSupportedStillSize
    getAvailableStillSize
    setStillQuality
    getStillQuality
    
    getSupportedStillQuality
    getAvailableStillQuality
    setPostviewImageSize
    getPostviewImageSize
    getSupportedPostviewImageSize
    getAvailablePostviewImageSize
    setMovieFileFormat
    getMovieFileFormat
    getSupportedMovieFileFormat
    
    getAvailableMovieFileFormat
    setMovieQuality
    
    getMovieQuality
    getSupportedMovieQuality
    getAvailableMovieQuality
    setSteadyMode
    getSteadyMode
    
    getSupportedSteadyMode
    getAvailableSteadyMode
    setViewAngle
    getViewAngle
    getSupportedViewAngle
    getAvailableViewAngle
    setSceneSelection
    getSceneSelection
    getSupportedSceneSelection
    getAvailableSceneSelection
    setColorSetting
    getColorSetting
    getSupportedColorSetting
    getAvailableColorSetting
    setIntervalTime
    getIntervalTime
    getSupportedIntervalTime
    
    getAvailableIntervalTime
    setLoopRecTime
    
    getLoopRecTime
    getSupportedLoopRecTime
    getAvailableLoopRecTime
    setWindNoiseReduction
    getWindNoiseReduction
    getSupportedWindNoiseReduction
    getAvailableWindNoiseReduction
    setAudioRecording
    getAudioRecording
    getSupportedAudioRecording
    getAvailableAudioRecording
    setFlipSetting
    getFlipSetting
    
    getSupportedFlipSetting
    getAvailableFlipSetting
    setTvColorSystem
    getTvColorSystem
    getSupportedTvColorSystem
    getAvailableTvColorSystem
    startRecMode
    stopRecMode
    setCameraFunction
    getCameraFunction
    getSupportedCameraFunction
    getAvailableCameraFunction
    setInfraredRemoteControl
    getInfraredRemoteControl
    getSupportedInfraredRemoteControl
    getAvailableInfraredRemoteControl
    setAutoPowerOff
    getAutoPowerOff
    getSupportedAutoPowerOff
    getAvailableAutoPowerOff
    setBeepMode
    getBeepMode
    getSupportedBeepMode
    getAvailableBeepMode
    setCurrentTime
    getStorageInformation
    getEvent (v1.0)
    getEvent (v1.1)
    getEvent (v1.2)
    getEvent (v1.3)
    getAvailableApiList
    getApplicationInfo
    getVersions
    getMethodTypes
}


