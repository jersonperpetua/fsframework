#!/usr/bin/env python

import os
import sys
from django.core.management import setup_environ

def main():
  from wiki import process
  process()

if __name__ == '__main__':
  try:
    sys.path.insert(0, os.path.dirname(__file__))
    import settings
  except ImportError:
    sys.stderr.write("Error: Can't find the file 'settings.py' in the directory containing %r. It appears you've customized things.\nYou'll have to run django-admin.py, passing it your settings module.\n(If the file settings.py does indeed exist, it's causing an ImportError somehow.)\n" % __file__)
    sys.exit(1)

  setup_environ(settings)
  main()