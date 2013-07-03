//
//  TransactionDAO.m
//  BankAccount
//
//  Created by El Nino on 6/26/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "TransactionDAO.h"

@implementation TransactionDAO

@synthesize dataAccessHelper;

-(BOOL)insertTransaction:(Transaction *)trans {
    __block BOOL val;
    [dataAccessHelper inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
        [dateformat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSString *dateOpended = [dateformat stringFromDate:trans.timeStamp];
        
        NSString *stm = [NSString stringWithFormat:@"insert into tran(accountnumber,amount,timestamp) values('%@', %@, '%@')", trans.accountNumber, trans.amount, dateOpended];
        val = [db executeUpdate:stm];
    }];
    return val;
}

-(NSArray *)transactionOccuredWithAccountNumber:(NSString *)accNum {
    return nil;
}

-(NSArray *)transactionOccuredWithAccountNumber:(NSString *)accNum startTime:(NSDate *)start endTime:(NSDate *)end {
    return nil;
}

- (NSArray *)transactionOccuredWithAccountNumber:(NSString *)accNum numberTransactions:(NSNumber *)number {
    return nil;
}

@end
