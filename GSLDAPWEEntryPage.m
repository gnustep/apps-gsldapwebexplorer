/** GSLDAPWEEntryPage.m - <title>GSLDAPWEEntryPage: Class GSLDAPWEEntryPage</title>

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

#include <GSWeb/GSWeb.h>
#include <gsldap/GSLDAPCom.h>
#include "GSLDAPWESession.h"
#include "GSLDAPWEEntryPage.h"

//====================================================================
@implementation GSLDAPWEEntryPage

-(id)init
{
  if ((self=[super init]))
    {
    };
  return self;
};

-(void)dealloc
{
  DESTROY(_ldapConnection);
  DESTROY(_entry);
  DESTROY(_parentDN);
  DESTROY(_attributeNames);
  DESTROY(_allObjectClassNames);
  DESTROY(_mandatoryAttributeNames);
  DESTROY(_allAttributeNames);
  DESTROY(_allowedAttributeNames);
  DESTROY(_allPossibleAttributeNames);
  [super dealloc];
};
//--------------------------------------------------------------------
-(void)awake
{
  LOGObjectFnStart();
  _tmpAttributeName=nil;
  _tmpAttributeValues=nil;
  _tmpMessage=nil;
  _tmpObjectClassName=nil;
  _tmpAddAttributeName=nil;
  [super awake];
  LOGObjectFnStop();
};

//--------------------------------------------------------------------
-(void)sleep
{
  LOGObjectFnStart();
  [super sleep];
  _tmpAttributeName=nil;
  _tmpAttributeValues=nil;
  _tmpMessage=nil;
  _tmpObjectClassName=nil;
  _tmpAddAttributeName=nil;
  LOGObjectFnStop();
};

-(void)appendToResponse:(GSWResponse*)aResponse
              inContext:(GSWContext*)aContext
{
  if (_objectClassChanged)
    {
      _objectClassChanged=NO;
      DESTROY(_mandatoryAttributeNames);
      DESTROY(_allAttributeNames);
      DESTROY(_allowedAttributeNames);
    };
  [super appendToResponse:aResponse
         inContext:aContext];
};

-(GSLDAPConnection*)ldapConnection
{
  if (!_ldapConnection)
    {
      ASSIGN(_ldapConnection,[(GSLDAPWESession*)[self session]ldapConnection]);
    }
  return _ldapConnection;
};

-(GSLDAPSchema*)ldapSchema
{
  GSLDAPSchema* ldapSchema=nil;
  if (!_ldapConnection)
    {
      ldapSchema=[[self ldapConnection]schema];
    }
  else
      ldapSchema=[_ldapConnection schema];
  return ldapSchema;
};

-(LDAPEntryAction)action
{
  if (_action==LDAPEntryAction_Undef)
    {
      NSString* action=[[[self context]request]formValueForKey:@"action"];
      NSDebugMLog(@"action=%@",action);
      if ([action isEqualToString:@"addEntry"])
        _action=LDAPEntryAction_Add;
      else if ([action isEqualToString:@"deleteEntry"])
        _action=LDAPEntryAction_Delete;
      else
        _action=LDAPEntryAction_Modify;
    };
  return _action;
}

-(NSString*)parentDN
{
  [self entry];
  return _parentDN;
};

-(GSLDAPEntry*)entry
{
  if (!_entry)
    {
      NSString* dn=[[[self context]request]formValueForKey:@"dn"];
      NSDebugMLog(@"dn=%@",dn);
      if (!dn)
        {
        }
      else
        {
          LDAPEntryAction action=[self action];
          NSDebugMLog(@"action=%d",action);
          switch(action)
            {
            case LDAPEntryAction_Add:
              ASSIGN(_entry,([GSLDAPEntry ldapEntry]));
              [_entry addValue:[NSNull null]
                      forAttributeNamed:@"objectClass"];
              ASSIGN(_parentDN,dn);
              break;
            case LDAPEntryAction_Delete:
            case LDAPEntryAction_Modify:
            default:
              {
                ASSIGN(_entry,([[self ldapConnection] searchDN:dn
                                                      attributes:nil]));
                NSDebugMLog(@"entry=%@",_entry);
              };
              break;
            };
        };
    };
  return _entry;
};

-(BOOL)isAddition
{
  return ([self action]==LDAPEntryAction_Add);
};

-(BOOL)isDeletion
{
  LDAPEntryAction action=[self action];
  return (action==LDAPEntryAction_Delete || action==LDAPEntryAction_Deleted);
};

-(BOOL)isDeleted
{
  return ([self action]==LDAPEntryAction_Deleted);
};

-(NSArray*)entryObjectClassNames
{
  NSDebugMLog(@"[_entry objectClassNames]=%@",[_entry objectClassNames]);
  return [_entry objectClassNames];
};

-(NSArray*)mandatoryAttributeNames
{
  if (!_mandatoryAttributeNames)
    {
      GSLDAPSchema* ldapSchema=[self ldapSchema];
      if (ldapSchema)
        {          
          ASSIGN(_mandatoryAttributeNames,
                 ([[ldapSchema mandatoryAttributeNamesForObjectClassNames:[self entryObjectClassNames]]
                   sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]));
          NSDebugMLog(@"_mandatoryAttributeNames=%@",_mandatoryAttributeNames);
        };
    };
  return _mandatoryAttributeNames;
};

-(BOOL)isMandatoryAttribute
{
  return [[self mandatoryAttributeNames] containsObject:_tmpAttributeName];
};

-(BOOL)isAllowedAttribute
{
  return [[self allowedAttributeNames] containsObject:_tmpAttributeName];
};

-(NSArray*)allAttributeNames
{
  if (!_allAttributeNames)
    {
      GSLDAPSchema* ldapSchema=[self ldapSchema];
      if (ldapSchema)
        {          
          NSMutableSet* set=[NSMutableSet setWithArray:
                                            [ldapSchema attributeNamesForObjectClassNames:[self entryObjectClassNames]]];
          [set addObjectsFromArray:[_entry attributeNames]];
          ASSIGN(_allAttributeNames,[[set allObjects]sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]);
          NSDebugMLog(@"_allAttributeNames=%@",_allAttributeNames);
        }
      else
        ASSIGN(_allAttributeNames,[self attributeNames]);
    };
  return _allAttributeNames;
};

-(NSArray*)allowedAttributeNames
{
  if (!_allowedAttributeNames)
    {
      GSLDAPSchema* ldapSchema=[self ldapSchema];
      if (ldapSchema)
        {          
          ASSIGN(_allowedAttributeNames,
                 ([[ldapSchema attributeNamesForObjectClassNames:[self entryObjectClassNames]]
                    sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]));
          NSDebugMLog(@"_allowedAttributeNames=%@",_allowedAttributeNames);
        }
    };
  return _allowedAttributeNames;
};

-(NSArray*)allPossibleAttributeNames
{
  if (!_allPossibleAttributeNames)
    {
      GSLDAPSchema* ldapSchema=[self ldapSchema];
      if (ldapSchema)
        {          
          ASSIGN(_allPossibleAttributeNames,
                 ([[ldapSchema attributeNames]
                    sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]));
          NSDebugMLog(@"_allPossibleAttributeNames=%@",_allPossibleAttributeNames);
        }
    };
  return _allPossibleAttributeNames;  
};

-(NSArray*)attributeNames
{
  if (!_attributeNames)
    {
      ASSIGNCOPY(_attributeNames,([[_entry attributeNames]
                                    sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]));
    };
  return _attributeNames;
};

-(void)setTmpAttributeName:(NSString*)attributeName
{
  NSDebugMLog(@"attributeName=%@",attributeName);
  _tmpAttributeName=attributeName;
  _tmpAttributeValues=nil;
};

-(NSArray*)tmpAttributeValues
{
  if (!_tmpAttributeValues)
    {
      _tmpAttributeValues=[[[_entry valuesForAttributeNamed:_tmpAttributeName] copy] autorelease];
      if (!_tmpAttributeValues)
        _tmpAttributeValues=[NSArray arrayWithObject:[NSNull null]];
    };
  return _tmpAttributeValues;
};

-(NSArray*)allObjectClassNames
{
  GSLDAPSchema* ldapSchema=[self ldapSchema];
  if (ldapSchema)
    ASSIGN(_allObjectClassNames,
           [[ldapSchema objectClassNames]
             sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]);
  NSDebugMLog(@"_allObjectClassNames=%@",_allObjectClassNames);
  return _allObjectClassNames;
};

-(BOOL)isObjectClassAttribute
{
  return ([_tmpAttributeName caseInsensitiveCompare:@"objectClass"]==NSOrderedSame
          && [[self allObjectClassNames]count]>0);
};

-(id)attributeValue
{
  NSArray* attributeValues=[self tmpAttributeValues];
  id attributeValue=[attributeValues objectAtIndex:_attributeValueIndex];
  NSDebugMLog(@"attributeValue=%@",attributeValue);
  if (attributeValue && attributeValue!=[NSNull null] && [self isObjectClassAttribute])
    {
          GSLDAPSchema* ldapSchema=[self ldapSchema];
      if (ldapSchema)
        {
          GSLDAPObjectClass* oc=[ldapSchema objectClassNamed:attributeValue];
          NSDebugMLog(@"oc=%@",oc);
          attributeValue=[oc name];
          NSDebugMLog(@"attributeValue=%@",attributeValue);
        };
    };
  return attributeValue;
};

-(void)setAttributeValue:(id)value
{
  id attributeValue=[self attributeValue];
  NSDebugMLog(@"attributeValue=%@ value=%@",attributeValue,value);
  if ([value length]==0)
    {
      if (attributeValue)
        {
          NSDebugMLog(@"%@: remove='%@'",_tmpAttributeName,attributeValue);
          [_entry removeValue:attributeValue
                  forAttributeNamed:_tmpAttributeName];
        };
    }
  else
    {
      NSString* old=[NSString stringWithFormat:@"%@",attributeValue];
      NSString* new=[NSString stringWithFormat:@"%@",value];
      if (![new isEqualTo:old]) 
        {
          NSDebugMLog(@"%@: replace '%@' by '%@'",_tmpAttributeName,attributeValue,value);
          [_entry replaceValue:attributeValue
                  byValue:value
                  forAttributeNamed:_tmpAttributeName];
        };
    };
  if ([_tmpAttributeName caseInsensitiveCompare:@"objectClass"]==NSOrderedSame)
    {
      _objectClassChanged=YES;
    };
};

-(BOOL)hasSchema
{
  return ([self ldapSchema]!=nil);
};


-(GSWComponent*)updateAction
{
  GSLDAPEntry* origEntry=nil;
  NSString* diffs=nil;
  if (![[self ldapConnection]  isBinded])
    [[self ldapConnection] bind];
  NSDebugMLog(@"_entry=%@",_entry);
  origEntry=[[self ldapConnection] searchDN:[_entry dn]
                                   attributes:nil];
  if (!origEntry)
    {
      NSDebugMLog(@"Error !");
    }
  diffs=[_entry ldapDiffFromEntry:origEntry];
  diffs=[NSString stringWithFormat:@"dn: %@\nchangetype: modify\n%@",
                  [_entry dn],
                  diffs];

  NSDebugMLog(@"diffs=%@",diffs);
  _tmpMessage=diffs;

  if (![[self ldapConnection] updateEntry:_entry])
    {
      _tmpMessage=[_tmpMessage stringByAppendingFormat:@"\nError"];
    };
  NSDebugMLog(@"_entry=%@",_entry);

  return nil;
};

-(GSWComponent*)addAction
{
  NSString* diffs=nil;
  if (![[self ldapConnection] isBinded])
    [[self ldapConnection] bind];
  NSDebugMLog(@"_entry=%@",_entry);
  NSDebugMLog(@"rdn=%@",[_entry rdn]);
  [_entry setParentDN:_parentDN];
  diffs=[_entry ldapDiff];
  diffs=[NSString stringWithFormat:@"dn: %@\nchangetype: modify\n%@",
                  [_entry dn],
                  diffs];
  NSDebugMLog(@"diffs=%@",diffs);
  _tmpMessage=diffs;

  if ([[self ldapConnection] addEntry:_entry])
    _action=LDAPEntryAction_Modify;
  else
    {
      _tmpMessage=[_tmpMessage stringByAppendingFormat:@"\nError"];
    };
  NSDebugMLog(@"_entry=%@",_entry);

  return nil;
};

-(GSWComponent*)deleteAction
{
  _action=LDAPEntryAction_Delete;
  return nil;
}

-(GSWComponent*)dontDeleteAction
{
  _action=LDAPEntryAction_Modify;
  return nil;
}
-(GSWComponent*)addAttributeNameAction
{
  if ([_tmpAddAttributeName length])
    [_entry addValue:[NSNull null]
            forAttributeNamed:_tmpAddAttributeName];    
  return nil;
}

-(GSWComponent*)refreshAction
{
  return nil;
};

-(GSWComponent*)reallyDeleteAction
{
  GSLDAPEntry* entry=[self entry];
  GSLDAPConnection* ldapConnection=[self ldapConnection];
  NSDebugMLog(@"bindDN=%@",[ldapConnection bindDN]);
  NSDebugMLog(@"isBinded=%d",(int)[ldapConnection isBinded]);
  NSDebugMLog(@"_entry=%@",_entry);
  if (![ldapConnection isBinded])
    [ldapConnection bind];
  if ([ldapConnection deleteEntry:[self entry]])
    {
      _tmpMessage=[NSString stringWithFormat:@"entry %@ is deleted",[entry dn]];
      _action=LDAPEntryAction_Deleted;
    }
  else
    _tmpMessage=[NSString stringWithFormat:@"Error deleteing entry %@",[entry dn]];
  return nil;
};

-(GSWComponent*)recursiveReallyDeleteAction
{
  GSLDAPEntry* entry=[self entry];
  GSLDAPConnection* ldapConnection=[self ldapConnection];
  NSDebugMLog(@"bindDN=%@",[ldapConnection bindDN]);
  NSDebugMLog(@"isBinded=%d",(int)[ldapConnection isBinded]);
  NSDebugMLog(@"_entry=%@",_entry);
  if (![ldapConnection isBinded])
    [ldapConnection bind];
  if ([ldapConnection deleteEntry:[self entry]
                      isRecursive:YES])
    {
      _tmpMessage=[NSString stringWithFormat:@"entry %@ is deleted",[entry dn]];
      _action=LDAPEntryAction_Deleted;
    }
  else
    _tmpMessage=[NSString stringWithFormat:@"Error deleteing entry %@",[entry dn]];
  return nil;
};

-(GSWComponent*)addAttributeValueAction
{  
  NSDebugMLog(@"_entry=%@",_entry);
  NSDebugMLog(@"values=%@",[_entry valuesForAttributeNamed:_tmpAttributeName]);
  [_entry addValue:[NSNull null]
          forAttributeNamed:_tmpAttributeName];
  NSDebugMLog(@"values=%@",[_entry valuesForAttributeNamed:_tmpAttributeName]);
  return nil;
};
@end
