//
//  AccountDAO.m
//  BankAccount
//
//  Created by El Nino on 6/25/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "AccountDAO.h"

@implementation AccountDAO

@synthesize dataAccessHelper;

-(BOOL)insertAccount:(Account *)accIns {
    __block BOOL val;
    [dataAccessHelper inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
        [dateformat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSString *dateOpended = [dateformat stringFromDate:accIns.timeOpened];
        
        NSString *stm = [NSString stringWithFormat:@"insert into Account(accountnumber,balance,timeOpened) values('%@', %@, '%@')", accIns.accountNumber, accIns.balance, dateOpended];
        val = [db executeUpdate:stm];
    }];
    return val;
}

-(Account *)getAccountWithAccountNumber:(NSString *)accountNumber {
    return nil;
}

-(BOOL)updateAccount:(Account *)acc {
    return NO;
}

@end
