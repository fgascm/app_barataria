//
//  FGMActividdesDetalleVC.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 3/2/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit
import MapKit
import EventKit

class FGMActividdesDetalleVC: UIViewController {
    
    
    //MARK: - VARIABLES
    var modeloActividadesData : FGMActividadesModel?
    var savedEventId : String = ""
    var fechaFin : String?
    var fec_mostrar : String?
    
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var myNombreLBL: UILabel!
    @IBOutlet weak var myFechaLBL: UILabel!
    @IBOutlet weak var myTipoLBL: UILabel!
    @IBOutlet weak var myPlazasLBL: UILabel!
    @IBOutlet weak var myLugarLBL: UILabel!
    @IBOutlet weak var myPrecioNo: UILabel!
    @IBOutlet weak var myPrecioLBL: UILabel!
    @IBOutlet weak var myFechaFinLBL: UILabel!
    @IBOutlet weak var myDescripcionLBL: UILabel!
    @IBOutlet weak var myImagenLogo: UIImageView!
    @IBOutlet weak var degradadoImageView: UIImageView!
    @IBOutlet weak var myCalendario: UIButton!
    @IBOutlet weak var myBtnDoc: UIButton!
    @IBOutlet weak var myMapa: MKMapView!
    @IBOutlet weak var myImagenActividad: UIImageView!
    
    
    //MARK: - IBActions
    
    @IBAction func btnCalendario(_ sender: Any) {
        let eventStore = EKEventStore()
        
        
        //Formateo de las fechas de inicio y fin de la actividad
        let startDate = getTheStringDate(stringForInputDate: fec_mostrar!, fromFormat: "ddMMyyyy", toFormat: "ddMMyyyy")
        let endDate = getTheStringDate(stringForInputDate: fechaFin!, fromFormat: "ddMMyyyy", toFormat: "ddMMyyyy")
        
        
        
        if (EKEventStore.authorizationStatus(for: .event) != EKAuthorizationStatus.authorized) {
            eventStore.requestAccess(to: .event, completion: {
                granted, error in
                self.createEvent(eventStore, title: (self.modeloActividadesData?.Nombre)!, startDate: startDate as Date, endDate: endDate as Date)
                
            })
        } else {
            createEvent(eventStore, title: (self.modeloActividadesData?.Nombre)!, startDate: startDate as Date, endDate: endDate as Date)
        }
        
        
    }
    
    
    
    //MARK: - Utilidades
    func getTheDateString(stringForInputDate: String, fromFormat inputFormat: String, toFormat outputFormat: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = inputFormat
        formatter.timeZone = NSTimeZone.local
        let dateForInput: NSDate = formatter.date(from: stringForInputDate)! as NSDate
        formatter.dateFormat = outputFormat
        return formatter.string(from: dateForInput as Date)
    }
    
    
    
    func getTheStringDate(stringForInputDate: String, fromFormat inputFormat: String, toFormat outputFormat: String) -> NSDate {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = inputFormat
        formatter.timeZone = NSTimeZone.local
        let dateForInput: NSDate = formatter.date(from: stringForInputDate)! as NSDate
        //formatter.dateFormat = outputFormat
        return dateForInput
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Identifico el segue por el que estamos pasando
        if segue.identifier == "verPDF" {
            //creamos la instancia del objeto que recibira los datos de una ventana
            
            let ventanaPDF = segue.destination as! FGMActividadesDocumentoViewController
            ventanaPDF.myUrl = (modeloActividadesData?.Doc)!
            
            
            
        }
    }
    
    
    
    // Creates an event in the EKEventStore. The method assumes the eventStore is created and
    // accessible
    func createEvent(_ eventStore: EKEventStore, title: String, startDate: Date, endDate: Date) {
        let event = EKEvent(eventStore: eventStore)
        
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.calendar = eventStore.defaultCalendarForNewEvents
        do {
            try eventStore.save(event, span: .thisEvent)
            savedEventId = event.eventIdentifier
            self.present(showAlertVC("Atención", messageData: "Actividad añadida al calendario"), animated: true, completion: nil)
        } catch {
            print("Bad things happened")
        }
        
    }
    
    // Removes an event from the EKEventStore. The method assumes the eventStore is created and
    // accessible
    func deleteEvent(_ eventStore: EKEventStore, eventIdentifier: String) {
        let eventToRemove = eventStore.event(withIdentifier: eventIdentifier)
        if (eventToRemove != nil) {
            do {
                try eventStore.remove(eventToRemove!, span: .thisEvent)
            } catch {
                print("Bad things happened")
            }
        }
    }
    
    
    
    
    
    
    //MARK: - Vida VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        //ASIGNACIÓN VALORES A LABEL
        myNombreLBL.text = modeloActividadesData?.Nombre
        myDescripcionLBL.text = modeloActividadesData?.Descripcion
        myLugarLBL.text = modeloActividadesData?.Lugar
        //myFechaLBL.text = modeloActividadesData?.Inicio
        myPlazasLBL.text = String(modeloActividadesData!.Plazas!)
        //myFechaFinLBL.text = modeloActividadesData?.Fin
        myPrecioLBL.text = (String(modeloActividadesData!.Precio!) + "€") as String
        myPrecioNo.text = (String(modeloActividadesData!.PrcioNo!) + "€") as String
        myPlazasLBL.text = modeloActividadesData?.Plazas
        myTipoLBL.text = modeloActividadesData?.Tipo
        let url = URL(string: (modeloActividadesData?.Imagen!)!)
        myImagenActividad.kf.setImage(with: url)

        
        
        //Formateo de fecha
        let fecha = modeloActividadesData?.Inicio
        var startIndex = fecha?.index((fecha?.startIndex)!, offsetBy: 8)
        var endIndex = fecha?.index((fecha?.startIndex)!, offsetBy: 9)
        
        var dia = fecha?[startIndex!...endIndex!]
        
        startIndex = fecha?.index((fecha?.startIndex)!, offsetBy: 5)
        endIndex = fecha?.index((fecha?.startIndex)!, offsetBy: 6)
        var mes = fecha?[startIndex!...endIndex!]
        
        startIndex = fecha?.index((fecha?.startIndex)!, offsetBy: 0)
        endIndex = fecha?.index((fecha?.startIndex)!, offsetBy: 3)
        var anio = fecha?[startIndex!...endIndex!]
        
        
        fec_mostrar = (dia! + "" + mes! + "" + anio!) as String
        myFechaLBL.text = (dia! + "-" + mes! + "-" + anio!) as String
        
        let fin = modeloActividadesData?.Fin
        
        startIndex = fin?.index((fin?.startIndex)!, offsetBy: 8)
        endIndex = fin?.index((fin?.startIndex)!, offsetBy: 9)
        
        dia = fin?[startIndex!...endIndex!]
        
        startIndex = fin?.index((fin?.startIndex)!, offsetBy: 5)
        endIndex = fin?.index((fin?.startIndex)!, offsetBy: 6)
        mes = fin?[startIndex!...endIndex!]
        
        startIndex = fin?.index((fin?.startIndex)!, offsetBy: 0)
        endIndex = fin?.index((fin?.startIndex)!, offsetBy: 3)
         anio = fin?[startIndex!...endIndex!]
        
        
        fechaFin = (dia! + "" + mes! + "" + anio!) as String

        
        
        let limite = modeloActividadesData?.FecLimite
        
        startIndex = limite?.index((limite?.startIndex)!, offsetBy: 8)
        endIndex = limite?.index((fin?.startIndex)!, offsetBy: 9)
        dia = limite?[startIndex!...endIndex!]
        
        startIndex = limite?.index((limite?.startIndex)!, offsetBy: 5)
        endIndex = limite?.index((limite?.startIndex)!, offsetBy: 6)
        mes = limite?[startIndex!...endIndex!]
        
        startIndex = limite?.index((limite?.startIndex)!, offsetBy: 0)
        endIndex = limite?.index((limite?.startIndex)!, offsetBy: 3)
        anio = limite?[startIndex!...endIndex!]

        
        
        myFechaFinLBL.text = (dia! + "-" + mes! + "-" + anio!) as String
        
        
        
        //TRATAMIENTO LOGO, DEGRADADO Y BOTON CALENDARIO
        myImagenLogo.layer.cornerRadius = myImagenLogo.frame.width / 2
        myImagenLogo.layer.borderColor = UIColor.white.cgColor
        myImagenLogo.layer.borderWidth = 1.5
        myImagenLogo.clipsToBounds = true
        
        degradadoImageView.layer.cornerRadius = degradadoImageView.frame.width / 2
        degradadoImageView.layer.borderColor = UIColor.green.cgColor
        degradadoImageView.layer.borderWidth = 1.5
        degradadoImageView.clipsToBounds = true
        
        myCalendario.layer.cornerRadius = myCalendario.frame.width / 8
        myBtnDoc.layer.cornerRadius = myBtnDoc.frame.width / 8
        
        
        //MAPA
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(modeloActividadesData!.Latitud!, modeloActividadesData!.Longitud!), span: MKCoordinateSpanMake(0.01, 0.01))
        
        myMapa.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = CLLocationCoordinate2DMake(modeloActividadesData!.Latitud!, modeloActividadesData!.Longitud!)
        annotation.title = modeloActividadesData?.Nombre
        annotation.subtitle = modeloActividadesData?.Lugar
        myMapa.addAnnotation(annotation)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

