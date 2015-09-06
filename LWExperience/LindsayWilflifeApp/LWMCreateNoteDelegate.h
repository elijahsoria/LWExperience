//
//  LWMCreateNoteDelegate.h
//  Lindsay Wildlife
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"

@protocol LWMCreateNoteDelegate <NSObject>
- (void)update:(Note *)updated_note;
- (void)reset;
@end
