//
//  OCUnitListenerStarter.m
//  OCUnitToJUnit
//
//  Created by Zbigniew Kominek on 8/23/11.
//  Copyright 2011 zbyhoo. All rights reserved.
//

#import "OCUnitListener.h"
#import "TestResultsSorageTypes.h"

static OCUnitListener* ocUnitListener = nil;

static void __attribute__ ((constructor)) BPTestXunitXmlListenerStart(void)
{
    MAIN_RESULTS_STORAGE_CLASS * storageDelegate = [[MAIN_RESULTS_STORAGE_CLASS alloc] init];
    ocUnitListener = [[OCUnitListener alloc] init];
    ocUnitListener.storageDelegate = storageDelegate;
    [storageDelegate release];
}

static void __attribute__ ((destructor)) BPTestXunitXmlListenerStop(void)
{
    [ocUnitListener release];
}
