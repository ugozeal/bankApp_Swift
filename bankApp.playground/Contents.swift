import UIKit

// Creating an account class
class Account {
    
// Creating Properties for Account class
    var id: Int = 123456
    var customerId: Int = 0
    var accountBalance : Int = 0
    var interestRate : Double = 0.0
    
    init( customerId:Int ) {
        self.customerId = customerId
        self.id += 1
    }
//    Withdrawal Method
    func withdrawal(amount:Int) -> String {
        self.accountBalance > amount ? "Your new Account Balalnce is \(self.accountBalance -= amount * 100)" : "Invalid Request"
    }
    
//    Deposit method
    func deposit (amount: Int) -> String {
        self.accountBalance += amount * 100
        return "Your new account balance is \(self.accountBalance)"
    }
    
//    Charge method
    func charge ()-> Int {
        self.accountBalance -= 10000
        return self.accountBalance
    }
    
//    Bonus Method
    func bonus() -> Int {
        self.accountBalance += 100
        return self.accountBalance
    }
}
var test = Account(customerId: 1)
test.id
var tw = Account(customerId: 2)
tw.id
var te = Account(customerId: 5)
te.id


// Savings account
class SavingsAccount: Account {
    override var interestRate: Double {
        get{ return 0.1 }
        set{ }
    }
    
    override func deposit(amount: Int) -> String {
        amount <= 0 ? "Invalid Deposit amount" : "Your new account balance is \(self.accountBalance += amount + self.bonus())"
    }
}

//  Current Account

class CurrentAccount: Account {
    override var interestRate: Double {
           get{ return 0.05 }
           set{ }
       }
    
    override func withdrawal(amount: Int) -> String {
        self.accountBalance > amount ? "You Withdrew \(self.accountBalance -= amount * 100 + self.charge())" : "Your account balance is too low for the transaction"
    }
    
}




// Creating a Customer Class

class Customer {
    let id: Int = 0
    let name: String
    var address: String
    var phoneNumber: String
    var optionalAccount: [Account] = []
    init(name:String, address:String, phoneNumber:String) {
        self.address = address
        self.name = name
        self.phoneNumber = phoneNumber
    }
// Opening
    func openAnAccount(typeOfAccount: AccountType) -> [Account]{
        switch typeOfAccount {
        case .savings:
            let newSavingsAccount = SavingsAccount(customerId:self.id)
            optionalAccount.append(newSavingsAccount)
        case .current:
            let newCurrentAccount = CurrentAccount(customerId:self.id)
            optionalAccount.append(newCurrentAccount)
        }
        return optionalAccount
    }
    
//    Account Balance
    func customerAccountBalance (customerAccount: Account) -> String {
        return "Your account balance is \(customerAccount)"
    }
    
//    Withdrawal Method
    func customerWithdrawal(customerAccount: Account, amount: Int) -> String {
        let take = customerAccount.withdrawal(amount: amount)
        return "You have withdrawn \(take)"
    }
//    Deposit Method
    func customerDeposit(customerAccount: Account, amount: Int) -> String {
        return "You have deposited \(customerAccount.deposit(amount: amount))"
    }
//  Deleting an account
    func deleteCustomerAccount(customerAccount: Account) -> [Account] {
        optionalAccount.removeAll(where:{$0 === customerAccount})
        return optionalAccount
    }
    
}

// Creating The Enum Accountype
enum AccountType{
    case savings
    case current
}
var ssg = Customer(name: "ugo", address: "uno", phoneNumber: "1234567890")
ssg.openAnAccount(typeOfAccount: .savings)
ssg.optionalAccount[0].customerId

var ssk = Customer(name: "ug3", address: "un3", phoneNumber: "123567890")
ssk.openAnAccount(typeOfAccount: .current)

ssk.optionalAccount.count




