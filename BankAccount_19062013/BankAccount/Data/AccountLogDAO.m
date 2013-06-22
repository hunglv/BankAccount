//
//  AccountLogDAO.m
//  BankAccount
//
//  Created by El Nino on 6/21/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "AccountLogDAO.h"

@implementation AccountLogDAO

- (BOOL)insertAccountLog:(AccountLog *)accLog {
    return NO;
}

- (NSArray *)getTransactionWithAccountNumber:(NSString *)acc {
    return nil;
}

-(NSArray *)getTransactionWithAccountNumber:(NSString *)acc start:(NSDate *)date stop:(NSDate *)stop {
    return nil;
}

-(NSArray *)getTransactionWithAccountNumber:(NSString *)acc numberNewest:(NSNumber *)number {
    return nil;
}

@end
