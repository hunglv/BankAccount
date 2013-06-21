//
//  AccountLogDAO.h
//  BankAccount
//
//  Created by El Nino on 6/21/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountLog.h"

@interface AccountLogDAO : NSObject

- (BOOL)insertAccountLog:(AccountLog *)accLog;

@end
