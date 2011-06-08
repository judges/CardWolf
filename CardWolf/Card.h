//
//  MyClass.h
//  CardWolf
//
//  Created by Neil Sheppard on 07/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Card : NSObject {
    NSString *cardTo;
    NSString *cardFrom;
    NSString *cardMessage;
    NSString *cardType;
    NSString *cardAddress;
    NSDate *cardDate;
    double *cardCost;
}

@property (nonatomic, retain) NSString* cardTo;
@property (nonatomic, retain) NSString* cardFrom;
@property (nonatomic, retain) NSString* cardMessage;
@property (nonatomic, retain) NSString* cardType;
@property (nonatomic, retain) NSString* cardAddress;
@property (nonatomic, retain) NSDate* cardDate;
@property (nonatomic) double* cardCost;

@end
