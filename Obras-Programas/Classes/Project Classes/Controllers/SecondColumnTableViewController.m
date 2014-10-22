//
//  SecondColumnTableViewController.m
//  Obras-Programas
//
//  Created by Pedro Contreras Nava on 10/10/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "SecondColumnTableViewController.h"
#import "Obra.h"
#import "Inversion.h"
#import "Clasificacion.h"
#define INVERSION 0
#define POBLACION 1
#define CLASIFICACION 2

#define FEDERAL 101
#define ESTATAL 102
#define MUNICIPAL 103
#define SOCIAL 104
#define PRIVADA 105
#define OTROS 106

#define COMPROMISOGOBIERNO 201
#define PNG 202
#define PM 203
#define PNI 204
#define CNCH 205
#define OTRACLASIFICACION 206


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
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];

    [f setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    NSNumber *number = [NSNumber numberWithFloat:[self.obra.inversionTotal floatValue]];

    
    if (indexPath.section == INVERSION) {
        if(indexPath.row ==0){
            cell =  [tableView dequeueReusableCellWithIdentifier:@"InversionCell" forIndexPath:indexPath];
            UIImageView *imagenFederal = (UIImageView*)[cell.contentView viewWithTag:FEDERAL];
            UIImageView *imagenEstatal = (UIImageView*)[cell.contentView viewWithTag:ESTATAL];
            UIImageView *imagenMunicipal = (UIImageView*)[cell.contentView viewWithTag:MUNICIPAL];
            UIImageView *imagenSocial = (UIImageView*)[cell.contentView viewWithTag:SOCIAL];
            UIImageView *imagenPrivada = (UIImageView*)[cell.contentView viewWithTag:PRIVADA];
            UIImageView *imagenOtros = (UIImageView*)[cell.contentView viewWithTag:OTROS];
            
            
            imagenFederal.hidden =YES;
            imagenEstatal.hidden=YES;
            imagenMunicipal.hidden=YES;
            imagenSocial.hidden =YES;
            imagenPrivada.hidden= YES;
            imagenOtros.hidden=YES;
            
            Inversion * inversion = (Inversion*)[self.obra.inversiones firstObject];
            NSLog(@"%@",[inversion valueForKey:@"nombreTipoInversion"]);
            NSArray *items = @[@"Federal", @"Estatal", @"Municipal",@"Social",@"Privada",@"Otro"];

            for (Inversion *inversion in self.obra.inversiones) {
                NSString *stringInversion = [inversion valueForKey:@"nombreTipoInversion"];
                int item = [items indexOfObject:stringInversion];
                
                switch (item) {
                    case 0:
                        imagenFederal.hidden = NO;
                        break;
                    case 1:
                        imagenEstatal.hidden = NO;
                        break;
                    case 2:
                        imagenMunicipal.hidden = NO;
                        break;
                    case 3:
                        imagenSocial.hidden = NO;
                        break;
                    case 4:
                        imagenPrivada.hidden = NO;
                        break;
                    case 5:
                        imagenOtros.hidden = NO;
                        break;
                    default:
                        break;
                }
            }
        }
        else if(indexPath.row==1){
            cell =[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
            cell.textLabel.text = @"Inversión Total";
            cell.detailTextLabel.text =  [NSString stringWithFormat:@"%@ %@", [f stringFromNumber:number], self.obra.tipoMoneda];


        }
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
        
        
        
        UIImageView *imagenGobierno = (UIImageView*)[cell.contentView viewWithTag:COMPROMISOGOBIERNO];
        UIImageView *imagenGuerrero = (UIImageView*)[cell.contentView viewWithTag:PNG];
        UIImageView *imagenMichoacan = (UIImageView*)[cell.contentView viewWithTag:PM];
        UIImageView *imagenPNI = (UIImageView*)[cell.contentView viewWithTag:PNI];
        UIImageView *imagenCNCH = (UIImageView*)[cell.contentView viewWithTag:CNCH];
        UIImageView *imagenOtros = (UIImageView*)[cell.contentView viewWithTag:OTRACLASIFICACION];
        
        
        imagenGobierno.hidden =YES;
        imagenGuerrero.hidden=YES;
        imagenMichoacan.hidden=YES;
        imagenPNI.hidden =YES;
        imagenCNCH.hidden= YES;
        imagenOtros.hidden=YES;
        
        Inversion * inversion = (Inversion*)[self.obra.inversiones firstObject];
        NSLog(@"%@",[inversion valueForKey:@"nombreTipoInversion"]);
        NSArray *items = @[@"Compromiso de Gobierno"
                           , @"Plan Nuevo Guerrero",
                           @"Plan Michoacán",
                           @"Plan Nacional de Infraestructura",
                           @"Cruzada Nacional Contra el Hambre",
                           @"Otro"];
        
        for (Clasificacion *clasificacion in self.obra.clasificaciones) {
            NSString *stringInversion = [clasificacion valueForKey:@"nombreTipoClasificacion"];
            int item = [items indexOfObject:stringInversion];
            
            switch (item) {
                case 0:
                    imagenGobierno.hidden = NO;
                    break;
                case 1:
                    imagenGuerrero.hidden = NO;
                    break;
                case 2:
                    imagenMichoacan.hidden = NO;
                    break;
                case 3:
                    imagenPNI.hidden = NO;
                    break;
                case 4:
                    imagenCNCH.hidden = NO;
                    break;
                case 5:
                    imagenOtros.hidden = NO;
                    break;
                default:
                    break;
            }
        }

        
        
        
        

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
