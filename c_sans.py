#! /usr/bin/python
# vim: set fileencoding=utf-8 :
# c_sans (Python script) -- Show the X509v3 Subject Alternative Names for PEM-format X.509 certificate(s)
#
# Version:   1.0
# Copyright: (c)2016 Alastair Irvine <alastair@plug.org.au>
# Keywords:  x509 https
# Notice:    
# Licence:   This file is released under the GNU General Public License
#
'''Description:
  
Usage: 
Options:
  
'''
# Licence details:
#     This program is free software; you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation; either version 2 of the License, or (at
#     your option) any later version.
#
#     See http://www.gnu.org/licenses/gpl-2.0.html for more information.
#
#     You can find the complete text of the GPLv2 in the file
#     /usr/share/common-licenses/GPL-2 on Debian systems.
#     Or see the file COPYING in the same directory as this program.
#
#
# TO-DO:

import sys
import getopt
import cryptography.x509
from cryptography.hazmat.backends import default_backend


self="c_sans"
allowed_options='h'
allowed_long_options=['help']


# *** CLASSES ***


# *** FUNCTIONS ***
def show_help(dest=sys.stdout):
    print >> dest, __doc__,


def report_error(*msg):
    print >> sys.stderr, self + ": Error:", msg


def report_warning(*msg):
    print >> sys.stderr, self + ": Warning:", msg


def report_notice(*msg):
    print >> sys.stderr, self + ": Notice:", msg


def cert_sans(f):
    pem_data = f.read()
    cert = cryptography.x509.load_pem_x509_certificate(pem_data, default_backend())
    ext = cert.extensions.get_extension_for_class(cryptography.x509.extensions.SubjectAlternativeName)
    return [dnsname.value for dnsname in ext.value]


def print_cert_sans(f):
    for item in cert_sans(f):
        print item


# *** MAINLINE ***
if __name__ == '__main__':
    # == Command-line parsing ==
    # -- defaults --
    debug = 0

    # -- option handling --
    try:
        optlist, args = getopt.getopt(sys.argv[1:], allowed_options, allowed_long_options)
    except getopt.GetoptError, e:
        report_error(e)
        sys.exit(1)

    # Create a special dict object that defaults to False for unspecified options
    from collections import defaultdict
    params = defaultdict(bool)

    for option, opt_arg in optlist:
        if option == "-n":
            params["no_fetch"] = True
        elif option == "-d":
            debug += 1
        elif option == "-h" or option == "--help":
            show_help()
            sys.exit(0)

    # -- argument checking --
    ## if len(args) not in (2, 3):
    ##     report_error("Invalid command-line parameters.")
    ##     show_help(sys.stderr)
    ##     sys.exit(1)

    # -- argument handling --
    ## if len(args) == 0:


    # == sanity checking ==


    # == preparation ==


    # == processing ==
    first = True
    if len(args) == 0:
        print print_cert_sans(sys.stdin)
    else:
        for filename in args:
            if not first:
                print "--------"
            first = False         # Do this here to avoid missing out in case of error

            try:
                if filename == "-":
                    f = sys.stdin
                else:
                    f = open(filename)
            except IOError as e:
                # e.g. "[Errno 2] No such file or directory: 'berk'"
                print e
                continue

            print filename
            try:
                print_cert_sans(f)
            except ValueError as e:
                print e
