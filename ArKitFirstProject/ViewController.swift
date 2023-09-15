//
//  ViewController.swift
//  ArKitFirstProject
//
//  Created by Atil Samancioglu on 18.08.2019.
//  Copyright © 2019 Atil Samancioglu. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

// ARKit arttırılmış gerçekliği kullandığımız kit. gerçek dünyamıza iki ya da üç boyutlu objeleri getirdiğimiz ve telefonun kamerasından sanki gerçekten o objeler oradaymış gibi görüntülediğimiz (pokemongo oyununda yaptıkları gibi) ve o objeleri kamera üstünden oynatabildiğimiz bir kit.

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // arkit i kullanabilmek için telefonun en az A9 Chip e sahip olması lazım -> yani iPhone 6S +++
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let shipScene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = shipScene
        
        for node in sceneView.scene.rootNode.childNodes { // rootNode kök node u verir yani kökte gösterilen ana ekrandaki node u verir. onun içerisinde birden fazla node birden fazla görünüm elde edebiliyoruz. childNodes ile de içerisine eklediğimiz tüm görünümleri elde edebileceğimiz bir veri/dizi verir. o verinin içerisindeki her node u her bir görünümü node diye oluşturduğumuz değişkene aktarıyoruz
            
            let moveShip = SCNAction.moveBy(x: 1, y: 0.5, z: -0.5, duration: 1) // moveBy a x, y ve z eksenlerinde ne kadar hareket ettireceğimizi yazarız. duration a da nası bir süreçte bunu yapacağımızı yazarız. yarım metre yukarı fırlatsın(y), yarım metre benden uzaklaşsın(z)-pozitif değer verseydik yakınlaşırdı, duration da 1 sn olsun
            let fadeOut = SCNAction.fadeOpacity(to: 0.5, duration: 1) // to ya 0.5 vermek transparan bir hale getirir
            let fadeIn = SCNAction.fadeOpacity(to: 1, duration: 1) // to ya 1 vermek normal haline getirir
            let sequence = SCNAction.sequence([moveShip,fadeOut,fadeIn]) // oluşturmak istediğimiz aksiyon listesini sequence a yazarız

            let repeatForever = SCNAction.repeatForever(sequence) // uçağın devamlı bi transparan bi normal hareket etmesi için
            
            node.runAction(repeatForever) // gemiye vericeğimiz aksiyonu yazıyoruz
            
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration() // ARWorldTrackingConfiguration bu bir objeyi odanın içine koyduğumuzda gerçekten o odanın konumunu bulup yani o odada nerde durması gerektiğini bulup kendini oraya sabitleyebilme özelliğidir. biz yürüdükçe bizimle yürüyen değil orda duran gerçekçi bir obje görürüz

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
