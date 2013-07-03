//
//  TransactionDAO.h
//  BankAccount
//
//  Created by El Nino on 6/26/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Transaction.h"
#import <LocalStorage/LocalStorage.h>

@interface TransactionDAO : NSObject

- (BOOL)insertTransaction:(Transaction *)trans;

- (NSArray *)transactionOccuredWithAccountNumber:(NSString *)accNum;

- (NSArray *)transactionOccuredWithAccountNumber:(NSString *)accNum startTime:(NSDate *)start endTime:(NSDate *)end;

- (NSArray *)transactionOccuredWithAccountNumber:(NSString *)accNum numberTransactions:(NSNumber *)number;

@property (nonatomic, strong) FMDatabaseQueue *dataAccessHelper;

@end
