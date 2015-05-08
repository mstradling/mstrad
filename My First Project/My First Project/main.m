//
//  main.m
//  My First Project
//
//  Created by Matthew Frederick Stradling on 5/4/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        // insert code here...
        int answer = 0;
        int guess = 0;
        int turn = 0;
        
        answer = arc4random() % 100 + 1;
        
        while (guess != answer)
        {
            turn++;
            NSLog(@"Guess #%i: Enter a number between 1 and 100", turn);
            //input
            scanf("%i", &guess);
            
            if(guess > answer)
            {
                NSLog(@"Lower!");
            }
            else if(guess < answer)
            {
                NSLog(@"Higher!");
            }
            else
            {
                NSLog(@"Correct! The answer was %i", answer);
            }
        }
        NSLog(@"It took you %i tries", turn);
    }
    return 0;
}
