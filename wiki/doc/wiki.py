from django.template.loader import render_to_string
import settings
import variables
import os

def process():
  v = dictionary(variables)
  for f, wiki in files():
    out = file(os.path.join(settings.PROJECT_ROOT, wiki), 'w')
    out.write(render_to_string(f, v))
    out.close()

def files():
  files = []
  for f in os.listdir(settings.PROJECT_ROOT):
    if f.endswith('.wiki.template'):
      page = f[:-len('.template')]
      files.append((f, page))
  
  return files

def dictionary(module):
  d = {}
  for key in dir(module):
    if not key.startswith('__') and not key.endswith('__'):
      d[key] = getattr(module, key)
  return d
      