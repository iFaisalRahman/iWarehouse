//
//  LevelSelect.m
//  iwarehouse
//
//  Created by Sohel Sarder on 3/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LevelSelect.h"
#import "Level1.h"

int TopUnlockedLevel=1;

@implementation LevelSelect


- (void)viewDidLoad {
	
	
    [super viewDidLoad];


}

-(void)viewDidAppear:(BOOL)animated{

	self.view.alpha=0;
	[UIView beginAnimations:@"View Flip" context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	self.view.alpha=1;
	[UIView commitAnimations];
}

-(IBAction)selectLevelButtonPressed:(id)btn{

	UIButton *button = (UIButton*)btn;
	
	int index = [[[button titleLabel] text] intValue];
    NSLog(@"Level=%d",index);
	if(index <= TopUnlockedLevel)
	{
		Level1 *level = [[[Level1 alloc] initWithNibName:@"Level1" bundle:nil] autorelease];
		[level levelInit:index];
		[self presentModalViewController:level animated:NO];
	}
	else
	{
		NSLog(@"This Level is Locked");
	}
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	if (interfaceOrientation == UIInterfaceOrientationLandscapeRight)
	{
		return YES;
	}
	else {
		return NO;
	}
	
	
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
