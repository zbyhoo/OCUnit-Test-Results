//
//  OCUnitListener.h
//  OCUnitToJUnit
//
//  Created by Zbigniew Kominek on 8/23/11.
//  Copyright 2011 zbyhoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestResultsStorageDelegate.h"

@interface OCUnitListener : NSObject
{
@private
    id<TestResultsStorageDelegate> _storageDelegate;
}

@property (nonatomic, retain) id<TestResultsStorageDelegate> storageDelegate;

- (void) initializeNotificationListeners;

- (void) testSuiteStarted:(NSNotification*)notification;
- (void) testSuiteEnded:(NSNotification*)notification;
- (void) testCaseStarted:(NSNotification*)notification;
- (void) testCaseEnded:(NSNotification*)notification;
- (void) testCaseFailed:(NSNotification*)notification;

@end
