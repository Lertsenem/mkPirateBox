########################################
# Project :	PirateBox
#
# Description :	This is the main Makefile used for PirateBox
#		binaries construction. It mainly build the ipk
#		package by tar.gzipping the control and data
#		directories.
########################################

# VARIABLES
# ======================================
NAME = piratebox
VERSION = 0.5.2
ARCHITECTURE = all

BINARIES_LOCATION = bin/
SOURCES_LOCATION = src/

IPK = $(NAME)_$(VERSION)_$(ARCHITECTURE).ipk

#
# ======================================
.DEFAULT_GOAL = allclear

# CLEAN
# ======================================

# TARGET : cleanbuild
cleanbuild:
	-rm -f $(SOURCES_LOCATION)/control.tar.gz
	-rm -f $(SOURCES_LOCATION)/data.tar.gz

# TARGET : clean
clean: cleanbuild
	-rm -f $(IPK)

# BUILD
# ======================================

# TARGET SOURCES_LOCATION/control.tar.gz
$(SOURCES_LOCATION)/control.tar.gz:
	tar czf $@ -C $(SOURCES_LOCATION)/control .


# TARGET SOURCES_LOCATION/data.tar.gz
$(SOURCES_LOCATION)/data.tar.gz:
	tar czf $@ -C $(SOURCES_LOCATION)/data .


# TARGET : IPK
$(IPK): $(SOURCES_LOCATION)/control.tar.gz $(SOURCES_LOCATION)/data.tar.gz
	tar czf $@ -C $(SOURCES_LOCATION) control.tar.gz data.tar.gz debian-binary


# TARGET : all
all: $(IPK) 

# TARGET : allclear
allclear: all cleanbuild
	mv $(IPK) $(BINARIES_LOCATION)

#
# ======================================
.PHONY: allclear all clean

