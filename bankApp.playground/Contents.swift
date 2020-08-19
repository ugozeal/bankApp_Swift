import UIKit

var customerAccId = 88998777
// Creating an account class
class Account {
    
// Creating Properties for Account class
    var id: Int
    var customerId: Int
    var accountBalance : Int = 0
    var interestRate : Double = 0.0
    
//  Initialization of the Account properties in order to create instances of the class
    init( customerId:Int ) {
        self.id = 0
        customerAccId += 1
        self.customerId = customerId
        self.id += customerAccId
    }
    
//    Withdrawal Method
    func withdrawal(amount:Int) -> Int {
//        Abstraction: the method withdrawal is seen by the user but doesn't know what operation takes place beneath
        let amountInKobo = amount * 100
        if amountInKobo > self.accountBalance || amountInKobo <= 0 {
            print("invalid amount to withdraw")
            return self.accountBalance
        } else {
            self.accountBalance -= amountInKobo
        }
        return self.accountBalance
    }
    
//    Deposit method
    func deposit (amount: Int) -> Int {
//    Abstraction: the deposit withdrawal is seen by the user but doesn't know what operation takes place beneath
        let amountInKobo = amount * 100
        accountBalance += amountInKobo
        return self.accountBalance
    }
    
//    Charge method
    func charge ()-> Int {
//    Abstraction: the charge Method is seen by the user but doesn't know what operation takes place beneath
        self.accountBalance -= 10000
        return self.accountBalance
    }
    
//    Bonus Method
    func bonus() -> Int {
//    Abstraction: the bonus method is seen by the user but doesn't know what operation takes place beneath
        self.accountBalance += 1000
        return self.accountBalance
    }
}



// Creating Savings Accounts
//  Savings Account exhibits inheritance from the parent class which is Account
class SavingsAccount: Account {
//    Override Method
//    Override keyword is called to override the interest rate from the parent class
    override var interestRate: Double {
        get{ return 0.1 }
        set{ }
    }
//   Override Method
//   Override keyword is called to override the deposit function from the parent class
    override func deposit(amount: Int) -> Int {
        let amountInKobo = amount * 100
        if amountInKobo <= 0  {
            print("Invalid Deposit Amount")
        } else{
            super.deposit(amount: amount)
            self.bonus()
        }
        return self.accountBalance
    }
}

//  Current Account
//  Current Account exhibits inheritance from the parent class which is Account
class CurrentAccount: Account {
//   Override Method
//   Override keyword is called to override the deposit function from the parent class
    override var interestRate: Double {
           get{ return 0.05 }
           set{ }
       }
//   Override Method
//   Override keyword is called to override the withdrawal function from the parent class
    override func withdrawal(amount: Int) -> Int {
        let amountInKobo = amount * 100
        let amountIncludingCharges = amountInKobo + 10000
        if amount <= 0 {
            print("invalid amount to withdraw1")
        } else if amountIncludingCharges > self.accountBalance {
            print("invalid amount to withdraw")
        } else {
            super.withdrawal(amount: amount)
            self.charge()
        }
        return self.accountBalance
            
    }
    
    
}


// customer account

var customerAccNo = 071888670

// Creating a Customer Class

class Customer {
//    Encapsulation Method: Which is called data hiding
//    these are variables we need to keep from the customers
//    Declaration of Customer properties are done here
    private var _id: Int = 0
    private let _name: String
    private var _address: String
    private var _phoneNumber: String
    var optionalAccount: [Account]? = []
    
    public var id: Int {
        get{return _id}set{newValue}
    }
    public var name: String {
           get{return _name}set{newValue}
    }
    public var address: String {
           get{return _address}set{newValue}
    }
    public var phoneNumber: String {
           get{return _phoneNumber}set{newValue}
       }
//  Initialization of the Customer properties in order to create instances of the class
    init(name:String, address:String, phoneNumber:String) {
        customerAccNo += 1
        self._id = customerAccNo
        self._address = address
        self._name = name
        self._phoneNumber = phoneNumber
    }
// Opening an Account
// Abstraction: the charge method is seen by the user but doesn't know what operation takes place beneath
    func openAnAccount(typeOfAccount: AccountType) -> [Account]?{

        switch typeOfAccount {
        case .savings:
            let newSavingsAccount = SavingsAccount(customerId:self.id)
            optionalAccount?.append(newSavingsAccount)
        case .current:
            let newCurrentAccount = CurrentAccount(customerId:self.id)
            optionalAccount?.append(newCurrentAccount)
        }
        return optionalAccount
    }
    
//    Account Balance
//    Abstraction: the customerAccount balance is seen by the user but doesn't know what operation takes place beneath
    func customerAccountBalance (customerAccount: Account) -> Int {
        return customerAccount.accountBalance
    }
    
//    Withdrawal Method
//    Abstraction: the customer withdrawal is seen by the user but doesn't know what operation takes place beneath
    func customerWithdrawal(customerAccount: Account, amount: Int) -> Int {
        customerAccount.withdrawal(amount: amount)
        return customerAccount.accountBalance
    }
//    Deposit Method
//    Abstraction: the customer deposit is seen by the user but doesn't know what operation takes place beneath
    func customerDeposit(customerAccount: Account, amount: Int) -> Int {
        customerAccount.deposit(amount: amount)
        return customerAccount.accountBalance
    }
//  Deleting an account
//  Abstraction: the delete customer account  is seen by the user but doesn't know what operation takes place beneath
    func deleteCustomerAccount(customerAccount: Account) -> [Account]? {
//        var ope = optionalAccount ?? nil
        optionalAccount?.removeAll(where:{$0 === customerAccount})
        return optionalAccount
    }
    
}

// Creating The Enum Accountype to enable switching accounts
enum AccountType{
    case savings
    case current
}

//can create customer
let firstCustomer = Customer(name: "David", address: "Decagon Uno", phoneNumber: "098765456765")

//customers can open account
firstCustomer.openAnAccount(typeOfAccount: .savings)
firstCustomer.openAnAccount(typeOfAccount: .current)

firstCustomer.customerDeposit(customerAccount: firstCustomer.optionalAccount?[0] ?? <#default value#>, amount: 10)
firstCustomer.customerWithdrawal(customerAccount: firstCustomer.optionalAccount?[0] ?? <#default value#>, amount: 50)

firstCustomer.customerAccountBalance(customerAccount: firstCustomer.optionalAccount?[0] ?? <#default value#>)


