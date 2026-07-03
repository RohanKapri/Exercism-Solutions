import Foundation

enum sizeDna:Error{
    
    case lengtherror
}

struct Hamming {
    
    static func compute(_ dnaSequence: String, against: String) throws -> Int? {
        // Write your code for the 'Hamming' exercise in this file.
        
        var dnaArray: [Character] = Array(dnaSequence)
        var againstArray: [Character] = Array(against)
        var lentghdna: Int = dnaSequence.count
        
        var numdiff : Int = 0
        
        if dnaSequence.count != against.count {
            throw sizeDna.lengtherror
        }else {
            for i in 0..<lentghdna {
                if dnaArray[i] != againstArray[i] {
                    numdiff += 1
                }
            }
        }
        
        
        return numdiff
    }
    
    
    
    
    
    
}