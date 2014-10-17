//
//  SecondColumnTableViewController.m
//  Obras-Programas
//
//  Created by Pedro Contreras Nava on 10/10/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "SecondColumnTableViewController.h"
#import "Obra.h"
#define INVERSION 0
#define POBLACION 1
#define CLASIFICACION 2


@interface SecondColumnTableViewController ()

@end

@implementation SecondColumnTableViewController
@synthesize obra = _obra;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%ld",(long)section);
    if (section == INVERSION) {
        return 2;
    }
    else if(section == POBLACION){
        return 3;
    }
    else if(section == CLASIFICACION){
        return 1;
    }
    else
    // Return the number of rows in the section.
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell ;
    
    if (indexPath.section == INVERSION & indexPath.row ==0) {
        cell =  [tableView dequeueReusableCellWithIdentifier:@"InversionCell" forIndexPath:indexPath];
    }else
        
    if(indexPath.section == POBLACION){
        if(indexPath.row ==0){
            cell =[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
            cell.textLabel.text = @"Población Objetivo";
            cell.detailTextLabel.text = self.obra.poblacionObjetivo;
        }
        else if (indexPath.row==1){
            cell =[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
            cell.textLabel.text = @"Impacto";
            cell.detailTextLabel.text = self.obra.impacto.nombreImpacto;
        }
        else if (indexPath.row==2){
            cell =[tableView dequeueReusableCellWithIdentifier:@"CellCheck" forIndexPath:indexPath];
            cell.textLabel.text = @"Señalización";
            cell.accessoryType = UITableViewCellAccessoryNone;

            if ([_obra.senalizacion  isEqual: @"1"]) {
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            }

        }
    }
    else if(indexPath.section == CLASIFICACION & indexPath.row==0){
        cell =  [tableView dequeueReusableCellWithIdentifier:@"ClaisificacionCell" forIndexPath:indexPath];

    }
    
    
    
    else cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
     [cell.detailTextLabel setTextColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];

    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == INVERSION & indexPath.row==0) {
        return 104;
    }else if(indexPath.section == CLASIFICACION & indexPath.row==0) return 172;
    
    else return 44;
    
}


- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // set title of section here
    
    if (section == INVERSION) {
        return @"Inversion";
    }
    else if(section == POBLACION){
        return @"Poblacion";
    }
    else if(section == CLASIFICACION){
        return @"Clasificacion";
    }
    else
        // Return the number of rows in the section.
        return @"";
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
