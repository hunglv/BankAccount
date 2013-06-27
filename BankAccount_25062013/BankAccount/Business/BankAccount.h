//
//  BankAccount.h
//  BankAccount
//
//  Created by El Nino on 6/25/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AccountDAO.h"

#import "Account.h"

#import "Transaction.h"

#import "TransactionDAO.h"

@interface BankAccount : NSObject

@property (nonatomic, strong) AccountDAO *accountDAO;

- (Account *)open:(NSString *)accNum;

- (Account *)getAccount:(NSString *)accNum;

- (void)depositAccountNumber:(NSString *)accNum amount:(NSNumber *)amount description:(NSString *)description;

@property (nonatomic, strong) TransactionDAO *transactionDAO;

- (void)withdrawAccountNumber:(NSString *)accNum amount:(NSNumber *)amount description:(NSString *)description;

- (NSArray *)transactionOccuredWithAccountNumber:(NSString *)accNum;

- (NSArray *)transactionOccuredWithAccountNumber:(NSString *)accNum startTime:(NSDate *)start endTime:(NSDate *)end;

- (NSArray *)transactionOccuredWithAccountNumber:(NSString *)accNum numberTransactions:(NSNumber *)number;
@end
