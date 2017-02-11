//
//  FGMModificarPerfilViewController.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 7/2/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit
import Parse

class FGMModificarPerfilViewController: UIViewController {
    
    //MARK: - Variables
      var fotoSeleccionada = false
    
    
    //MARK: - IBOutlet
    @IBOutlet weak var miImagenPerfil: UIImageView!
    @IBOutlet weak var miUsuario: UITextField!
    @IBOutlet weak var miContraseña: UITextField!
    @IBOutlet weak var miNombre: UITextField!
    @IBOutlet weak var miApellidos: UITextField!
    @IBOutlet weak var miEmail: UITextField!
    @IBOutlet weak var miMovil: UITextField!
    @IBOutlet weak var miSocio: UITextField!
    @IBOutlet weak var myUserActivity: UIActivityIndicatorView!
    
    
    //MARK: - IBActions
    
    @IBAction func btnActualizarDatos(_ sender: Any) {
        actualizarDatosParaParse()

    }
    

    //MARK: - LIFE VC
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myUserActivity.isHidden = true
        
        miImagenPerfil.isUserInteractionEnabled = true
        
        let gestoReconocimiento = UITapGestureRecognizer(target: self, action: #selector(FGMModificarPerfilViewController.showCamaraFotos))
        miImagenPerfil.addGestureRecognizer(gestoReconocimiento)
        
        actualizarDatos()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: - UTILS
    
    
    
    func showAlert(_ titleData:String,messageData:String) -> UIAlertController{
        
        let alertVC = UIAlertController(title: titleData, message: messageData, preferredStyle: .alert)
        alertVC.addAction((UIAlertAction(title: "OK", style: .default, handler: nil)))
        let when = DispatchTime.now() + 5
        DispatchQueue.main.asyncAfter(deadline: when){
            alertVC.dismiss(animated: true, completion: nil)
        }
        return alertVC
    }
    
    
    func actualizarDatosParaParse(){
        
        let userData = PFUser.current()!
        userData["nombreUsuario"] = miNombre.text
        userData["apeliidoUsuario"] = miApellidos.text
        userData["movilUsuario"] = miMovil.text
        userData["numsocio"] = miSocio.text
        userData["email"] = miEmail.text
        myUserActivity.isHidden = false
        myUserActivity.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        userData.saveInBackground { (actualizacionExitosa, actualizacionError) in
            self.myUserActivity.isHidden = true
            self.myUserActivity.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            if actualizacionExitosa{
                
                self.updatePhoto()
                print("Actualizacion Exitosa")
                

            }
            else{
                print("No se ha podido guardar")
            }
        }
        
        
    }
    
    
    func updatePhoto(){
        
        let postImagenParse = PFObject(className: "Post")
        let imageData = UIImageJPEGRepresentation(miImagenPerfil.image!, 0.4)
        let imageFile = PFFile(name: "imagenPerfilUsuario" + miNombre.text! + ".jpg", data: imageData!)
        postImagenParse["imageFile"] = imageFile
        postImagenParse["username"] = PFUser.current()?.username
        myUserActivity.isHidden = false
        myUserActivity.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        postImagenParse.saveInBackground(block: { (exitosaSubidaImagen, errorSubidaImagen) in
            self.myUserActivity.isHidden = true
            self.myUserActivity.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            if exitosaSubidaImagen{
                let alertVC = UIAlertController(title: "Estimado usuario", message: "Tus datos han sido actualizados correctamente", preferredStyle: .alert)
                alertVC.addAction((UIAlertAction(title: "OK", style: .default, handler: nil)))
                self.present(alertVC, animated: true, completion: nil)
            }
            else{
                self.present(showAlertVC("Estimado usuario", messageData: "Tu foto NO ha sido publicada"), animated: true, completion: nil)
            }
            
        })
    }
    
    func actualizarDatos(){
        
        //1 consulta
        
        let queryUser = PFUser.query()!
        queryUser.whereKey("username", equalTo: (PFUser.current()?.username)!)
        queryUser.findObjectsInBackground { (objectUno, errorUno) in
            if errorUno == nil{
                if let objectUnoDes = objectUno{
                    for objectDataUnoDes in objectUnoDes{
                        //2. Consulta
                        let queryImage = PFQuery(className: "ImageProfile")
                        queryImage.whereKey("username", equalTo: (PFUser.current()?.username)!)
                        queryImage.findObjectsInBackground(block: { (objectDos, errorDos) in
                            if errorDos == nil{
                                if let objectDosDes = objectDos{
                                    for objectDataDosDes in objectDosDes{
                                        let usernameFile = objectDataDosDes["imageFile"] as! PFFile
                                        //3. consulta
                                        usernameFile.getDataInBackground(block: { (imageData, imageError) in
                                            if imageError == nil{
                                                if let imageDataDes = imageData {
                                                    let image = UIImage(data: imageDataDes)
                                                    self.miImagenPerfil.image = image
                                                }
                                            }
                                        })
                                    }
                                }
                            }
                        })
                        self.miNombre.text = objectDataUnoDes["nombreUsuario"] as? String
                        self.miApellidos.text = objectDataUnoDes["apeliidoUsuario"] as? String
                        self.miMovil.text = objectDataUnoDes["movilUsuario"] as? String
                        self.miSocio.text = objectDataUnoDes["numsocio"] as? String
                        self.miEmail.text = PFUser.current()?.email
                        
                        
                    }
                }
                
            }
        }
        
    }
    
    func showCamaraFotos(){
        pickPhoto()
    }

    
}


//MARK: - DELEGATE UIIMAGEPICKERCONTROLLER (CAMARA DEL DISPOSITIVO)

extension FGMModificarPerfilViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func pickPhoto(){
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            showMenu()
        }
        else{
            choosePhotoFromLibrary()
        }
        
    }
    
    
    func showMenu(){
        
        
        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let takePhotoCameraAction = UIAlertAction(title: "Tomar Foto", style: .default) { (void) in
            self.takePhotoWithCamera()
        }
        
        let choosePhotoFromLibraryAction = UIAlertAction(title: "Escoge de la libreria", style: .default) { (void) in
            self.choosePhotoFromLibrary()
        }
        
        alertVC.addAction(cancelAction)
        alertVC.addAction(takePhotoCameraAction)
        alertVC.addAction(choosePhotoFromLibraryAction)
        
        present(alertVC, animated: true, completion: nil)
        
        
        
        
        
    }
    
    
    func takePhotoWithCamera(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
    
    func choosePhotoFromLibrary(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        fotoSeleccionada = true
        miImagenPerfil.image = image
        dismiss(animated: true, completion: nil)
    }
    
    
}
