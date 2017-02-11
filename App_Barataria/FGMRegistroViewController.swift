//
//  FGMRegistroViewController.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 17/1/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit
import Parse

class FGMRegistroViewController: UIViewController {
    
    //MARK: - VARIABLES LOCALES
    var fotoSeleccionada = false
    

    
    //MARK: - IBOutlets
    
    @IBOutlet weak var miUsuario: UITextField!
    @IBOutlet weak var miContraseña: UITextField!
    @IBOutlet weak var miNombre: UITextField!
    @IBOutlet weak var miApellido: UITextField!
    @IBOutlet weak var miEmail: UITextField!
    @IBOutlet weak var miMovil: UITextField!
    @IBOutlet weak var miSocio: UITextField!
    @IBOutlet weak var miActivity: UIActivityIndicatorView!
    @IBOutlet weak var miImagenPerfil: UIImageView!

    
    
    
    //MARK: - IBActions
    
    @IBAction func ocultarVista(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func enviarRegistro(_ sender: Any) {
        var errorInicial = ""
        
        if miUsuario.text == "" || miContraseña.text == "" || miNombre.text == "" ||  miSocio.text == "" || miEmail.text == "" || miApellido.text == "" || miImagenPerfil.image == nil || miSocio.text == nil{
            
            errorInicial = "es necesario completar los campos obligatorios"
            
        }
        else{
            
            let userData = PFUser()
            userData.username = miUsuario.text
            userData.password = miContraseña.text
            userData.email = miEmail.text
            userData["nombreUsuario"] = miNombre.text
            userData["apeliidoUsuario"] = miApellido.text
            userData["movilUsuario"] = miMovil.text
            userData["numsocio"] = miSocio.text
            
            
            
            miActivity.isHidden = false
            miActivity.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            userData.signUpInBackground(block: { (envioExitoso, errorRegistro) in
                
                self.miActivity.isHidden = true
                self.miActivity.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                if errorRegistro != nil{
                    
                    if let errorString = (errorRegistro! as NSError).userInfo["error"] as? NSString{
                        self.present(showAlertVC("ATENCION", messageData: errorString as String), animated: true, completion: nil)
                        
                        
                    }
                    else{
                        self.present(showAlertVC("ATENCION", messageData: "Error en el registro"), animated: true, completion: nil)
                    }
                }
                else{
                    
                    
                    print("El usuario se ha salvado correctamente")
                    self.performSegue(withIdentifier: "presentaTabBarController", sender: self)
                    self.salvarImagenEnBackgroundWithBlock()
                    
                    
                }
            })
            
            
        }
        
        if errorInicial != ""{
            
            present(showAlertVC("Estimado usuario", messageData: errorInicial), animated: true, completion: nil)
        }

    }
    
    
    func salvarImagenEnBackgroundWithBlock(){
        
        let postImagen = PFObject(className: "ImageProfile")
        let imageData = UIImageJPEGRepresentation(miImagenPerfil.image!, 0.2)
        let imageFile = PFFile(name: "imagePerfilUsuario" + miNombre.text! + ".jpg", data: imageData!)
        
        postImagen["imageFile"] = imageFile
        postImagen["username"] = PFUser.current()?.username
        
        postImagen.saveInBackground { (salvadoExitoso, errorDeSubidaImagen) in
            
            if salvadoExitoso{
                self.present(showAlertVC("ATENCION", messageData: "Datos salvados exitosamente"), animated: true, completion: nil)

                }
            else{
                self.present(showAlertVC("ATENCION", messageData: "Error en el registro"), animated: true, completion: nil)
            }
            
            print("usuario registrado correctamente")
            self.miNombre.text = ""
            self.miEmail.text = ""
            self.miMovil.text = ""
            self.miApellido.text = ""
            self.miContraseña.text = ""
            self.miUsuario.text = ""
            self.miSocio.text = ""
            self.miImagenPerfil.image = UIImage(named: "login")
        }
        
    }
    
    

    //MARK: - LIFE VC
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        miActivity.isHidden = true
        
        miImagenPerfil.isUserInteractionEnabled = true
        
        let gestoReconocimiento = UITapGestureRecognizer(target: self, action: #selector(FGMRegistroViewController.showCamaraFotos))
        miImagenPerfil.addGestureRecognizer(gestoReconocimiento)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if PFUser.current()?.username != nil{
            performSegue(withIdentifier: "presentaTabBarController", sender: self)
        }
        else{
            print("El usuario no existe todavia")
        }

    }
    

    //MARK: - UTILS
    func showCamaraFotos(){
        pickPhoto()
    }
}


    //MARK: - DELEGATE UIIMAGEPICKERCONTROLLER (CAMARA DEL DISPOSITIVO)
    
extension FGMRegistroViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
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
        
        
        
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
            fotoSeleccionada = true
            miImagenPerfil.image = image
            dismiss(animated: true, completion: nil)
    }
        
        
}




