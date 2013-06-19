//
//  Account.h
//  BankAccount
//
//  Created by El Nino on 6/19/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject

@property (nonatomic, strong) NSString *accountNumber;
@property (nonatomic, strong) NSNumber *balance;

@end
