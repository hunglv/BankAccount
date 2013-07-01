//
//  AccountDAO.h
//  BankAccount
//
//  Created by El Nino on 6/25/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import <LocalStorage/LocalStorage.h>

@interface AccountDAO : NSObject

- (BOOL)insertAccount:(Account *)accIns;

- (Account *)getAccountWithAccountNumber:(NSString *)accountNumber;

- (BOOL)updateAccount:(Account *)acc;

@property (nonatomic, strong) FMDatabaseQueue *dataAccessHelper;

@end
