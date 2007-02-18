# GNUmakefile - libgsps: GNUmakefile
#
#   Copyright (C) 2003 Free Software Foundation, Inc.
#   
#   Written by:	Manuel Guesdon <mguesdon@orange-concept.com>
#   Date: 	Jan 2003
#   
#   This file is part of the GNUstep GSLDAPWebExplorer application.
#   
#   This library is free software; you can redistribute it and/or
#   modify it under the terms of the GNU Library General Public
#   License as published by the Free Software Foundation; either
#   version 2 of the License, or (at your option) any later version.
#   
#   This application is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   Library General Public License for more details.
#   
#   You should have received a copy of the GNU Library General Public
#   License along with this library; if not, write to the Free
#   Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

# $Id$

include $(GNUSTEP_MAKEFILES)/common.make

#include Version
#include config.mak

GSWAPP_NAME=GSLDAPWebExplorer
GSLDAPWebExplorer_HAS_GSWCOMPONENTS=YES
GSLDAPWebExplorer_PRINCIPAL_CLASS=GSLDAPWebExplorer
GSLDAPWebExplorer_GSWAPP_INFO_PLIST=Resources/Info-GSLDAPWebExplorer.plist

# The bundle resource files and directories
GSLDAPWebExplorer_RESOURCE_FILES = \


#Resources/Info-gnustep.plist

#GSLDAPWebExplorer_LOCALIZED_RESOURCE_FILES=

GSLDAPWebExplorer_COMPONENTS= \
Main.gswc \
GSLDAPWEParameters.gswc \
GSLDAPWETree.gswc \
GSLDAPWETemplate.gswc \
GSLDAPWEEntryPage.gswc \
GSLDAPWESchema.gswc \
GSLDAPWESchemaObjectClass.gswc \
GSLDAPWESchemaAttribute.gswc \
GSLDAPWESchemaSyntax.gswc \
GSLDAPWESchemaMatchingRule.gswc \
GSLDAPWESchemaElementPage.gswc \

GSLDAPWebExplorer_LANGUAGES= \

GSLDAPWebExplorer_RESOURCE_DIRS = \


GSLDAPWebExplorer_WEBSERVER_RESOURCE_FILES = \

# The Objective-C source files to be compiled
GSLDAPWebExplorer_OBJC_FILES =  \
Main.m \
GSLDAPWESession.m \
GSLDAPWebExplorer.m \
GSLDAPWebExplorer_main.m \
GSLDAPWEParameters.m \
GSLDAPWETree.m \
GSLDAPWETemplate.m \
GSLDAPWEEntryPage.m \
GSLDAPWESchema.m \
GSLDAPWESchemaElementBase.m \
GSLDAPWESchemaObjectClass.m \
GSLDAPWESchemaAttribute.m \
GSLDAPWESchemaSyntax.m \
GSLDAPWESchemaMatchingRule.m \
GSLDAPWESchemaElementPage.m \

GSLDAPWebExplorer_HEADER_FILES =  \
Main.h \
GSLDAPWESession.h  \
GSLDAPWebExplorer.h \
GSLDAPWEParameters.h \
GSLDAPWETree.h \
GSLDAPWETemplate.h \
GSLDAPWEEntryPage.h \
GSLDAPWESchema.h \
GSLDAPWESchemaElementBase.h \
GSLDAPWESchemaObjectClass.h \
GSLDAPWESchemaAttribute.h \
GSLDAPWESchemaSyntax.h \
GSLDAPWESchemaMatchingRule.h \
GSLDAPWESchemaElementPage.h \

SRCS = $(GSWAPP_NAME:=.m)
HDRS = $(GSWAPP_NAME:=.h)

DIST_FILES = $(SRCS) $(HDRS) GNUmakefile Makefile.postamble Makefile.preamble

-include Makefile.preamble

include $(GNUSTEP_MAKEFILES)/gswapp.make

-include Makefile.postamble
