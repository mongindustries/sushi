//
//  macosWindowDriverView.hpp
//  sushiwindowmacos
//
//  Created by Michael Ong on 23/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//
#pragma once

#include <AppKit/AppKit.h>

@interface macosWindowDriverView: NSView

@property
const void* windowRef;

@end
