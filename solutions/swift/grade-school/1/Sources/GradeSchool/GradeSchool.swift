
import Foundation

class GradeSchool {
    
    var listOfname : [String]
    var nameAndGrade : [(String , Int)]
    
    // Write your code for the 'GradeSchool' exercise in this file.
    init(){
        self.listOfname = [String]()
        self.nameAndGrade = [(String,Int)]()
        
    }
    
    
  func roster() -> [String]{
        
        
        
        var tritri : [Int] = Set( self.nameAndGrade .reduce(into: [Int]()){$0.append($1.1) }).sorted(by: <)
        
        
        var tab : [[(String ,Int)]] = []
        
        for i in tritri{
            var tabgrade  = [(String ,Int)]()
            for element in self.nameAndGrade {
                
                
                if element.1 == i{
                    
                    tabgrade.append(element)
                    
                    
                    
                    
                }
            }
            tab.append(tabgrade)
            
        }
        
        var tab2 = [[(String ,Int)]]()
        
        
        for i in tab {
            
            
            var tabtab =  i.sorted(by: { $0.0 < $1.0 })
            tab2.append(tabtab)
        }
        
        
        
        
        let arrayname = tab2.flatMap{$0}.reduce(into: [String]()){$0.append($1.0)}

       
      
        return arrayname
         
    }
    
    
    
    func addStudent(_ name : String , grade student : Int) -> Bool {
        var nameGrade : (String ,Int) = (name , student)
        var look :Bool =  self.listOfname.contains(name) ? false  : true        
        if look == true  {                         
            self.listOfname.append(name)
            self.nameAndGrade.append(nameGrade)
            
        }
        
        return  look            
            
            
            
            
    }
    
   func studentsInGrade(_ grade : Int) -> [String] {
        
     
        let grade1 = self.nameAndGrade.reduce(into: [Int]()){$0.append($1.1) }
        if grade1.contains(grade){
            let liststudent :[String]   = self.nameAndGrade.filter({$0.1 == grade}).reduce(into: []) { $0.append($1.0)}             
            
            return liststudent.sorted()
            
            
        }
        
       return []
        
    }
    
    
}
