//
//  EcheancierCell.swift
//  ProjetLivrable1
//
//  Created by Mark Awad on 2023-03-16.
//

import UIKit

class EcheancierCell: UITableViewCell {

    @IBOutlet weak var lbl_montant: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_date2: UILabel!
    @IBOutlet weak var lbl_paymentMode: UILabel!
    @IBOutlet weak var lbl_nomConvention: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
