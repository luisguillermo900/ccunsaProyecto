//
//  QRScannerView.swift
//  ccunsaProyecto
//
//  Created by epismac on 9/10/24.
//

import SwiftUI
import AVFoundation
import CoreImage
import CoreImage.CIFilterBuiltins

struct QRScannerView: View {
    @State private var isScanning: Bool = false
    @State private var session: AVCaptureSession = .init()
    @State private var cameraPermission: Permission = .idle
    @State private var qrOutput: AVCaptureMetadataOutput = .init()
    @State private var esSimulador: Bool = false
    
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @StateObject private var qrDelegate = QRScannerDelegate()
    @State private var scannedCode: String = ""
    @Environment(\.openURL) private var openURL
    
    //Para subir una imagen
    @State private var isShowingDetail = false
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false
    @State private var modoCaptura: Int = 1 //1:Camara, 2: imagen
    @State private var qrCodeContent: String? = nil
    
    //Selector
    @State private var selectedSegment = "Camara"
    let segments = ["Camara", "Imagen"]
    
    //Para obtener pintura seleccionada
    @StateObject private var pictureViewModel = PictureViewModel()
    @State private var selectedPicture: Pictures?
    
    var body: some View {
        VStack(spacing: 8){
            Picker("Select Segment", selection: $selectedSegment) {
                ForEach(segments, id: \.self) { segment in
                    Text(segment)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedSegment) { newValue in
                if newValue == "Camara" {
                    modoCaptura = 1
                } else {
                    modoCaptura = 2
                }
            }
            if(modoCaptura == 1){
                Text("Coloque el QR dentro del cuadro")
                    .font(.title3)
                    .foregroundColor(.black.opacity(0.8))
                    .padding(.top,20)
                Text("El escaneo comenzara automaticamente")
                    .font(.callout)
                    .foregroundColor(.gray)
                Spacer(minLength: 0)
                
                GeometryReader {
                    let size = $0.size
                    ZStack{
                        VistaCamara(frameSize: CGSize(width: size.width, height: size.width), session: $session)
                            .scaleEffect(0.97)
                        ForEach(0...3, id: \.self){ index in
                            let rotation = Double(index) * 90.0
                            RoundedRectangle(cornerRadius: 2, style: .circular)
                                .trim(from: 0.61, to: 0.64)
                                .stroke(Color.blue,style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                                .rotationEffect(.init(degrees: rotation))
                            
                        }
                    }
                    .frame(width: size.width, height: size.width)
                    .overlay(alignment: .top, content:{
                        Rectangle()
                            .fill(Color.blue)
                            .frame(height: 2.5)
                            .offset(y: isScanning ? size.width : 0)
                    })
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .padding(.horizontal, 45)
                
                Spacer(minLength: 15)
                
                Button {
                    if session.isRunning && cameraPermission == .approved{
                        reactivateCamera()
                        activateScannerAnimation()
                    }
                } label: {
                    Image(systemName: "qrcode.viewfinder")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                }
                Spacer(minLength: 40)
                
            } else if (modoCaptura == 2) {
                Text("Suba una imagen para leer el QR")
                    .font(.title3)
                    .foregroundColor(.black.opacity(0.8))
                    .padding(.top,20)
                Text("El escaneo comenzara automaticamente")
                    .font(.callout)
                    .foregroundColor(.gray)
                Spacer(minLength: 0)
                
                GeometryReader {
                    let size = $0.size
                    VStack {
                        ZStack{
                            if let image = selectedImage {
                                Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                            }
                            RoundedRectangle(cornerRadius: 2, style: .circular)
                                .stroke(Color.blue,style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                        }
                        .frame(width: size.width, height: size.width)
                        if let qrContent = qrCodeContent {
                            Text("QR Content: \(qrContent)")
                                .padding()
                                .foregroundColor(.blue)
                        }
                        Spacer()
                        
                    }
                }
                .padding(.horizontal, 45)
                
                if(selectedImage == nil) {
                    Text("No hay imagen seleccionada")
                    .foregroundColor(.gray)
                }
                Button(action: {
                    isImagePickerPresented = true
                }) {
                    Text("Subir Imagen")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                .sheet(isPresented: $isImagePickerPresented, onDismiss: detectQRCode) {
                    ImagePicker(selectedImage: $selectedImage)
                }
            }
        }
        .padding(15)
        .onAppear(perform: checkCameraPermission)
        .alert(errorMessage, isPresented: $showError){
            if cameraPermission == .denied {
                Button("Settings") {
                    let settingsString = UIApplication.openSettingsURLString
                    if let settingsURL = URL(string: settingsString){
                        openURL(settingsURL)
                    }
                }
                Button("Cancel", role: .cancel){
                    
                }
            }
        }
        .onChange(of: qrDelegate.scannedCode){ newValue in
            if let code = newValue{
                scannedCode = code
                isShowingDetail = true
                //qrCodeContent = scannedCode
                if let qrCodeInt = Int(scannedCode) { // Usamos el operador ?? para manejar el caso de nil
                    selectedPicture = pictureViewModel.getPictureById(id: qrCodeInt)
                    isShowingDetail = true
                } else {
                    // Si no se puede convertir a Int, maneja el error (opcional)
                    print("No se pudo convertir el código QR a un número")
                }
                session.stopRunning()
                deactivateScannerAnimation()
                qrDelegate.scannedCode = nil
            }
        }
        .background(
            Group {
                if let picture = selectedPicture {
                    NavigationLink(
                        destination: PictureDetailView(picture: picture, onClose: {
                            isShowingDetail = false
                        }),
                        isActive: $isShowingDetail,
                        label: { EmptyView() }
                    )
                }
            }
        )
        /*.background(
            NavigationLink(
                destination: DetallePintura(id: qrCodeContent),
                isActive: $isShowingDetail,
                label: { EmptyView() }
            )
        )*/
    }
    
    func reactivateCamera(){
        DispatchQueue.global(qos: .background).async {
            session.startRunning()
        }
    }
    
    func activateScannerAnimation(){
        withAnimation(.easeInOut(duration: 0.85).delay(0.1).repeatForever(autoreverses: true)){
            isScanning = true
        }
    }
    
    func deactivateScannerAnimation(){
        withAnimation(.easeInOut(duration: 0.85)){
            isScanning = false
        }
    }
    
    func checkCameraPermission(){
        Task{
            switch AVCaptureDevice.authorizationStatus(for: .video){
            case .authorized:
                cameraPermission = .approved
                if session.inputs.isEmpty {
                    setupCamera()
                } else {
                    session.startRunning()
                }
            case .notDetermined:
                if await AVCaptureDevice.requestAccess(for: .video){
                    cameraPermission = .approved
                    setupCamera()
                } else {
                    cameraPermission = .denied
                    presentError("Dele acceso a la camara para el escaneo de QR")
                }
            case .denied, .restricted:
                cameraPermission = .denied
                presentError("Dele acceso a la camara para el escaneo de QR")
            default: break
            }
        }
    }
    func setupCamera(){
        #if targetEnvironment(simulator)
            esSimulador = true
        #endif
        
        if(esSimulador){
            presentError("Este dispositivo no soporta la cámara. Por favor, usa un dispositivo real.")
            
        } else {
            do {
                guard let device = AVCaptureDevice.DiscoverySession(deviceTypes:[.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first else{
                    presentError("Error de dispositivo")
                    return
                }
                let input = try AVCaptureDeviceInput(device: device)
                guard session.canAddInput(input), session.canAddOutput(qrOutput) else {presentError("Error de E/S")
                    return
                }
                session.beginConfiguration()
                session.addInput(input)
                session.addOutput(qrOutput)
                qrOutput.metadataObjectTypes = [.qr]
                qrOutput.setMetadataObjectsDelegate(qrDelegate, queue: .main)
                session.commitConfiguration()
                
                DispatchQueue.global(qos: .background).async{
                    session.startRunning()
                }
                activateScannerAnimation()
            }catch{
                presentError(error.localizedDescription)
            }
        }
            
        
    }
    func presentError(_ message: String){
        errorMessage = message
        showError.toggle()
    }
    
    private func detectQRCode() {
        guard let selectedImage = selectedImage,
              let ciImage = CIImage(image: selectedImage) else { return }
        
        let context = CIContext()
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        
        if let features = detector?.features(in: ciImage), !features.isEmpty {
            for feature in features as! [CIQRCodeFeature] {
                qrCodeContent = feature.messageString
                if let qrCodeInt = Int(qrCodeContent ?? "") { // Usamos el operador ?? para manejar el caso de nil
                    selectedPicture = pictureViewModel.getPictureById(id: qrCodeInt)
                    isShowingDetail = true
                } else {
                    // Si no se puede convertir a Int, maneja el error (opcional)
                    print("No se pudo convertir el código QR a un número")
                }
            }
        } else {
            qrCodeContent = "No se detectó un código QR en la imagen."
        }
    }
}



