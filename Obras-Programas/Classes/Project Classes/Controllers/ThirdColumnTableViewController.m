//
//  ThirdColumnTableViewController.m
//  Obras-Programas
//
//  Created by Pedro Contreras Nava on 10/10/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "ThirdColumnTableViewController.h"
#import "Obra.h"
#import "Programa.h"
#define DESCRIPCION 0
#define INAUGURACION 1
#define OBSERVACIONES 2

#define OBSERVACIONESPROGRAMAS 0
#define METAS 1
@interface ThirdColumnTableViewController ()
@property BOOL isPrograms;
@end

@implementation ThirdColumnTableViewController
@synthesize obra = _obra;
@synthesize programa = _programa;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.obra!=nil){
        self.isPrograms = NO;
    }else{
        self.isPrograms=YES;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if(!self.isPrograms){
        return 3;

    }else return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(!self.isPrograms){
        if (section == DESCRIPCION) {
            return 1;
        }
        else if(section == INAUGURACION){
            return 3;
        }
        else if(section==OBSERVACIONES){
            return 1;
        }
    }else{
        if(section==OBSERVACIONESPROGRAMAS){
            return 1;
        }
        else if(section==METAS){
            return 4;
        }
    }

        // Return the number of rows in the section.
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if(!self.isPrograms){
        if(indexPath.section==DESCRIPCION){
            if(indexPath.row==0){
                cell = [tableView dequeueReusableCellWithIdentifier:@"DescripcionCell" forIndexPath:indexPath];
                UITextView *textView = (UITextView*)[cell.contentView viewWithTag:101];
                textView.text = _obra.descripcion;
                
            }
        }
        
        if(indexPath.section==INAUGURACION){
            if (indexPath.row==0) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"CellCheck" forIndexPath:indexPath];
                cell.textLabel.text = @"Inaugurada";
                cell.accessoryType = UITableViewCellAccessoryNone;
                if([_obra.inaugurada isEqualToString:@"1"]){
                    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                }
            }else
                if(indexPath.row==1){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"CellCheck" forIndexPath:indexPath];
                    cell.textLabel.text = @"Susceptible de inaugurar";
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    if([_obra.susceptibleInauguracion isEqualToString:@"1"]){
                        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                    }
                }
                else if (indexPath.row==2){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
                    cell.textLabel.text = @"Inaugurador";
                    cell.detailTextLabel.text = _obra.inaugurador.nombreCargoInaugura;
                    [cell.detailTextLabel setTextColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
                    
                }
        }
        
        if(indexPath.section==OBSERVACIONES){
            if(indexPath.row==0){
                cell = [tableView dequeueReusableCellWithIdentifier:@"DescripcionCell" forIndexPath:indexPath];
                UITextView *textView = (UITextView*)[cell.contentView viewWithTag:101];
                textView.text = _obra.observaciones;
            }
            
            
        }
        
        else cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        [cell.detailTextLabel setTextColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
        
        
    }else{
        if (indexPath.section==OBSERVACIONESPROGRAMAS){
            cell = [tableView dequeueReusableCellWithIdentifier:@"DescripcionCell" forIndexPath:indexPath];
            UITextView *textView = (UITextView*)[cell.contentView viewWithTag:101];
            textView.text = _programa.observaciones;
        }else if(indexPath.section==METAS){
            if (indexPath.row==0){
                cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
                cell.textLabel.text = @"Meta Programada";
                cell.detailTextLabel.text = _programa.metaBeneficiarios;
                [cell.detailTextLabel setTextColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
                
            }
            if (indexPath.row==1){
                cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
                cell.textLabel.text = @"Linea Base";
                cell.detailTextLabel.text = _programa.lineaBase;
                [cell.detailTextLabel setTextColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
                
            }
            if (indexPath.row==2){
                cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
                cell.textLabel.text = @"Absoluto";
                cell.detailTextLabel.text = _programa.absoluto;
                [cell.detailTextLabel setTextColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
                
            }
            if (indexPath.row==3){
                cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
                cell.textLabel.text = @"Porcentual";
                cell.detailTextLabel.text = _programa.porcentual;
                [cell.detailTextLabel setTextColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
                
            }


        }
        
    }
    

    
    // Configure the cell...
    
    return cell;
}


- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if(!self.isPrograms){
        // set title of section here
        
        if (section == DESCRIPCION) {
            return @"Descripción";
        }
        else if(section == INAUGURACION){
            return @"Inauguración";
        }
        
        else if(section==OBSERVACIONES){
            return @"Observaciones";
        }
    }
    else{
        if(section == OBSERVACIONESPROGRAMAS){
            return @"Observaciones";
        }
        
        else if(section==METAS){
            return @"Metas";
        }
        
    }
        // Return the number of rows in the section.
        return @"";
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(!self.isPrograms){
        if (indexPath.section == DESCRIPCION & indexPath.row==0) {
            return 148;
        }else if(indexPath.section == OBSERVACIONES){
            return 116;
        }
        else return 44;
    }
    else{
        if(indexPath.section == OBSERVACIONESPROGRAMAS){
            return 148;
        }else return 44;
        
    }
    return 0;
    
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
