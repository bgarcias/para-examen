//
//  EditPersonViewController.swift
//  Clase34CoreData
//
//  Created by Escurra Colquis on 25/11/24.
//

import UIKit //importamos la UI
import CoreData //importamos para usar base de datos

class EditPersonViewController: UIViewController {
    //componentes de la UI
    @IBOutlet weak var nameEditTextField: UITextField!
    @IBOutlet weak var mailEditTextField: UITextField!
    @IBOutlet weak var salaryEditTextField: UITextField!
    
    
    //variables
    var personUpdate: Person? //creamos el objeto de tipo Person de la base de datos
    
    //carga en memoria
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField() //llamamos a la función para configurar los campos de texto
    }
    
    //Funciones
    //función para la conexión a la base de datos
    func connectBD() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate //instanciamos y llamamos al AppDelegate
        return delegate.persistentContainer.viewContext //retornamos el contexto de Coredata del AppDelegate
    }
    
    //función para cofigurar a los campos de texto
    func configureTextField() {
        nameEditTextField.text = personUpdate?.name //nombre
        mailEditTextField.text = personUpdate?.email
        salaryEditTextField.text = personUpdate?.salario != nil ? String(format: "%.2f", personUpdate!.salario) : "" // convierte Double a String con 2 decimales
    }
    
    //función para actualizar persona
    func editPerson() {
        let context = connectBD() //contexto para conectarnos a la base de datos
        personUpdate?.setValue(nameEditTextField.text, forKey: "name") //le pasamos el nombre al campo de texto 1
        personUpdate?.setValue(mailEditTextField.text, forKey: "email")
        personUpdate?.setValue(Double(salaryEditTextField.text ?? "0") ?? 0.0, forKey: "salario") // Parseo simple a Double

        //capturador de errores
        do {
            try context.save() //guardamos en base de datos
            navigationController?.popViewController(animated: true) //retornamos a la pantalla anterior
            print("Se actualizó al usuario persona") //imprimimos por consola
        } catch let error as NSError {
            //aca va el error
            //podriamos poner una vista en especifica pero por el momento solo imprimimos por consola
            print("Error al actualziar: \(error.localizedDescription)")
        }
    }
    
    //acción del botón para actualizar los datos
    @IBAction func didTapEdit(_ sender: UIButton) {
        editPerson() //llamamos a la función para editar personas
    }
}
