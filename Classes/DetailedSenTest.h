//
//  DetailedSenTest.h
//  OCUnit Test Results
//
//  Created by Zbigniew Kominek on 8/29/11.
//  Copyright 2011 zbyhoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SenTest;

@interface DetailedSenTest : NSObject
{
@private
    SenTest* _senTest;
    NSString* _name;
    NSTimeInterval _duration;
    NSUInteger _failures;
    NSUInteger _testCount;
}

@property (nonatomic, readonly) SenTest* senTest;
@property (nonatomic, readonly) NSString* name;
@property (nonatomic, readonly) NSTimeInterval duration;
@property (nonatomic, readonly) NSUInteger failures;
@property (nonatomic, readonly) NSUInteger testCount;

- (id)initWithSenTest:(SenTest*)test;

- (void) startTimer;
- (void) stopTimer;
- (NSString*) durationInSec;
- (void) addFailure;
- (void) addTest;

@end
