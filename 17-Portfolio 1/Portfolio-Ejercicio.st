!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests - transactions' stamp: 'ds 10/7/2021 20:49:43'!
test02EmptyPortfolioHasNoTransactions
	
	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: portfolio transactions isEmpty.! !

!PortfolioTest methodsFor: 'tests - transactions' stamp: 'ds 10/16/2021 17:56:38'!
test08PortfolioWithSingleAccountHasTransactionsEqualToAccountTransactions
	
	| portfolio account |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	
	self registerTransactions: #(120 100 -30) onAccount: account.
	portfolio add: account.
	
	self assert: (account transactions) equals: portfolio transactions.! !

!PortfolioTest methodsFor: 'tests - transactions' stamp: 'ds 10/16/2021 18:19:10'!
test10PortfolioWithManyAccountsHasTransactionsEqualToAllAccountTransactions
	
	| allTransactions portfolio account1 account2 account3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	
	portfolio := Portfolio new.
	
	allTransactions := OrderedCollection new.
	
	allTransactions addAll: (self registerTransactions: #(120 100 -30) onAccount: account1).
	allTransactions addAll: (self registerTransactions: #(500) onAccount: account2).
	allTransactions addAll: (self registerTransactions: #(10 20 -5) onAccount: account3).
	
	portfolio addMany: {account1. account2. account3}.
	
	self assert: allTransactions equals: portfolio transactions.! !

!PortfolioTest methodsFor: 'tests - transactions' stamp: 'ds 10/16/2021 17:56:38'!
test13PortfolioWithPortfolioRegistersTransactions
	
	| parentPortfolio childPortfolio childAccount transactions|
	
	childAccount := ReceptiveAccount new.	
	parentPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	transactions := OrderedCollection new.
	
	transactions addAll: (self registerTransactions: #(120 -10) onAccount: childAccount).
	
	childPortfolio add: childAccount.
	parentPortfolio add: childPortfolio.
	
	self assert: transactions equals: parentPortfolio transactions.! !


!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ds 10/16/2021 18:20:29'!
test14PortfolioWithNestedPortfolio
	
	| parentPortfolio childPortfolio grandchildPortfolio parentAccount childAccount grandchildAccount transactions|
	
	parentPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	grandchildPortfolio := Portfolio new.
	parentAccount := ReceptiveAccount new.
	childAccount := ReceptiveAccount new.	
	grandchildAccount := ReceptiveAccount new.
	
	parentPortfolio addMany: {parentAccount. childPortfolio}.
	childPortfolio addMany: {childAccount. grandchildPortfolio}.
	grandchildPortfolio add: grandchildAccount.
	
	transactions := OrderedCollection new.
	
	transactions addAll: (self registerTransactions: #(200 -5) onAccount: parentAccount).
	transactions addAll: (self registerTransactions: #(120 -50) onAccount: childAccount).
	transactions addAll: (self registerTransactions: #(30 -10) onAccount: grandchildAccount).
	
	self assert: (200-5+120-50+30-10) equals: parentPortfolio balance.
	self assert: transactions equals: parentPortfolio transactions.! !


!PortfolioTest methodsFor: 'auxiliar' stamp: 'ds 10/16/2021 17:56:38'!
expectFailureWhenAddingToPorfolio: portfolio2 theAccount: accountE

	^ self
		should: [ portfolio2 add: accountE. ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText = 'account already exists in portfolio!!!!!!'. ]! !

!PortfolioTest methodsFor: 'auxiliar' stamp: 'ds 10/16/2021 16:44:52'!
registerTransactions: aListOfTransactions onAccount: anAccount

	| deposits withdrawals createdTransactions |
	createdTransactions := OrderedCollection new.
	deposits := aListOfTransactions select: [:transaction | transaction >= 0].
	withdrawals := aListOfTransactions select: [:transaction | transaction < 0].
	
	deposits do: [:deposit | 
		createdTransactions addLast: (Deposit register: deposit on: anAccount)].
	withdrawals do: [:withdrawal | 
		createdTransactions addLast: (Withdraw register: (-1 * withdrawal) on: anAccount)].
	
	^ createdTransactions.! !


!PortfolioTest methodsFor: 'tests - balance' stamp: 'ds 10/7/2021 20:43:59'!
test01EmptyPortfolioHasBalanceEqualsTo0
	
	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests - balance' stamp: 'ds 10/16/2021 17:56:38'!
test04PortfolioWithSingleEmptyAccountHasBalanceEqualsTo0
	
	| portfolio account |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	
	portfolio add: account.
	
	self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests - balance' stamp: 'ds 10/16/2021 17:56:38'!
test05PortfolioWithSingleAccountHasBalanceEqualsToAccountBalance
	
	| portfolio account |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	
	self registerTransactions: #(120 -30) onAccount: account.
	portfolio add: account.
	
	self assert: 90 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests - balance' stamp: 'ds 10/16/2021 18:21:15'!
test09PortfolioWithManyAccountsHaveBalanceEqualToTheSumOfAllAccounts
	
	| portfolio account1 account2 account3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	
	portfolio := Portfolio new.
	
	self registerTransactions: #(120 100 -30) onAccount: account1.
	self registerTransactions: #(500) onAccount: account2.
	self registerTransactions: #(10 20 -5) onAccount: account3.
	
	portfolio addMany: {account1. account2. account3}.
	
	self assert: (120 + 100 - 30 + 500 + 10 + 20 - 5) equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests - balance' stamp: 'ds 10/16/2021 17:56:38'!
test11PortfolioCanHavePortfolioAndAffectsTotalBalance
	
	| parentPortfolio childPortfolio childAccount |
	
	childAccount := ReceptiveAccount new.	
	parentPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	Deposit register: 120 on: childAccount.
	
	childPortfolio add: childAccount.
	parentPortfolio add: childPortfolio.
	
	self assert: 120 equals: parentPortfolio balance.! !

!PortfolioTest methodsFor: 'tests - balance' stamp: 'ds 10/16/2021 18:26:17'!
test25RegisteringTransactionsAfterAccountHasBeenAddedDoesNotChangeBalance
	
	| portfolio account |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	
	portfolio add: account.
	self registerTransactions: #(120 -30) onAccount: account.
	
	self assert: 90 equals: portfolio balance.! !


!PortfolioTest methodsFor: 'tests - hasRegistered' stamp: 'ds 10/16/2021 16:36:53'!
test03EmptyPortfolioHasNotRegistedTransactions
	
	| portfolio account deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	
	portfolio := Portfolio new.
	
	self assert: (portfolio hasRegistered: deposit) not.! !

!PortfolioTest methodsFor: 'tests - hasRegistered' stamp: 'ds 10/16/2021 17:56:38'!
test06PortfolioWithSingleAccountRegistersDepositCorrectly
	
	| portfolio account deposit |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	
	deposit := Deposit register: 120 on: account.
	
	portfolio add: account.
	
	self assert: (portfolio hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'tests - hasRegistered' stamp: 'ds 10/16/2021 17:56:38'!
test07PortfolioWithSingleAccountRegistersWithdrawalCorrectly
	
	| portfolio account withdrawal |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	
	withdrawal := Withdraw register: 40 on: account.
	
	portfolio add: account.
	
	self assert: (portfolio hasRegistered: withdrawal).! !

!PortfolioTest methodsFor: 'tests - hasRegistered' stamp: 'ds 10/16/2021 17:56:38'!
test12PortfolioWithPortfolioRegistersASingleTransaction
	
	| parentPortfolio childPortfolio childAccount theTransaction|
	
	childAccount := ReceptiveAccount new.	
	parentPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	
	theTransaction := Deposit register: 120 on: childAccount.
	
	childPortfolio add: childAccount.
	parentPortfolio add: childPortfolio.
	
	self assert: (parentPortfolio hasRegistered: theTransaction).! !


!PortfolioTest methodsFor: 'tests - errors' stamp: 'ds 10/16/2021 17:56:38'!
test15AttemptAddRepeatedAccountFails
	
	| portfolio account1 |
	
	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.	
	
	portfolio add: account1.
	
	self expectFailureWhenAddingToPorfolio: portfolio theAccount: account1.! !

!PortfolioTest methodsFor: 'tests - errors' stamp: 'ds 10/16/2021 17:56:38'!
test16AttemptAddRepeatedAccountFailsNestedPorfolio
	
	| parentPorfolio childPorfolio account |
	
	parentPorfolio := Portfolio new.
	childPorfolio := Portfolio new.
	account := ReceptiveAccount new.	
	
	parentPorfolio add: childPorfolio.
	childPorfolio add: account.
	
	self expectFailureWhenAddingToPorfolio: parentPorfolio theAccount: account.! !

!PortfolioTest methodsFor: 'tests - errors' stamp: 'ds 10/12/2021 20:38:41'!
test17AddingPortfolioToItselfFails
	
	| portfolio |
	
	portfolio := Portfolio new.
	
	self expectFailureWhenAddingToPorfolio: portfolio theAccount: portfolio.! !

!PortfolioTest methodsFor: 'tests - errors' stamp: 'ds 10/16/2021 17:56:38'!
test18AddingRepeatedPortfolioFails
	
	| portfolio portfolio2 |
	
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	
	portfolio add: portfolio2.
	
	self expectFailureWhenAddingToPorfolio: portfolio theAccount: portfolio2.! !

!PortfolioTest methodsFor: 'tests - errors' stamp: 'ds 10/16/2021 17:56:38'!
test19AttemptAddRepeatedPortfolioFailsNestedPorfolio
	
	| parentPorfolio childPorfolio grandchildPortfolio |
	
	parentPorfolio := Portfolio new.
	childPorfolio := Portfolio new.
	grandchildPortfolio := ReceptiveAccount new.	
	
	parentPorfolio add: childPorfolio.
	childPorfolio add: grandchildPortfolio.
	
	self expectFailureWhenAddingToPorfolio: parentPorfolio theAccount: grandchildPortfolio.! !

!PortfolioTest methodsFor: 'tests - errors' stamp: 'ds 10/16/2021 17:56:38'!
test20AttemptAddPortfolioWithAccountInExistingPortfolioFails
	
	| portfolio1 portfolio2 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.	
	
	portfolio1 add: account.
	portfolio2 add: account.
	
	self expectFailureWhenAddingToPorfolio: portfolio1 theAccount: portfolio2.! !

!PortfolioTest methodsFor: 'tests - errors' stamp: 'ds 10/16/2021 18:26:57'!
test24AttemptAddingAccountWhichExistsInLastLevelOfPortfolio
	
	| portfolio1 portfolio2 portfolio3 accountA accountB accountC accountD accountE  |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.	
	
	accountA := ReceptiveAccount new.	
	accountB := ReceptiveAccount new.	
	accountC := ReceptiveAccount new.	
	accountD := ReceptiveAccount new.	
	accountE := ReceptiveAccount new.	
	
	portfolio1 addMany: {accountA. portfolio2}.
	portfolio2 addMany: {accountB. accountC. portfolio3}.
	portfolio3 addMany: {accountD. accountE}.
	
	self expectFailureWhenAddingToPorfolio: portfolio1 theAccount: accountE.! !


!PortfolioTest methodsFor: 'tests - allChildren' stamp: 'ds 10/16/2021 18:30:06'!
test21AllChildrenOfAccountIsOnlyItself
	
	| account |
	
	account := ReceptiveAccount new.	

	self assert: (Set with: account) equals: account itemsFromAllLevels.! !

!PortfolioTest methodsFor: 'tests - allChildren' stamp: 'ds 10/16/2021 18:30:06'!
test22AllChildrenWorksForAllFirstLevelChildren
	
	| account account2 portfolio portfolio2 |
	
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.	
	account2 := ReceptiveAccount new.	
	
	portfolio addMany: {portfolio2. account. account2}.
	
	self assert: (Set with: account with: portfolio with: account2 with: portfolio2) equals: portfolio itemsFromAllLevels.! !

!PortfolioTest methodsFor: 'tests - allChildren' stamp: 'ds 10/16/2021 18:30:06'!
test23AllChildrenWorksForChildrenInAllLevels
	
	| portfolio portfolio2 childA childB childC  |
	
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	
	childA := ReceptiveAccount new.	
	childB := ReceptiveAccount new.	
	childC := ReceptiveAccount new.	
	
	portfolio2 addMany: {childB. childC}.
	portfolio addMany: {childA. portfolio2}.
	
	self assert: (Set with: childA with: childB with: childC with: portfolio with: portfolio2) equals: portfolio itemsFromAllLevels.! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ds 10/16/2021 17:12:18'!
test08DepositBalanceValueIsPositive 

	| account depositValue |
	
	account := ReceptiveAccount new.
	depositValue := 50.
	
	self assert: depositValue equals: (Deposit register: depositValue on: account) balanceValue.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ds 10/16/2021 17:13:07'!
test09WithdrawBalanceValueIsNegative

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: (-1 * withdrawValue) equals: (Withdraw register: withdrawValue on: account) balanceValue.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ds 10/16/2021 17:14:28'!
test10DepositValueIsPositive

	| account depositValue |
	
	account := ReceptiveAccount new.
	depositValue := 50.
	
	self assert: depositValue equals: (Deposit register: depositValue on: account) value.
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'ds 10/11/2021 17:13:23'!
balanceValue 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'ds 10/11/2021 17:13:32'!
balanceValue

	^ value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'ds 10/7/2021 20:30:26'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'ds 10/11/2021 17:13:44'!
balanceValue

	^ -1 * value.! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #PortfolioItem category: 'Portfolio-Ejercicio'!
Object subclass: #PortfolioItem
	instanceVariableNames: 'items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioItem methodsFor: 'initialization' stamp: 'ds 10/12/2021 20:31:41'!
initialize

	self subclassResponsibility.! !


!PortfolioItem methodsFor: 'transactions' stamp: 'ds 10/12/2021 20:28:28'!
hasRegistered: anAccount
	
	self subclassResponsibility.! !

!PortfolioItem methodsFor: 'transactions' stamp: 'ds 10/12/2021 20:29:27'!
transactions

	self subclassResponsibility.! !


!PortfolioItem methodsFor: 'items' stamp: 'ds 10/16/2021 18:30:06'!
itemsFromAllLevels
	
	self subclassResponsibility.! !


!PortfolioItem methodsFor: 'balance' stamp: 'ds 10/12/2021 20:28:23'!
balance
	
	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
PortfolioItem subclass: #Portfolio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'ds 10/16/2021 18:02:58'!
initialize

	items := OrderedCollection new.! !


!Portfolio methodsFor: 'items' stamp: 'ds 10/16/2021 18:01:15'!
add: aPortfolioItem 
	
	self assertCanBeAdded: aPortfolioItem.
	items add: aPortfolioItem.! !

!Portfolio methodsFor: 'items' stamp: 'ds 10/16/2021 18:16:54'!
addMany: aListOfPortfolioItems 
	
	aListOfPortfolioItems do: [:item | self add: item].! !

!Portfolio methodsFor: 'items' stamp: 'ds 10/16/2021 18:31:25'!
assertCanBeAdded: aPortfolioItem 
	" for each children of the given item: assert that it is not included in this portfolio's total set of items "
	| hasNoRepetitions |
	hasNoRepetitions := aPortfolioItem itemsFromAllLevels allSatisfy: [:foreignChild | (self includesAsDescendant: foreignChild) not].
	hasNoRepetitions ifFalse: [self error: Portfolio accountAlreadyExistsError].
	^ true.! !

!Portfolio methodsFor: 'items' stamp: 'ds 10/16/2021 18:31:01'!
itemsFromAllLevels

	| all |
	all := Set with: self.
	items do: [:childAccount | all addAll: (childAccount itemsFromAllLevels) ].
	^ all.! !


!Portfolio methodsFor: 'transactions' stamp: 'ds 10/16/2021 18:01:58'!
hasRegistered: aTransaction
 
	^ items anySatisfy: [:anAccount | anAccount hasRegistered: aTransaction].! !

!Portfolio methodsFor: 'transactions' stamp: 'ds 10/16/2021 18:04:42'!
transactions
	| transactions |
	transactions := OrderedCollection new.
	items do: [:aPortfolioItem | transactions addAll: aPortfolioItem transactions].
	^ transactions.! !


!Portfolio methodsFor: 'balance' stamp: 'ds 10/16/2021 18:01:07'!
balance
	
	^ items sum: [:aPortfolioItem | aPortfolioItem balance] ifEmpty: [0].! !


!Portfolio methodsFor: 'accounts - private' stamp: 'ds 10/16/2021 18:30:06'!
includesAsDescendant: aPortfolioItem

	^ self itemsFromAllLevels includes: aPortfolioItem.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'ds 10/12/2021 19:09:45'!
accountAlreadyExistsError
	
	^ 'account already exists in portfolio!!!!!!'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
PortfolioItem subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'ds 10/12/2021 20:31:21'!
initialize 

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'ds 10/16/2021 17:55:21'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'ds 10/11/2021 17:20:12'!
balance
	| calculatedBalance |
	
	calculatedBalance := transactions sum: [:aTransaction | aTransaction balanceValue] ifEmpty: [0].
	
	^ {0. calculatedBalance} max.! !


!ReceptiveAccount methodsFor: 'items' stamp: 'ds 10/16/2021 18:30:06'!
itemsFromAllLevels

	^ Set with: self.
! !
