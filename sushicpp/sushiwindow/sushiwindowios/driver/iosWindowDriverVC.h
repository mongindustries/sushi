//
//  iosWindowDriverVC.h
//  sushiwindowios
//
//  Created by Michael Ong on 21/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <sushicore/PointerOwnership.h>

@interface iosWindowDriverVCView: UIView

@end

@interface iosWindowDriverVC : UIViewController

@property(nullable) SUSHI_PO_WEAK
void* refToWindow;

@end
