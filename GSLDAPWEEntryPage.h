/** GSLDAPWEEntryPage.h - <title>GSLDAPWEEntryPage: Class GSLDAPWEEntryPage</title>

   Copyright (C) 2003 Free Software Foundation, Inc.
   
   Written by:  Manuel Guesdon <mguesdon@orange-concept.com>
   Date: 	Jan 2003

   $Revision$
   $Date$
   $Id$
   
   This file is part of the GNUstep GSLDAPWEEntryPage application.
   
   <license>
   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.
   
   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.
   
   You should have received a copy of the GNU Library General Public
   License along with this library; if not, write to the Free
   Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
   </license>
**/

#ifndef _GSLDAPWEEntryPage_h__
	#define _GSLDAPWEEntryPage_h__

@class GSLDAPEntry;
typedef enum _LDAPEntryAction
  {
    LDAPEntryAction_Undef = 0,
    LDAPEntryAction_Add,
    LDAPEntryAction_Modify,
    LDAPEntryAction_Delete,
    LDAPEntryAction_Deleted,
  }LDAPEntryAction;
//====================================================================
@interface GSLDAPWEEntryPage : GSWComponent
{
  GSLDAPConnection* _ldapConnection;
  LDAPEntryAction _action;
  NSString* _tmpMessage;
  GSLDAPEntry* _entry;
  NSString* _parentDN;
  NSArray* _attributeNames;
  NSString* _tmpAttributeName;
  NSArray* _tmpAttributeValues;
  NSString* _tmpObjectClassName;
  NSString* _tmpAddAttributeName;
  NSArray* _allObjectClassNames;
  int _attributeValueIndex;
  NSArray* _mandatoryAttributeNames;
  NSArray* _allAttributeNames;
  NSArray* _allowedAttributeNames;
  NSArray* _allPossibleAttributeNames;

  BOOL _objectClassChanged;
}
-(GSLDAPConnection*)ldapConnection;
-(GSLDAPSchema*)ldapSchema;
-(LDAPEntryAction)action;
-(NSString*)parentDN;
-(GSLDAPEntry*)entry;
-(BOOL)isAddition;
-(NSArray*)entryObjectClassNames;
-(NSArray*)mandatoryAttributeNames;
-(BOOL)isMandatoryAttribute;
-(BOOL)isAllowedAttribute;
-(NSArray*)allAttributeNames;
-(NSArray*)allowedAttributeNames;
-(NSArray*)allPossibleAttributeNames;
-(NSArray*)attributeNames;
-(void)setTmpAttributeName:(NSString*)attributeName;

-(NSArray*)tmpAttributeValues;

-(NSArray*)allObjectClassNames;

-(BOOL)isObjectClassAttribute;

-(id)attributeValue;
-(void)setAttributeValue:(id)value;

-(BOOL)hasSchema;

-(GSWComponent*)updateAction;
-(GSWComponent*)addAttributeNameAction;
-(GSWComponent*)refreshAction;
-(GSWComponent*)addAttributeValueAction;

@end


#endif //_GSLDAPWEEntryPage_h__
