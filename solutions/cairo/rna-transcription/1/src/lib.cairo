pub fn to_rna(dna: ByteArray) -> ByteArray {
    let mut rna: ByteArray = "";
    let mut i = 0;
    
    while i < dna.len() {
        let nucleotide = dna[i];
        
        if nucleotide == 'G' {
            rna += "C";
        } else if nucleotide == 'C' {
            rna += "G";
        } else if nucleotide == 'T' {
            rna += "A";
        } else if nucleotide == 'A' {
            rna += "U";
        } else {
            panic!("Invalid DNA nucleotide");
        }
        
        i += 1;
    };
    
    rna
}
   