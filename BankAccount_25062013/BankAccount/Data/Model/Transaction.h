//
//  Transaction.h
//  BankAccount
//
//  Created by El Nino on 6/26/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transaction : NSObject

@property (nonatomic, strong) NSString *accountNumber;
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSDate *timeStamp;

@end
