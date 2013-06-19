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

@interface BankAccount : NSObject

- (Account *)open:(NSString *)accountNumber;

@property (nonatomic, strong) AccountDAO *accountDAO;

- (Account *)getAccount:(NSString *)accountNumber;

@end
