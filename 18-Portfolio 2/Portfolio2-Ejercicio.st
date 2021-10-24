!classDefinition: #AccountSummaryTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryTest methodsFor: 'tests - receptive account' stamp: 'ds 10/24/2021 12:26:09'!
test01summaryForNewReceptiveAccountIsJustBalance
	
	| account |
	
	account := ReceptiveAccount new.
	
	self assertAccountSummaryFor: account isEqualsTo: #('Balance = 0').! !

!AccountSummaryTest methodsFor: 'tests - receptive account' stamp: 'ds 10/24/2021 12:20:24'!
test02summaryRegistersDeposits
	
	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	self assertAccountSummaryFor: account isEqualsTo: #('Depósito por 100.' 'Balance = 100').! !

!AccountSummaryTest methodsFor: 'tests - receptive account' stamp: 'ds 10/24/2021 12:20:43'!
test03summaryRegistersWithdraws
	
	| account |
	
	account := ReceptiveAccount new.
	Withdraw register: 100 on: account.
	
	self assertAccountSummaryFor: account isEqualsTo: #('Extracción por 100.' 'Balance = -100').! !

!AccountSummaryTest methodsFor: 'tests - receptive account' stamp: 'ds 10/24/2021 12:21:15'!
test04summaryRegistersTransfer
	
	| sender receiver |
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	Deposit register: 100 on: sender.
	
	Transfer new initializeFrom: sender to: receiver withAmount: 50.
	
	self assertAccountSummaryFor: sender isEqualsTo: #('Depósito por 100.' 'Salida por transferencia de 50.' 'Balance = 50').
	
	self assertAccountSummaryFor: receiver isEqualsTo: #('Entrada por transferencia de 50.' 'Balance = 50').! !


!AccountSummaryTest methodsFor: 'asserts' stamp: 'ds 10/24/2021 17:57:45'!
assertAccountSummaryFor: anAccount isEqualsTo: aListOfLines

	self assert: aListOfLines equals: (anAccount accountSummaryReport report asArray).! !


!AccountSummaryTest methodsFor: 'tests - portfolio' stamp: 'ds 10/24/2021 12:25:54'!
test05summaryForEmptyPortfolioIsJustBalance
	
	| portfolio |
	
	portfolio := Portfolio new.
	
	self assertAccountSummaryFor: portfolio isEqualsTo: #('Balance = 0').! !

!AccountSummaryTest methodsFor: 'tests - portfolio' stamp: 'ds 10/24/2021 18:02:46'!
test06summaryForPortfolioWithOneReceptiveAccountTransactions
	
	| portfolio receptiveAccount |
	
	receptiveAccount := ReceptiveAccount new.
	portfolio := Portfolio with: receptiveAccount.
	
	Deposit register: 200 on: receptiveAccount.
	Withdraw register: 50 on: receptiveAccount.
	
	self assertAccountSummaryFor: portfolio isEqualsTo: #('Depósito por 200.' 'Extracción por 50.' 'Balance = 150').! !

!AccountSummaryTest methodsFor: 'tests - portfolio' stamp: 'ds 10/24/2021 18:02:58'!
test07summaryForPortfolioWithOneReceptiveAccountTransfers
	
	| portfolio receptiveAccount externalAccount |
	
	receptiveAccount := ReceptiveAccount new.
	externalAccount := ReceptiveAccount new.
	portfolio := Portfolio with: receptiveAccount.
	
	Transfer from: externalAccount to: receptiveAccount withAmount: 500.
	Transfer from: receptiveAccount to: externalAccount withAmount: 100.
	
	self assertAccountSummaryFor: portfolio isEqualsTo: #('Entrada por transferencia de 500.' 'Salida por transferencia de 100.' 'Balance = 400').! !

!AccountSummaryTest methodsFor: 'tests - portfolio' stamp: 'ds 10/24/2021 12:59:05'!
test08summaryForPortfolioWithMultipleReceptiveAccountsTransactions
	
	| portfolio internalAccount1 internalAccount2 |
	
	internalAccount1 := ReceptiveAccount new.
	internalAccount2 := ReceptiveAccount new.
	portfolio := Portfolio with: internalAccount1 with: internalAccount2.
	
	Deposit register: 500 on: internalAccount1.
	Withdraw register: 10 on: internalAccount1.
	
	Withdraw register: 100 on: internalAccount2.
	Deposit register: 20 on: internalAccount2.
	
	self assertAccountSummaryFor: portfolio isEqualsTo: 
		#('Depósito por 500.' 'Extracción por 10.' 'Extracción por 100.' 'Depósito por 20.' 'Balance = 410').! !

!AccountSummaryTest methodsFor: 'tests - portfolio' stamp: 'ds 10/24/2021 13:02:16'!
test09summaryForPortfolioWithMultipleReceptiveAccountsTransfersToOuside
	
	| portfolio internalAccount1 internalAccount2 externalAccount |
	
	internalAccount1 := ReceptiveAccount new.
	internalAccount2 := ReceptiveAccount new.
	externalAccount := ReceptiveAccount new.
	portfolio := Portfolio with: internalAccount1 with: internalAccount2.
	
	Transfer from: externalAccount to: internalAccount1 withAmount: 600.
	Transfer from: internalAccount1 to: externalAccount withAmount: 300.
	Transfer from: externalAccount to: internalAccount2 withAmount: 800.
	
	self assertAccountSummaryFor: portfolio isEqualsTo: 
		#('Entrada por transferencia de 600.' 'Salida por transferencia de 300.' 'Entrada por transferencia de 800.'  'Balance = 1100').! !

!AccountSummaryTest methodsFor: 'tests - portfolio' stamp: 'ds 10/24/2021 13:06:15'!
test10summaryForPortfolioWithMultipleReceptiveAccountsTransfersBetweenThemselves
	
	| portfolio internalAccount1 internalAccount2 |
	
	internalAccount1 := ReceptiveAccount new.
	internalAccount2 := ReceptiveAccount new.
	portfolio := Portfolio with: internalAccount1 with: internalAccount2.
	
	Transfer from: internalAccount1 to: internalAccount2 withAmount: 600.
	Transfer from: internalAccount2 to: internalAccount1 withAmount: 300.
	
	self assertAccountSummaryFor: portfolio isEqualsTo: 
		#('Salida por transferencia de 600.' 'Entrada por transferencia de 300.' 'Entrada por transferencia de 600.' 'Salida por transferencia de 300.' 'Balance = 0').! !


!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #TransferNetTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetTest methodsFor: 'asserts' stamp: 'ds 10/24/2021 17:57:45'!
assertTransferNetSummaryFor: anAccount isEqualsTo: anAmount

	self assert: anAmount equals: anAccount transferNetReport report.! !


!TransferNetTest methodsFor: 'tests - receptive account' stamp: 'ds 10/24/2021 12:19:23'!
test01forNewReceptiveAccountIsZero
	
	| account |
	
	account := ReceptiveAccount new.
	
	self assertTransferNetSummaryFor: account isEqualsTo: 0.! !

!TransferNetTest methodsFor: 'tests - receptive account' stamp: 'ds 10/24/2021 12:19:23'!
test02forReceptiveAccountWithoutTransfersIsZero
	
	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Deposit register: 20 on: account.
	Withdraw register: 15 on: account.
	
	self assertTransferNetSummaryFor: account isEqualsTo: 0.! !

!TransferNetTest methodsFor: 'tests - receptive account' stamp: 'ds 10/24/2021 12:19:23'!
test03forReceptiveAccountSummaryIsPositive
	
	| account externalAccount |
	
	account := ReceptiveAccount new.
	externalAccount := ReceptiveAccount new.
	
	Deposit register: 300 on: account.
	Transfer from: account to: externalAccount withAmount: 30.
	Transfer from: externalAccount to: account withAmount: 50.
	
	self assertTransferNetSummaryFor: account isEqualsTo: 50-30.! !

!TransferNetTest methodsFor: 'tests - receptive account' stamp: 'ds 10/24/2021 12:19:23'!
test04forReceptiveAccountSummaryIsNegative
	
	| account externalAccount |
	
	account := ReceptiveAccount new.
	externalAccount := ReceptiveAccount new.
	
	Deposit register: 50 on: account.
	Transfer from: account to: externalAccount withAmount: 200.
	Transfer from: externalAccount to: account withAmount: 10.
	
	self assertTransferNetSummaryFor: account isEqualsTo: 10-200.! !


!TransferNetTest methodsFor: 'tests - portfolio' stamp: 'ds 10/24/2021 12:44:58'!
test05forEmptyPorfolioIsZero
	
	| portfolio |
	
	portfolio := Portfolio new.
	
	self assertTransferNetSummaryFor: portfolio isEqualsTo: 0.! !

!TransferNetTest methodsFor: 'tests - portfolio' stamp: 'ds 10/24/2021 12:48:20'!
test06forPortfolioWithOneAccountWithoutTransfersIsZero
	
	| portfolio account |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	Deposit register: 200 on: account.
	Withdraw register: 20 on: account.
	
	self assertTransferNetSummaryFor: portfolio isEqualsTo: 0.! !

!TransferNetTest methodsFor: 'tests - portfolio' stamp: 'ds 10/24/2021 12:48:27'!
test07forPortfolioWithOneAccountTransfers
	
	| portfolio account externalAccount |
	
	account := ReceptiveAccount new.
	externalAccount := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	Transfer from: account to: externalAccount withAmount: 100.
	Transfer from: externalAccount to: account withAmount: 400.
	
	
	self assertTransferNetSummaryFor: portfolio isEqualsTo: 300.! !

!TransferNetTest methodsFor: 'tests - portfolio' stamp: 'ds 10/24/2021 12:50:40'!
test08forPortfolioWithMultipleAccountsTransactions
	
	| portfolio account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio := Portfolio with: account1 with: account2.
	
	Deposit register: 500 on: account1.
	Withdraw register: 100 on: account2.
	
	self assertTransferNetSummaryFor: portfolio isEqualsTo: 0.! !

!TransferNetTest methodsFor: 'tests - portfolio' stamp: 'ds 10/24/2021 12:53:10'!
test09forPortfolioWithMultipleAccountsTransfersToExternalAccount
	
	| portfolio account1 account2 externalAccount |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	externalAccount := ReceptiveAccount new.
	portfolio := Portfolio with: account1 with: account2.
	
	Transfer from: externalAccount to: account1 withAmount: 800.
	Transfer from: externalAccount to: account2 withAmount: 600.
	Transfer from: account1 to: externalAccount withAmount: 400.
	Transfer from: account2 to: externalAccount withAmount: 300.
	
	self assertTransferNetSummaryFor: portfolio isEqualsTo: 700.! !

!TransferNetTest methodsFor: 'tests - portfolio' stamp: 'ds 10/24/2021 12:53:48'!
test10forPortfolioWithMultipleAccountsTransfersBetweenThemselves
	
	| portfolio account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio := Portfolio with: account1 with: account2.
	
	Transfer from: account1 to: account2 withAmount: 800.
	Transfer from: account2 to: account1 withAmount: 400.
	
	self assertTransferNetSummaryFor: portfolio isEqualsTo: 0.! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'tests' stamp: 'ds 10/24/2021 11:37:19'!
test01creatingATransferAffectsBalanceOnBothEnds

	| sender receiver |
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	Deposit register: 200 on: sender.
	Deposit register: 10 on: receiver.
	
	Transfer from: sender to: receiver withAmount: 50.
	
	self assert: 150 equals: sender balance.
	self assert: 60 equals: receiver balance.! !

!TransferTest methodsFor: 'tests' stamp: 'ds 10/24/2021 11:37:14'!
test02creatingATransferRegistersTransactionsOnBothEnds

	| sender receiver transfer |
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	Deposit register: 200 on: sender.
	Deposit register: 10 on: receiver.
	
	transfer := Transfer from: sender to: receiver withAmount: 50.
	
	self assert: (sender hasRegistered: transfer withdrawLeg).
	self assert: (receiver hasRegistered: transfer depositLeg).! !

!TransferTest methodsFor: 'tests' stamp: 'ds 10/24/2021 11:37:07'!
test03canMoveBetweenLegsOfATransfer

	| sender receiver transfer |
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	Deposit register: 200 on: sender.
	Deposit register: 10 on: receiver.
	
	transfer := Transfer from: sender to: receiver withAmount: 50.
	
	self assert: transfer withdrawLeg equals: (transfer depositLeg otherLeg).
	self assert: transfer depositLeg equals: (transfer withdrawLeg otherLeg).! !

!TransferTest methodsFor: 'tests' stamp: 'ds 10/24/2021 11:48:49'!
test04transferCannotHaveNegativeAmount

	| sender receiver |
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	Deposit register: 200 on: sender.
	Deposit register: 10 on: receiver.
	
	self assertThatTransfer: [Transfer from: sender to: receiver withAmount: -20.]
		producesError: Transfer amountMustBePositiveErrorDescription.
	
	! !

!TransferTest methodsFor: 'tests' stamp: 'ds 10/24/2021 18:01:06'!
test05transferCannotHaveZeroAmount

	| sender receiver |
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	Deposit register: 200 on: sender.
	Deposit register: 10 on: receiver.
	
	self assertThatTransfer: [Transfer from: sender to: receiver withAmount: 0.]
		producesError: Transfer amountMustBePositiveErrorDescription.
	! !

!TransferTest methodsFor: 'tests' stamp: 'ds 10/24/2021 11:49:39'!
test06cannotTransferToOneself

	| sender |
	sender := ReceptiveAccount new.
	Deposit register: 200 on: sender.
	
	self assertThatTransfer: [Transfer from: sender to: sender withAmount: 10.]
		producesError: Transfer cannotTransferToOneselfErrorDescription.
	
	! !


!TransferTest methodsFor: 'asserts' stamp: 'ds 10/24/2021 11:48:38'!
assertThatTransfer: aTransferCreationCode producesError: expectedError

	self
		should: aTransferCreationCode
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = expectedError].
	
	! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'reports' stamp: 'ds 10/24/2021 17:28:31'!
accountSummaryReport 

	self subclassResponsibility.! !

!Account methodsFor: 'reports' stamp: 'ds 10/24/2021 17:27:26'!
transferNetReport

	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'reports' stamp: 'ds 10/24/2021 17:28:19'!
accountSummaryReport 

	^ AccountSummary for: self withTransactions: (self transactions).! !

!Portfolio methodsFor: 'reports' stamp: 'ds 10/24/2021 17:26:05'!
transferNetReport

	^ TransferNet for: self withTransactions: (self transactions).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'ds 10/24/2021 17:27:55'!
accountSummaryReport 

	^ AccountSummary for: self withTransactions: transactions.! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'ds 10/24/2021 17:24:33'!
transferNetReport

	^ TransferNet for: self withTransactions: transactions.! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reports' stamp: 'ds 10/24/2021 17:38:59'!
affectTransferNet: aTransferNetAmount

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'reports' stamp: 'ds 10/24/2021 17:48:19'!
asSummaryString: asSummaryString

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reports' stamp: 'ds 10/24/2021 16:30:56'!
affectTransferNet: aTransferNetAmount

	^ aTransferNetAmount.! !

!Deposit methodsFor: 'reports' stamp: 'ds 10/24/2021 16:53:45'!
asSummaryString: anAccountSummary

	^ anAccountSummary depositAsString: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLeg category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferLeg methodsFor: 'balance' stamp: 'ds 10/21/2021 21:47:03'!
affectBalance: aBalance
	
	self subclassResponsibility.! !


!TransferLeg methodsFor: 'reports' stamp: 'ds 10/24/2021 17:40:33'!
affectTransferNet: aTransferNetAmount

	self subclassResponsibility.! !

!TransferLeg methodsFor: 'reports' stamp: 'ds 10/24/2021 17:47:24'!
asSummaryString: anAccountSummary

	self subclassResponsibility.! !


!TransferLeg methodsFor: 'value' stamp: 'ds 10/21/2021 21:46:48'!
value
	
	self subclassResponsibility.! !


!TransferLeg methodsFor: 'transfers' stamp: 'ds 10/21/2021 21:46:44'!
otherLeg
	
	self subclassResponsibility.! !


!TransferLeg methodsFor: 'initialization' stamp: 'ds 10/24/2021 17:45:59'!
initializeFor: aTransfer

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'Portfolio-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'ds 10/21/2021 21:49:05'!
register: aValue on: account withTransfer: aTransfer

	| transaction |
	
	transaction := self for: aTransfer.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #DepositLeg category: 'Portfolio-Solucion'!
TransferLeg subclass: #DepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DepositLeg methodsFor: 'balance' stamp: 'ds 10/21/2021 21:41:51'!
affectBalance: aBalance

	^aBalance + (transfer value).! !


!DepositLeg methodsFor: 'reports' stamp: 'ds 10/24/2021 16:31:38'!
affectTransferNet: aTransferNetAmount

	^ aTransferNetAmount + (transfer value).! !

!DepositLeg methodsFor: 'reports' stamp: 'ds 10/24/2021 16:56:23'!
asSummaryString: anAccountSummary

	^ anAccountSummary depositLegAsString: self.! !


!DepositLeg methodsFor: 'transfers' stamp: 'ds 10/21/2021 21:46:24'!
otherLeg

	^ transfer withdrawLeg.! !


!DepositLeg methodsFor: 'value' stamp: 'ds 10/21/2021 21:41:13'!
value

	^ transfer value.! !


!DepositLeg methodsFor: 'initialization' stamp: 'ds 10/21/2021 21:50:08'!
initializeFor: aTransfer

	transfer := aTransfer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DepositLeg class' category: 'Portfolio-Solucion'!
DepositLeg class
	instanceVariableNames: ''!

!DepositLeg class methodsFor: 'as yet unclassified' stamp: 'ds 10/21/2021 21:49:19'!
for: aTransfer

	^ self new initializeFor: aTransfer! !


!classDefinition: #WithdrawLeg category: 'Portfolio-Solucion'!
TransferLeg subclass: #WithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WithdrawLeg methodsFor: 'balance' stamp: 'ds 10/21/2021 21:42:18'!
affectBalance: aBalance

	^aBalance - (transfer value).! !


!WithdrawLeg methodsFor: 'reports' stamp: 'ds 10/24/2021 16:31:49'!
affectTransferNet: aTransferNetAmount

	^ aTransferNetAmount - (transfer value).! !

!WithdrawLeg methodsFor: 'reports' stamp: 'ds 10/24/2021 16:56:35'!
asSummaryString: anAccountSummary

	^ anAccountSummary withdrawLegAsString: self.! !


!WithdrawLeg methodsFor: 'transfers' stamp: 'ds 10/21/2021 21:46:30'!
otherLeg

	^ transfer depositLeg.! !


!WithdrawLeg methodsFor: 'value' stamp: 'ds 10/21/2021 21:42:37'!
value

	^ transfer value.! !


!WithdrawLeg methodsFor: 'initialization' stamp: 'ds 10/21/2021 21:50:23'!
initializeFor: aTransfer

	transfer := aTransfer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WithdrawLeg class' category: 'Portfolio-Solucion'!
WithdrawLeg class
	instanceVariableNames: ''!

!WithdrawLeg class methodsFor: 'as yet unclassified' stamp: 'ds 10/21/2021 21:49:39'!
for: aTransfer

	^ self new initializeFor: aTransfer! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reports' stamp: 'ds 10/24/2021 16:31:15'!
affectTransferNet: aTransferNetAmount

	^ aTransferNetAmount.! !

!Withdraw methodsFor: 'reports' stamp: 'ds 10/24/2021 16:56:05'!
asSummaryString: anAccountSummary

	^ anAccountSummary withdrawAsString: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'account transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'initialization' stamp: 'ds 10/24/2021 17:55:37'!
initializeFor: anAccount withTransactions: aListOfTransactions

	self subclassResponsibility.! !


!Report methodsFor: 'report' stamp: 'ds 10/24/2021 17:57:17'!
report
	
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'as yet unclassified' stamp: 'ds 10/24/2021 17:18:32'!
for: anAccount withTransactions: aListOfTransactions
	
	^ self new initializeFor: anAccount withTransactions: aListOfTransactions.! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'strings' stamp: 'ds 10/24/2021 16:51:24'!
accountBalanceAsString

	^ 'Balance = ', (account balance asString).! !

!AccountSummary methodsFor: 'strings' stamp: 'ds 10/24/2021 16:37:19'!
depositAsString: aTransaction

	^ 'Depósito por ' , aTransaction value asString , '.'.! !

!AccountSummary methodsFor: 'strings' stamp: 'ds 10/24/2021 16:37:28'!
depositLegAsString: aTransaction

	^ 'Entrada por transferencia de ' , aTransaction value asString , '.'.! !

!AccountSummary methodsFor: 'strings' stamp: 'ds 10/24/2021 16:37:36'!
withdrawAsString: aTransaction

	^ 'Extracción por ' , aTransaction value asString , '.'.! !

!AccountSummary methodsFor: 'strings' stamp: 'ds 10/24/2021 16:37:43'!
withdrawLegAsString: aTransaction

	^ 'Salida por transferencia de ' , aTransaction value asString , '.'.! !


!AccountSummary methodsFor: 'initialization' stamp: 'ds 10/24/2021 17:20:30'!
initializeFor: anAccount withTransactions: aListOfTransactions

	account := anAccount.
	transactions := aListOfTransactions.
	
	! !


!AccountSummary methodsFor: 'report' stamp: 'ds 10/24/2021 17:57:34'!
report

	| summaryLines |
	
	summaryLines := transactions collect: [:transaction | transaction asSummaryString: self].
	summaryLines addLast: (self accountBalanceAsString).
	
	^ summaryLines.! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'initialization' stamp: 'ds 10/24/2021 17:20:38'!
initializeFor: anAccount withTransactions: aListOfTransactions

	account := anAccount.
	transactions := aListOfTransactions.! !


!TransferNet methodsFor: 'report' stamp: 'ds 10/24/2021 17:57:45'!
report

	| netValue |
	netValue := 0.
	
	transactions do: [:transaction | netValue := transaction affectTransferNet: netValue].

	^ netValue.
	
	! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'ds 10/21/2021 21:28:57'!
depositLeg

	^ depositLeg.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'ds 10/24/2021 11:45:44'!
initializeFrom: aSenderAccount to: aReceiverAccount withAmount: anAmount

	anAmount <= 0 ifTrue: [self error: Transfer amountMustBePositiveErrorDescription].
	aSenderAccount == aReceiverAccount ifTrue: [self error: Transfer cannotTransferToOneselfErrorDescription ].
	
	value := anAmount.
	withdrawLeg := WithdrawLeg register: anAmount on: aSenderAccount withTransfer: self.
	depositLeg := DepositLeg register: anAmount on: aReceiverAccount withTransfer: self.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'ds 10/21/2021 21:41:29'!
value

	^ value.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'ds 10/21/2021 21:28:51'!
withdrawLeg

	^ withdrawLeg.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'ds 10/24/2021 11:38:35'!
amountMustBePositiveErrorDescription

	^ 'amount must be bigger than 0!!!!!!'.! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'ds 10/24/2021 11:44:48'!
cannotTransferToOneselfErrorDescription

	^ 'cannot transfer to oneself!!!!!!'.! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'ds 10/24/2021 11:36:42'!
from: aSenderAccount to: aReceiverAccount withAmount: anAmount
	
	^ self new initializeFrom: aSenderAccount to: aReceiverAccount withAmount: anAmount.! !
