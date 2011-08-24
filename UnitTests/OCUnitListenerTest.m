//
//  OCUnitListenerTest.m
//  OCUnitToJUnit
//
//  Created by Zbigniew Kominek on 8/23/11.
//  Copyright 2011 zbyhoo. All rights reserved.
//

#define USE_APPLICATION_UNIT_TEST 1

@interface OCUnitListenerTest : SenTestCase

@end

@implementation OCUnitListenerTest

- (void) test_smoke
{
    STAssertTrue(true, nil);
}

- (void) test_failed
{
    STFail(@"should failed");
}

@end
