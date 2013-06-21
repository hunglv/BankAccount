//
//  AccountDAO.h
//  BankAccount
//
//  Created by El Nino on 6/19/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface AccountDAO : NSObject

- (BOOL)insertNewAccount:(Account *)accountInsert;

- (Account *)getAccountWithAccountNumber:(NSString *)accountNumber; // If get fail, will return nil object

- (BOOL)updateAccount:(Account *)accountUpdate;

@end
