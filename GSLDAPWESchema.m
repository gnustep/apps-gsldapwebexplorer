/** GSLDAPWESchema.m - <title>GSLDAPWESchema: Class GSLDAPWESchema</title>

   Copyright (C) 2003 Free Software Foundation, Inc.
   
   Written by:  Manuel Guesdon <mguesdon@orange-concept.com>
   Date: 	Jan 2003

   $Revision$
   $Date$
   $Id$
   
   This file is part of the GNUstep GSLDAPWESchema application.
   
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
#include "GSLDAPWESchema.h"
#include "GSLDAPWESession.h"

//====================================================================
@implementation GSLDAPWESchema

-(void)dealloc
{
  DESTROY(_objectClassNames);
  DESTROY(_attributeNames);
  DESTROY(_matchingRuleNames);
  DESTROY(_syntaxNames);
  DESTROY(_ldapSchema);
  [super dealloc];
};

-(GSLDAPSchema*)ldapSchema
{
  if (!_ldapSchema)
    {
      GSLDAPConnection* ldapConn=[(GSLDAPWESession*)[self session]ldapConnection];
      ASSIGN(_ldapSchema,[ldapConn schema]);
    };
  return _ldapSchema;
};

-(NSArray*)objectClassNames
{
  NSDebugMLog(@"_objectClassNames=%@",_objectClassNames);
  if (!_objectClassNames)
    {
      GSLDAPSchema* schema=[self ldapSchema];
      ASSIGN(_objectClassNames,[[schema objectClassNames]
                                 sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]);
    };
  NSDebugMLog(@"_objectClassNames=%@",_objectClassNames);
  return _objectClassNames;
};

-(NSArray*)attributeNames
{
  NSDebugMLog(@"_attributeNames=%@",_attributeNames);
  if (!_attributeNames)
    {
      GSLDAPSchema* schema=[self ldapSchema];
      ASSIGN(_attributeNames,[[schema attributeNames]
                                  sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]);
    };
  NSDebugMLog(@"_attributeNames=%@",_attributeNames);
  return _attributeNames;
};

-(NSArray*)matchingRuleNames
{
  NSDebugMLog(@"_matchingRuleNames=%@",_matchingRuleNames);
  if (!_matchingRuleNames)
    {
      GSLDAPSchema* schema=[self ldapSchema];
      ASSIGN(_matchingRuleNames,[[schema matchingRuleNames]
                                  sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]);
    };
  NSDebugMLog(@"_matchingRuleNames=%@",_matchingRuleNames);
  return _matchingRuleNames;
};

-(NSArray*)syntaxNames
{
  NSDebugMLog(@"_syntaxNames=%@",_syntaxNames);
  if (!_syntaxNames)
    {
      GSLDAPSchema* schema=[self ldapSchema];
      ASSIGN(_syntaxNames,[[schema syntaxNames]
                            sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]);
    };
  NSDebugMLog(@"_syntaxNames=%@",_syntaxNames);
  return _syntaxNames;
};

-(NSString*)syntaxDescriptionText
{
  GSLDAPSchema* schema=[self ldapSchema];
  return [[schema syntaxNamed:_tmpSyntaxName]descriptionText];
};
@end

