//
//  AccountDAO.h
//  BankAccount
//
//  Created by El Nino on 6/25/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface AccountDAO : NSObject

- (BOOL)insertAccount:(Account *)accIns;

@end
