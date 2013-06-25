//
//  AccountLog.h
//  BankAccount
//
//  Created by El Nino on 6/21/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountLog : NSObject

@property (nonatomic, strong) NSString *accountNumber;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSDate *timeStamp;

@end
