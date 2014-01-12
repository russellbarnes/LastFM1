//
//  EventClass.h
//  LastFM1
//
//  Created by Russell Barnes on 1/11/14.
//  Copyright (c) 2014 Russell Barnes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventClass : NSObject

// Values for lat & long of event.  Must be strong to pass to MapViewController
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *venue;

@end
