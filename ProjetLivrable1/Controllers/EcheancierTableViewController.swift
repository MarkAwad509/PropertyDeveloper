import UIKit

class EcheancierTableViewController: UITableViewController {
    var paiements: [Paiement] = []
    
    override func viewDidLoad() {
        self.paiements = PaiementDAO.shared.Paiements()
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paiements.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EcheancierCell", for: indexPath) as? EcheancierCell
        
        let paiement = self.paiements[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        
        
        if paiement.mode == "cash"{
            cell?.lbl_montant?.text = String(paiement.montant) + "$"
            cell?.lbl_date?.text = formatter.string(for: paiement.datePaiement)
            cell?.lbl_date2?.text = ""
            cell?.lbl_paymentMode?.text = paiement.mode
            cell?.lbl_nomConvention?.text = paiement.convention?.domaine
        } else {
            cell?.lbl_montant?.text = String(paiement.montant) + "$"
            cell?.lbl_date?.text = formatter.string(for: paiement.dateDebut) ?? "dd/MM/YYYY"
            cell?.lbl_date2?.text = formatter.string(for: paiement.dateFin) ?? "dd/MM/YYYY"
            cell?.lbl_paymentMode?.text = paiement.mode
            cell?.lbl_nomConvention?.text = paiement.convention?.domaine
        }
        
        return cell!
    }
}
