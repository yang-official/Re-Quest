//
//  FindVC.swift
//  ReQuest_ios
//
//  Created by Leon Mak on 9/9/17.
//  Copyright © 2017 Leon Mak. All rights reserved.
//

import UIKit
import SceneKit
import MapKit
import ARCL
import SatoriRtmSdkWrapper

class FindVC: UIViewController, MKMapViewDelegate, SceneLocationViewDelegate {
    let sceneLocationView = SceneLocationView()

    let mapView = MKMapView()
    var userAnnotation: MKPointAnnotation?
    var locationEstimateAnnotation: MKPointAnnotation?
    var updateUserLocationTimer: Timer?
    
    ///Whether to show a map view
    var showMapView = true
    var centerMapOnUserLocation: Bool = true
    var displayDebugging = false
    
    var updateInfoLabelTimer: Timer?
    var adjustNorthByTappingSidesOfScreen = false
    
    @IBOutlet weak var centerMapBtn: UIButton!
    var quests = Faker.instance.getQuests()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Display an arrow which points north.
        sceneLocationView.orientToTrueNorth = true
        sceneLocationView.locationEstimateMethod = .coreLocationDataOnly
        sceneLocationView.locationDelegate = self
        view.addSubview(sceneLocationView)
        
        // SHOW HALF MAP VIEW
        if showMapView {
            mapView.delegate = self
            mapView.showsUserLocation = true
            mapView.alpha = 0.8
            view.addSubview(mapView)
        
            updateUserLocationTimer = Timer.scheduledTimer(
                timeInterval: 1,
                target: self,
                selector: #selector(FindVC.updateUserLocation),
                userInfo: nil,
                repeats: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func placePinsOnMap() {
        for quest in quests {
            let (lat, lng) = quest.location
            let pinCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            if quest.mapAnnotation == nil {
                let annotation = MKPointAnnotation()
                annotation.coordinate = pinCoordinate
                mapView.addAnnotation(annotation)
                quest.mapAnnotation = annotation
            } else {
                quest.mapAnnotation?.coordinate = pinCoordinate
            }
        }
    }
    
    func placePinsInARScene() {
        for quest in quests {
            let pinCoordinate = CLLocationCoordinate2D(latitude: quest.location.lat, longitude: quest.location.lng)
            let pinLocation = CLLocation(coordinate: pinCoordinate, altitude: 30)
            let pinImage = UIImage(named: quest.category.getMarkerPin())!
            if quest.annotation == nil {
                let annotation = LocationAnnotationNode(location: pinLocation, image: pinImage)
                sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotation)
                quest.annotation = annotation
            } else {
                quest.annotation?.location = pinLocation
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sceneLocationView.frame = CGRect(x: 0, y: 0, 
                                         width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        mapView.frame = CGRect(x: 0, y: self.view.frame.size.height / 2,
                               width: self.view.frame.size.width, height: self.view.frame.size.height / 2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func updateUserLocation() {
        if let currentLocation = sceneLocationView.currentLocation() {
            DispatchQueue.main.async {
                if self.userAnnotation == nil {
                    self.userAnnotation = MKPointAnnotation()
                    // Add initial map marker
                    self.mapView.addAnnotation(self.userAnnotation!)
                }

                // Update map user coordinates and map
                UIView.animate(withDuration: 0.5, delay: 0.3, options: UIViewAnimationOptions.allowUserInteraction, animations: {
                    self.userAnnotation?.coordinate = currentLocation.coordinate
                }, completion: nil)
                if self.centerMapOnUserLocation {
                    UIView.animate(withDuration: 0.5, delay: 0.3, options: UIViewAnimationOptions.allowUserInteraction, animations: {
                        self.mapView.setCenter(self.userAnnotation!.coordinate, animated: false)
                    }, completion: { _ in
                        self.mapView.region.span = MKCoordinateSpan(latitudeDelta: 0.0006, longitudeDelta: 0.0006)
                    })
                }

            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if let touch = touches.first {
            if touch.view != nil {
                if (mapView == touch.view! || mapView.recursiveSubviews().contains(touch.view!)) {
                    centerMapOnUserLocation = false
                } else {
                    let location = touch.location(in: self.view)
                    print("Touched", location)
                    centerMapOnUserLocation = true
                }
            }
        }
    }
    
    //MARK: MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let _ = annotation as? MKPointAnnotation {
            let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: nil)
            marker.displayPriority = .required
            marker.glyphImage = UIImage(named: "user_pin")
            return marker
        }
        return nil
    }
    
    // MARK: SceneLocationViewDelegate
    func sceneLocationViewDidConfirmLocationOfNode(sceneLocationView: SceneLocationView, node: LocationNode) {
    }
    
    func sceneLocationViewDidSetupSceneNode(sceneLocationView: SceneLocationView, sceneNode: SCNNode) {
        // Place pins on ARScene & Map
        self.placePinsInARScene()
        self.placePinsOnMap()
    }
    
    func sceneLocationViewDidAddSceneLocationEstimate(sceneLocationView: SceneLocationView, position: SCNVector3, location: CLLocation) {
    }
    
    func sceneLocationViewDidUpdateLocationAndScaleOfLocationNode(sceneLocationView: SceneLocationView, locationNode: LocationNode) {
    }
    
    func sceneLocationViewDidRemoveSceneLocationEstimate(sceneLocationView: SceneLocationView, position: SCNVector3, location: CLLocation) {
    }
    
    // MARK: Satori
    @objc func handleSatoriMessage(_ notification: NSNotification) {
        // Update pins on ARScene & Map
        self.placePinsInARScene()
        self.placePinsOnMap()
        print(notification)
    }
    
    // MARK: Setup
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NSLog("run session")
        sceneLocationView.run()
        
        // Observe Satori RTM Connection messages
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleSatoriMessage(_:)),
                                               name: NSNotification.Name(rawValue: Constants.NotificationKey.Satori), object: nil)
        
    }
    
    // MARK: Clean up
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSLog("pause session")
        sceneLocationView.pause()
        NotificationCenter.default.removeObserver(self)
    }
    
}
