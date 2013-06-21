//
//  BankAccount.h
//  BankAccount
//
//  Created by El Nino on 6/19/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import "AccountDAO.h"
#import "AccountLog.h"
#import "AccountLogDAO.h"

@interface BankAccount : NSObject

- (Account *)open:(NSString *)accountNumber;

@property (nonatomic, strong) AccountDAO *accountDAO;

- (Account *)getAccount:(NSString *)accountNumber;

- (Account *)depositAccountNumber:(NSString *)account amount:(NSNumber *)amount description:(NSString *)description;

- (AccountLog *)createAccountLogWithAccountNumber:(NSString *)accountNumber amount:(NSNumber *)amount description:(NSString *)des;

@property (nonatomic, strong) AccountLogDAO *accountLogDAO;

@end
