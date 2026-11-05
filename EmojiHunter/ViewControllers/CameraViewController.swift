//
//  CameraViewController.swift
//  EmojiHunter
//
//  Created by Jeremy Ru on 2026/11/4.
//

import UIKit
import AVFoundation
import Vision
import CoreML

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    // MARK: - Setup VC and video settings
    // Delegate is weak to prevent a retain cycle
    weak var delegate: EmojiFoundDelegate?
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    private let videoDataOutput = AVCaptureVideoDataOutput()
    
    // The specific target string the AI needs to find
    var emojiString = ""
    
    init(emoji: String) {
        self.emojiString = emoji
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession = AVCaptureSession()
        
        // 1. Check if a camera exists (fails gracefully on Simulator)
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            showCameraUnavailableMessage()
            return
        }
        
        // 2. Try to create an input from the camera device
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        }
        
        // 3. Configure the raw video output (BGRA format is what CoreML/Vision expects)
        self.videoDataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_32BGRA)] as [String : Any]
        // Drop frames if the processor is busy to keep the feed smooth
        self.videoDataOutput.alwaysDiscardsLateVideoFrames = true
        // Send frames to a background queue so we don't freeze the UI
        self.videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera_frame_processing_queue"))
        self.captureSession.addOutput(self.videoDataOutput)
        
        // 4. Set up the visual preview layer
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = self.view.frame
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        // 5. Start the camera on a background thread (it blocks the main thread otherwise)
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }
    
    private func showCameraUnavailableMessage() {
        // Fallback UI for when the app is run on the Simulator
        let label = UILabel(frame: view.bounds)
        label.text = "Camera not available\nRun on a real device"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .black
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        view.addSubview(label)
    }
    
    // Delegate method triggered every time a new video frame is captured
    nonisolated func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // Convert the raw buffer into a CVImageBuffer
        guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            debugPrint("unable to get image from sample buffer")
            return
        }
        
        // Hop back to the Main Actor to process the frame
        Task { @MainActor in
            self.updateClassifications(in: frame)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Resume camera if returning to this screen
        if captureSession?.isRunning == false {
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.startRunning()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Stop camera when leaving the screen to save battery
        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK: - Setup ML Model
    // Lazily initialize the Vision request only when it's first needed
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            // Load Apple's MobileNetV2 model
            let model = try VNCoreMLModel(for: MobileNetV2().model)
            // Create a request that will call our processing method when done
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            })
            // Center crop the image to match the model's expected input shape
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    // MARK: - Classification methods
    func updateClassifications(in image: CVPixelBuffer) {
        // Perform the heavy Vision processing on a background thread
        DispatchQueue.global(qos: .userInitiated).async {
            // Orientation .right assumes the phone is held vertically in portrait mode
            let handler = VNImageRequestHandler(cvPixelBuffer: image, orientation: .right, options: [:])
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }
    
    func processClassifications(for request: VNRequest, error: Error?) {
        // Jump back to the main thread to update the UI / handle game logic
        DispatchQueue.main.async {
            // Safely cast the results to classification observations
            guard let results = request.results as? [VNClassificationObservation] else { return }
            // Only consider the top result, and only if the AI is > 50% confident
            guard let top = results.first, top.confidence > 0.5 else { return }
            
            // Print to console so you can debug what the AI sees in real time
            print("Classification: Identifier \(top.identifier) ; Confidence \(top.confidence)")
            // If the AI's guess contains our target string (e.g., "pen"), trigger success!
            if top.identifier.contains(self.emojiString) {
                self.delegate?.emojiWasFound(result: true)
            }
        }
    }
}
