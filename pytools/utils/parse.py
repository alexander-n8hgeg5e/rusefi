#!/bin/env python3
from sys import argv
from time import asctime
from xml.dom import minidom

TUNERSTUDIO_INI_PATH = '../firmware/tunerstudio/rusefi.ini'
TMP_TUNERSTUDIO_INI_PATH = '/tmp/rusefi.ini_ufoisdufoisdufos'
#tunerstudio_config_path=argv[1]
tunerstudio_config_path="/tmp/2018-12-15_22.53.13.msq"

def parse_tunerstudio_xml():
    xmldoc = minidom.parse(TUNERSTUDIO_INI_PATH)
    tables=xmldoc.getElementsByTagName("table")
    l=[]
    for i in tables:
        if i.getAttribute("type") in TABLETYPES:
               l.append(i)
    return l
    
def print_list(things):
    for thing in things:
        print(thing)


def getOneElementByTagName(dom_element,tagname):
    items=dom_element.getElementsByTagName(tagname)
    if len(items) > 1:
            raise Exception("more than one item with tag name: '"+tagname+"' found")
    return items[0]

def strip_strings_in_list_of_strings_recursive(liste):
    l=[]
    for i in liste:
        if type(i) is type(''):
            l.append(i.strip())
        elif type(i) is type([]):
            l.append(strip_strings_in_list_of_strings_recursive(i))
    return l
        
def remove_empty_string_out_of_list_recursive(liste):
    l=[]
    for i in liste:
        if type(i) is type(""):
            if not i=='':
                l.append(i)
        elif type(i) is type([]):
            l.append( remove_empty_string_out_of_list_recursive(i) )
    return l

def remove_empty_list_out_of_list_recursive(liste):
    l=[]
    for i in liste:
        if type(i) is type([]):
            if not len(i)==0:
                l.append(i)
        else:
            l.append(i)
    return l

def split_em_all_on_space(things):
    l=[]
    for onething in things:
        try:
            l.append(onething.split(" "))
        except e:
            print("maybe you try to split some unsplitable stuff, or whatever")
            raise e
    return l
        
            


def parse_TSxml_for_constant_by_name(path, names):
    xmldoc = minidom.parse(path)
    constants = xmldoc.getElementsByTagName("constant")
    l=[]
    for i in constants:
        for j in names:
            if i.getAttribute("name") == j:
               l.append(i)
    return l
    
def parse_table(domtable,type):
    if type=="2D":
        return _parse_2D_table(domtable)
    if type=="3D":
        return _parse_3D_table(domtable)

    

""" 
    x = getOneElementByTagName(table,"xAxis")
    y = getOneElementByTagName(table,"yAxis")
    z     = getOneElementByTagName(table,"zValues")
    x_data = x.childNodes[0].data
    y_data = y.childNodes[0].data
    z_data = z.childNodes[0].data
    x = x_data.splitlines()
    y = y_data.splitlines()
    z = split_em_all_on_space(z_data.splitlines())
    x = strip_strings_in_list_of_strings_recursive(x)
    y = strip_strings_in_list_of_strings_recursive(y)
    z = strip_strings_in_list_of_strings_recursive(z)
    x = remove_empty_string_out_of_list_recursive(x)
    y = remove_empty_string_out_of_list_recursive(y)
    z = remove_empty_string_out_of_list_recursive(z)
    x = remove_empty_list_out_of_list_recursive(x)
    y = remove_empty_list_out_of_list_recursive(y)
    z = remove_empty_list_out_of_list_recursive(z)
    return x,y,z
"""

def parse_tunerstudio_ini():
     """
     returns config as configparser
     """
     configfile=open(TUNERSTUDIO_INI_PATH,mode="rt")
     config=configfile.read()
     configfile.close()
     configfile=open(TMP_TUNERSTUDIO_INI_PATH,mode="wt")
     ## write default section line, because the parser wants one
     configfile.write("[DEFAULT]\n")
     configfile.write(config)
     configfile.close()
     import configparser
     cp=configparser.RawConfigParser(strict=False)
     cp.read(TMP_TUNERSTUDIO_INI_PATH)
     return cp


def print_config_raw(configparser):
    for i in configparser.sections():
        print("section: "+i)
        for j in configparser.options(i):
            print("option: "+j)
            print(configparser.get(i,j,raw=True))

def parse_curve(configparser):
    for i in configparser.options("CurveEditor"):
       print(i) 


