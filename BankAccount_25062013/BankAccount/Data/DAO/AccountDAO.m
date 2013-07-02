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
@synthesize error;

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
    __block Account *accountWillGet;
    [dataAccessHelper inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *stm = [NSString stringWithFormat:@"select * from account where accountnumber = '%@'", accountNumber];
        FMResultSet *r = [db executeQuery:stm];
        if ([r next]) {
            accountWillGet = [[Account alloc] init];
            accountWillGet.accountNumber = [r objectForColumnName:@"accountnumber"];
            accountWillGet.balance = [r objectForColumnName:@"balance"];
            accountWillGet.timeOpened = [r objectForColumnName:@"timeopened"];
            error = nil;
        } else {
            error = [NSError errorWithDomain:@"GetAccountError" code:0 userInfo:nil];
        }
    }];
    return accountWillGet;
}

-(BOOL)updateAccount:(Account *)acc {
    __block BOOL val;
    [dataAccessHelper inTransaction:^(FMDatabase *db, BOOL *rollback) {        
        NSString *stm = [NSString stringWithFormat:@"update account set balance = %@ where accountnumber = '%@'", acc.balance, acc.accountNumber];
        val = [db executeUpdate:stm];
    }];
    return val;
}

@end
