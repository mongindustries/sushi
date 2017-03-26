//
//  application.h
//  platform
//
//  Created by Michael Ong on 26/3/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <application/application.h>

struct ma_application_driver platform_ios_create_driver_app();


@interface maki_application : NSObject<UIApplicationDelegate>

@end
