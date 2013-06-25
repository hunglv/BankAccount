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

@interface BankAccount : NSObject

@property (nonatomic, strong) AccountDAO *accountDAO;

- (Account *)open:(NSString *)accNum;

@end
