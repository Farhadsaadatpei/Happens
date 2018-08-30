//
//  CameraView.swift
//  happens
//
//  Created by Vilvas, Inc. on 9/10/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit
import AVFoundation
import CoreImage
import ImageIO

protocol CameraViewDelegate:  class {
    func cancelTakingPhoto(ActionToPerform: AnyObject)
    func AcceptImage(ActionToPerform: AnyObject)
}

class CameraView: UIView {

    var view: UIView!
    var nibName: String = "CameraView"
    
    var delegate: CameraViewDelegate?

    //Camera View Variables
    @IBOutlet var capture: UIView!
    @IBOutlet var captureFrame: UIView!
    @IBOutlet var capturePhoto: UIImageView!
    @IBOutlet var TakePicture: TakeButton!
    @IBOutlet var photoOptionDialog: UIView!
    @IBOutlet var cameraSettings: UIView!
    
    //Final Image Variable
    var imageSource: UIImage!
    
    //Session Variables
    var captureSession: AVCaptureSession!
    var captureImageOutput: AVCaptureStillImageOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    //Flags
    var resetCamera: Bool! = false
    
    //Camera Devices 
    var devices = AVCaptureDevice.devices()
    var currentCameraInput: AVCaptureDevice!
    
    override init(frame: CGRect) {
        // properties
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        // properties
        super.init(coder: aDecoder)
        
        // Setup
        setup()
    }
    
    func setup() {
        
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
        
        //Add UITap Gesture Capture Frame for Focus and Exposure
        let captureTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "AutoFocusGesture:")
        captureTapGesture.numberOfTapsRequired = 1
        captureTapGesture.numberOfTouchesRequired = 1
        self.captureFrame.addGestureRecognizer(captureTapGesture)
        
        //Capture Session
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        
        //Setup Initial Camera (BACK)
        var InitialCamera: AVCaptureDevice?
        InitialCamera = self.cameraWithPosition(Position: AVCaptureDevicePosition.Back)
        //Init Default Camera Position (BACK)
        self.currentCameraInput = InitialCamera
        
        //Set The Session Camera (BACK)
        do{
            let CameraInput = try AVCaptureDeviceInput(device: currentCameraInput)
            if captureSession.canAddInput(CameraInput) {
                 self.captureSession.addInput(CameraInput)
            }
            
            //Output Configuration
            captureImageOutput = AVCaptureStillImageOutput()
            captureImageOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            captureSession.addOutput(captureImageOutput)

        } catch _{
            print("Coudn't set Back Camera (Initial)")
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            //Live Preview of Camera
            self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            self.captureFrame.layer.addSublayer(self.previewLayer)
            self.previewLayer.frame = self.captureFrame.bounds
            self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        })
        
        self.TakePicture.enabled = true
        
        //Disable Indicator
        self.touchIndicatorOutside.hidden = true
        
        //Initialize Defualt Flash Mode
        if let device = currentCameraInput {
            do {
                try! device.lockForConfiguration()
                //Check If Auto Flash Supported
                if device.isTorchModeSupported(.Auto){
                    //Assign The Camera With Flash Mode of Auto
                    device.torchMode = .Auto
                }
                device.unlockForConfiguration()
            }
            
            //Hide Other Flash Mode Buttons
            OFFFlash.hidden = true
            ONFlash.hidden = true
        } else {
            AutoFlash.enabled = false
        }
        
        //Show Front Camera
        self.FrontCamera.hidden = false
        self.BackCamera.hidden = true
    }
    
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    //Capture Photo
    @IBAction func captureImage(sender: AnyObject) {
        self.TakePicture.enabled = false
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            dispatch_async(dispatch_get_main_queue(), {
                if let videoConnection = self.captureImageOutput.connectionWithMediaType(AVMediaTypeVideo){
                    
                    self.captureImageOutput.captureStillImageAsynchronouslyFromConnection(videoConnection){
                        (imageSampleBuffer : CMSampleBuffer!, error) in
                        
                        //Get Output Rect from PreviewLayer
                        let outputRect: CGRect = self.previewLayer.metadataOutputRectOfInterestForRect(self.previewLayer.bounds)
                        
                        //Get Image Data From AV and Create a Data Provider for CG
                        let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageSampleBuffer)
                        let dataProvider = CGDataProviderCreateWithCFData(imageData)
                
                        //Create a Image to Match Camera Origin and Size.
                        let cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
                        let imageWidth: size_t = CGImageGetWidth(cgImageRef)
                        let imageHeight: size_t = CGImageGetHeight(cgImageRef)
                        let cropRect = CGRectMake(outputRect.origin.x * CGFloat(imageWidth), outputRect.origin.y * CGFloat(imageHeight), outputRect.size.width * CGFloat(imageWidth), outputRect.size.height * CGFloat(imageHeight))
                        let cropCGImage: CGImageRef = CGImageCreateWithImageInRect(cgImageRef, cropRect)!
                        
                        var imageDataSource: UIImage = UIImage(CGImage: cropCGImage, scale: 0.4, orientation: UIImageOrientation.Right)
                        
                        //Resize Image to desire Size
                        let newRect: CGRect = CGRectMake(0, 0, 1280, 1280)
                        UIGraphicsBeginImageContext(newRect.size)
                        imageDataSource.drawInRect(newRect)
                        imageDataSource = UIGraphicsGetImageFromCurrentImageContext()
                        UIGraphicsEndImageContext()
                        
                        //Convert Core Graphic Image to be Used
                        self.imageSource = imageDataSource
                        //Assign Final Image After Edit
                        self.capturePhoto.image = self.imageSource
                        
                        if self.capturePhoto.image != nil {
                            UIView.transitionWithView(self.view, duration: 1.0, options: UIViewAnimationOptions.CurveLinear, animations: {

                                self.TakePicture.frame.offsetInPlace(dx: 0, dy: 800)
                                self.cameraSettings.frame.offsetInPlace(dx: -300, dy: 0)
                                
                                self.photoOptionDialog.alpha = 1
                                self.photoOptionDialog.hidden = false
                                
                                self.resetCamera = true
                                
                                }, completion: nil)
                        }
                    }
                }
            })
        }
    }
    
    
    @IBAction func retakePhoto(sender: AnyObject) {
        self.TakePicture.enabled = true
        if resetCamera == true {
            UIView.transitionWithView(self.view, duration: 0.5, options: UIViewAnimationOptions.CurveLinear, animations: {
                self.capturePhoto.image = nil
                self.photoOptionDialog.alpha = 0
                self.photoOptionDialog.hidden = true
                self.cameraSettings.frame.offsetInPlace(dx: 300, dy: 0)
                self.TakePicture.frame.offsetInPlace(dx: 0, dy: -800)
                
                }, completion: {
                    (finished)-> Void in
                    self.resetCamera = false
            })
        }
    }
    
    //Cancel Photo Capture
    @IBAction func cancelCamera(sender: AnyObject) {
        let ActionToPerform = sender
        self.delegate?.cancelTakingPhoto(ActionToPerform)
    }
    
    //Assign Complete Photo To Post
    @IBAction func AcceptImage(sender: AnyObject) {
        let ActionToPerform = sender
        self.delegate?.AcceptImage(ActionToPerform)
    }
    
    /*=========================================
    * FLIP CAMERA
    ==========================================*/
    @IBOutlet var BackCamera: FlipBack!
    @IBOutlet var FrontCamera: FlipFront!
    
    @IBAction func BackCamera(sender: AnyObject) {
        //Which Camera Can be Switch
        self.BackCamera.hidden = true
        self.FrontCamera.hidden = false
        //Thread
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            //Check If Session is not Nil
            if self.captureSession != nil{
                //Indicate Camera Configuration Will Change
                self.captureSession.beginConfiguration()
                //Get Current Camera Position & Remove It
                let currentCamera: AVCaptureInput = self.captureSession.inputs[0] as! AVCaptureInput
                self.captureSession.removeInput(currentCamera)
                //Setup New Camera
                var newCamera: AVCaptureDevice?
                newCamera = self.cameraWithPosition(Position: AVCaptureDevicePosition.Back)
                //Init New Camera Poistion
                self.currentCameraInput = newCamera
                
                //Change The Session Camera
                do{
                    let newCameraInput = try AVCaptureDeviceInput(device: newCamera!)
                    self.captureSession.addInput(newCameraInput)
                } catch _{
                    print("Coudn't set Front Camera")
                }
                
                //Inidicate Finish Configiration
                self.captureSession.commitConfiguration()

            }
        }
    }
    
    @IBAction func FrontCamera(sender: AnyObject) {
        //Which Camera Can be Switch
        self.BackCamera.hidden = false
        self.FrontCamera.hidden = true
        //Thread
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            //Check If Session is not Nil
            if self.captureSession != nil{
                //Indicate Camera Configuration Will Change
                self.captureSession.beginConfiguration()
                //Get Current Camera Position & Remove It
                let currentCamera: AVCaptureInput = self.captureSession.inputs[0] as! AVCaptureInput
                self.captureSession.removeInput(currentCamera)
                //Setup New Camera
                var newCamera: AVCaptureDevice?
                newCamera = self.cameraWithPosition(Position: AVCaptureDevicePosition.Front)
                //Init New Camera Poistion
                self.currentCameraInput = newCamera
                
                //Change The Session Camera
                do{
                    let newCameraInput = try AVCaptureDeviceInput(device: newCamera!)
                    self.captureSession.addInput(newCameraInput)
                } catch _{
                    print("Coudn't set Back Camera")
                }
                
                //Inidicate Finish Configiration
                self.captureSession.commitConfiguration()
            }
        }
    }
    

    //Switch Camera
    func cameraWithPosition(Position Position: AVCaptureDevicePosition) -> AVCaptureDevice? {
        let devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        for device in devices {
            if device.position == Position {
                return device as? AVCaptureDevice
            }
        }
        return nil
    }
    
    
    /*=========================================
    * FOCUS & EXPOSOUR
    ==========================================*/
    var animateActivity: Bool!
    internal func AutoFocusGesture(RecognizeGesture: UITapGestureRecognizer){
        let touchPoint: CGPoint = RecognizeGesture.locationInView(self.captureFrame)
        let convertedPoint = self.previewLayer.captureDevicePointOfInterestForPoint(touchPoint)
        
        //Assign Auto Focus and Auto Exposour
        if let device = currentCameraInput {
            do {
                try! device.lockForConfiguration()
                if device.focusPointOfInterestSupported{
                    //Add Focus on Point
                    device.focusPointOfInterest = convertedPoint
                    device.focusMode = AVCaptureFocusMode.AutoFocus
                }
                
                if device.exposurePointOfInterestSupported{
                    //Add Exposure on Point
                    device.exposurePointOfInterest = convertedPoint
                    device.exposureMode = AVCaptureExposureMode.AutoExpose
                }
                device.unlockForConfiguration()
            }
        }
        
        //Assign Indicator Position
        touchIndicatorOutside.frame.origin.x = touchPoint.x - 10
        touchIndicatorOutside.frame.origin.y = touchPoint.y - 10
        
        //Start Indicator Animation
        self.touchPointIndicator()
    }

     //Touch Point Animation
    @IBOutlet var touchIndicatorOutside: PointIndicatorOutSide!
    func touchPointIndicator(){
        
        self.touchIndicatorOutside.hidden = false
        UIView.animateWithDuration(0.4, animations: {
            self.touchIndicatorOutside.alpha = 1.0
        })
        
        UIView.animateWithDuration(1.0, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.touchIndicatorOutside.transform = CGAffineTransformMakeScale(2.0, 2.0)
            }, completion: {
                (finished) -> Void in
                self.touchIndicatorOutside.transform = CGAffineTransformMakeScale(0.5, 0.5)
                self.touchIndicatorOutside.hidden = true
        })
    }
    
    
    /*=========================================
    * Flash Setting
    ==========================================*/
    
    @IBOutlet var AutoFlash: FlashAuto!
    @IBOutlet var OFFFlash: FlashOFF!
    @IBOutlet var ONFlash: FlashON!
    
    //Assign Auto Flash
    @IBAction func AutoFlash(sender: AnyObject) {
        if let device = currentCameraInput {
            do {
                try! device.lockForConfiguration()
                //Check If OFF Flash Supported
                if device.isTorchModeSupported(.Off){
                    //Assign The Camera With Flash Mode of OFF
                    device.torchMode = .Off
                    //Hide Other Flash Mode Buttons
                    AutoFlash.hidden = true
                    ONFlash.hidden = true
                    //Show OFF Flash Button
                    OFFFlash.hidden = false
                } else {
                    OFFFlash.enabled = false
                }
                device.unlockForConfiguration()
            }
        }
    }
    
    @IBAction func OFFFlash(sender: AnyObject) {
        if let device = currentCameraInput {
            do {
                try! device.lockForConfiguration()
                //Check If ON Flash Supported
                if device.isTorchModeSupported(.On){
                    //Assign The Camera With Flash Mode of OFF
                    device.torchMode = .On
                    //Hide Other Flash Mode Buttons
                    AutoFlash.hidden = true
                    OFFFlash.hidden = true
                    //Show ON Flash Button
                    ONFlash.hidden = false
                } else {
                    ONFlash.enabled = false
                }
                device.unlockForConfiguration()
            }
        }
    }

    @IBAction func ONFlash(sender: AnyObject) {
        //Initialize Defualt Flash Mode
        if let device = currentCameraInput {
            do {
                try! device.lockForConfiguration()
                //Check If Auto Flash Supported
                if device.isTorchModeSupported(.Auto){
                    //Assign The Camera With Flash Mode of Auto
                    device.torchMode = .Auto
                    //Hide Other Flash Mode Buttons
                    OFFFlash.hidden = true
                    ONFlash.hidden = true
                    //Show Auto Flash Button
                    AutoFlash.hidden = false
                }else {
                    AutoFlash.enabled = false
                }
                device.unlockForConfiguration()
            }
        }
    }
    

}

