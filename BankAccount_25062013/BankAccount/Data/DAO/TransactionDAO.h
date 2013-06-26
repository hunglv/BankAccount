//
//  TransactionDAO.h
//  BankAccount
//
//  Created by El Nino on 6/26/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Transaction.h"

@interface TransactionDAO : NSObject

- (BOOL)insertTransaction:(Transaction *)trans;

@end
