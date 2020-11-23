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
    
    static let startContShooting = "startContShooting"
    static let stopContShooting = "stopContShooting"
    
    static let startMovieRec = "startMovieRec"
    static let stopMovieRec = "stopMovieRec"
    static let setMovieFileFormat = "setMovieFileFormat"
    static let getMovieFileFormat = "getMovieFileFormat"
    static let getSupportedMovieFileFormat = "getSupportedMovieFileFormat"
    static let getAvailableMovieFileFormat = "getAvailableMovieFileFormat"
    static let setMovieQuality = "setMovieQuality"
    static let getMovieQuality = "getMovieQuality"
    static let getSupportedMovieQuality = "getSupportedMovieQuality"
    static let getAvailableMovieQuality = "getAvailableMovieQuality"
    
    static let startAudioRec = "startAudioRec"
    static let stopAudioRec = "stopAudioRec"
    static let setAudioRecording = "setAudioRecording"
    static let getAudioRecording = "getAudioRecording"
    static let getSupportedAudioRecording = "getSupportedAudioRecording"
    static let getAvailableAudioRecording = "getAvailableAudioRecording"
    
    static let startIntervalStillRec = "startIntervalStillRec"
    static let stopIntervalStillRec = "startIntervalStillRec"
    static let setIntervalTime = "setIntervalTime"
    static let getIntervalTime = "getIntervalTime"
    static let getSupportedIntervalTime = "getSupportedIntervalTime"
    static let getAvailableIntervalTime = "getAvailableIntervalTime"
    
    static let startLiveview = "startLiveview"
    static let stopLiveview = "stopLiveview"
    static let startLiveviewWithSize = "startLiveviewWithSize"
    static let getLiveviewSize = "getLiveviewSize"
    static let getSupportedLiveviewSize = "getSupportedLiveviewSize"
    static let getAvailableLiveviewSize = "getAvailableLiveviewSize"
    static let setLiveviewFrameInfo = "setLiveviewFrameInfo"
    static let getLiveviewFrameInfo = "getLiveviewFrameInfo"
    
    static let actZoom = "actZoom"
    static let setZoomSetting = "setZoomSetting"
    static let getZoomSetting = "getZoomSetting"
    static let getSupportedZoomSetting = "getSupportedZoomSetting"
    static let getAvailableZoomSetting = "getAvailableZoomSetting"
    
    static let actHalfPressShutter = "actHalfPressShutter"
    static let cancelHalfPressShutter = "cancelHalfPressShutter"
    
    static let setTouchAFPosition = "setTouchAFPosition"
    static let getTouchAFPosition = "getTouchAFPosition"
    static let cancelTouchAFPosition = "cancelTouchAFPosition"
    static let actTrackingFocus = "actTrackingFocus"
    
    static let cancelTrackingFocus = "cancelTrackingFocus"
    static let setTrackingFocus = "setTrackingFocus"
    static let getTrackingFocus = "getTrackingFocus"
    static let getSupportedTrackingFocus = "getSupportedTrackingFocus"
    static let getAvailableTrackingFocus = "getAvailableTrackingFocus"
    
    static let setContShootingMode = "setContShootingMode"
    static let getContShootingMode = "getContShootingMode"
    static let getSupportedContShootingMode = "getSupportedContShootingMode"
    static let getAvailableContShootingMode = "getAvailableContShootingMode"
    static let setContShootingSpeed = "setContShootingSpeed"
    static let getContShootingSpeed = "getContShootingSpeed"
    static let getSupportedContShootingSpeed = "getSupportedContShootingSpeed"
    static let getAvailableContShootingSpeed = "getAvailableContShootingSpeed"
    
    static let setSelfTimer = "setSelfTimer"
    static let getSelfTimer = "getSelfTimer"
    static let getSupportedSelfTimer = "getSupportedSelfTimer"
    static let getAvailableSelfTimer = "getAvailableSelfTimer"
    
    static let setExposureMode = "setExposureMode"
    static let getExposureMode = "getExposureMode"
    static let getSupportedExposureMode = "getSupportedExposureMode"
    static let getAvailableExposureMode = "getAvailableExposureMode"
    
    static let setFocusMode = "setFocusMode"
    static let getFocusMode = "getFocusMode"
    static let getSupportedFocusMode = "getSupportedFocusMode"
    static let getAvailableFocusMode = "getAvailableFocusMode"
    
    static let setExposureCompensation = "setExposureCompensation"
    static let getExposureCompensation = "getExposureCompensation"
    static let getSupportedExposureCompensation = "getSupportedExposureCompensation"
    static let getAvailableExposureCompensation = "getAvailableExposureCompensation"
    
    static let setFNumber = "setFNumber"
    static let getFNumber = "getFNumber"
    static let getSupportedFNumber = "getSupportedFNumber"
    static let getAvailableFNumber = "getAvailableFNumber"
    
    static let setShutterSpeed = "setShutterSpeed"
    static let getShutterSpeed = "getShutterSpeed"
    static let getSupportedShutterSpeed = "getSupportedShutterSpeed"
    static let getAvailableShutterSpeed = "getAvailableShutterSpeed"
    
    static let setIsoSpeedRate = "setIsoSpeedRate"
    static let getIsoSpeedRate = "getIsoSpeedRate"
    static let getSupportedIsoSpeedRate = "getSupportedIsoSpeedRate"
    static let getAvailableIsoSpeedRate = "getAvailableIsoSpeedRate"
    
    static let setWhiteBalance = "setWhiteBalance"
    static let getWhiteBalance = "getWhiteBalance"
    static let getSupportedWhiteBalance = "getSupportedWhiteBalance"
    static let getAvailableWhiteBalance = "getAvailableWhiteBalance"
    static let actWhiteBalanceOnePushCustom = "actWhiteBalanceOnePushCustom"
    
    static let setProgramShift = "setProgramShift"
    static let getSupportedProgramShift = "getSupportedProgramShift"
    
    static let setFlashMode = "setFlashMode"
    static let getFlashMode = "getFlashMode"
    static let getSupportedFlashMode = "getSupportedFlashMode"
    static let getAvailableFlashMode = "getAvailableFlashMode"
    
    static let setStillSize = "setStillSize"
    static let getStillSize = "getStillSize"
    static let getSupportedStillSize = "getSupportedStillSize"
    static let getAvailableStillSize = "getAvailableStillSize"
    static let setStillQuality = "setStillQuality"
    static let getStillQuality = "getStillQuality"
    static let getSupportedStillQuality = "getSupportedStillQuality"
    static let getAvailableStillQuality = "getAvailableStillQuality"
    
    static let setPostviewImageSize = "setPostviewImageSize"
    static let getPostviewImageSize = "getPostviewImageSize"
    static let getSupportedPostviewImageSize = "getSupportedPostviewImageSize"
    static let getAvailablePostviewImageSize = "getAvailablePostviewImageSize"
    
    static let setSteadyMode = "setSteadyMode"
    static let getSteadyMode = "getSteadyMode"
    static let getSupportedSteadyMode = "getSupportedSteadyMode"
    static let getAvailableSteadyMode = "getAvailableSteadyMode"
    
    static let setViewAngle = "setViewAngle"
    static let getViewAngle = "getViewAngle"
    static let getSupportedViewAngle = "getSupportedViewAngle"
    static let getAvailableViewAngle = "getAvailableViewAngle"
    
    static let setSceneSelection = "setSceneSelection"
    static let getSceneSelection = "getSceneSelection"
    static let getSupportedSceneSelection = "getSupportedSceneSelection"
    static let getAvailableSceneSelection = "getAvailableSceneSelection"
    
    static let setColorSetting = "setColorSetting"
    static let getColorSetting = "getColorSetting"
    static let getSupportedColorSetting = "getSupportedColorSetting"
    static let getAvailableColorSetting = "getAvailableColorSetting"
    
    static let startLoopRec = "startLoopRec"
    static let stopLoopRec = "stopLoopRec"
    static let setLoopRecTime = "setLoopRecTime"
    static let getLoopRecTime = "getLoopRecTime"
    static let getSupportedLoopRecTime = "getSupportedLoopRecTime"
    static let getAvailableLoopRecTime = "getAvailableLoopRecTime"
    
    static let setWindNoiseReduction = "setWindNoiseReduction"
    static let getWindNoiseReduction = "getWindNoiseReduction"
    static let getSupportedWindNoiseReduction = "getSupportedWindNoiseReduction"
    static let getAvailableWindNoiseReduction = "getAvailableWindNoiseReduction"
    
    static let setFlipSetting = "setFlipSetting"
    static let getFlipSetting = "getFlipSetting"
    static let getSupportedFlipSetting = "getSupportedFlipSetting"
    static let getAvailableFlipSetting = "getAvailableFlipSetting"
    
    static let setTvColorSystem = "setTvColorSystem"
    static let getTvColorSystem = "getTvColorSystem"
    static let getSupportedTvColorSystem = "getSupportedTvColorSystem"
    static let getAvailableTvColorSystem = "getAvailableTvColorSystem"
    
    static let startRecMode = "startRecMode"
    static let stopRecMode = "stopRecMode"
    
    static let setCameraFunction = "setCameraFunction"
    static let getCameraFunction = "getCameraFunction"
    static let getSupportedCameraFunction = "getSupportedCameraFunction"
    static let getAvailableCameraFunction = "getAvailableCameraFunction"
    
    static let setInfraredRemoteControl = "setInfraredRemoteControl"
    static let getInfraredRemoteControl = "getInfraredRemoteControl"
    static let getSupportedInfraredRemoteControl = "getSupportedInfraredRemoteControl"
    static let getAvailableInfraredRemoteControl = "getAvailableInfraredRemoteControl"
    
    static let setAutoPowerOff = "setAutoPowerOff"
    static let getAutoPowerOff = "getAutoPowerOff"
    static let getSupportedAutoPowerOff = "getSupportedAutoPowerOff"
    static let getAvailableAutoPowerOff = "getAvailableAutoPowerOff"
    
    static let setBeepMode = "setBeepMode"
    static let getBeepMode = "getBeepMode"
    static let getSupportedBeepMode = "getSupportedBeepMode"
    static let getAvailableBeepMode = "getAvailableBeepMode"
    
    static let setCurrentTime = "setCurrentTime"
    static let getStorageInformation = "getStorageInformation"
    /// (v1.0), (v1.1), (v1.2), (v1.3)
    static let getEvent = "getEvent"
    /// the available API names that the device supports at the moment
    static let getAvailableApiList = "getAvailableApiList"
    static let getApplicationInfo = "getApplicationInfo"
    static let getVersions = "getVersions"
    static let getMethodTypes = "getMethodTypes"
}


