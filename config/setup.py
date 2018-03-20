from __future__ import unicode_literals

import installer as installer_lib
import argparse
import os


parser = argparse.ArgumentParser(description='YXVim installer script')

parser.add_argument('--layers', "-l", dest='layer_path', type=str, required=True, help='The layer path')
parser.add_argument('--binary', "-b", dest='bin_path', type=str, required=True, help='The binary path')
args = parser.parse_args()

print args.layer_path
print args.bin_path


if not os.path.isdir(args.bin_path):
    os.makedirs(args.bin_path)

if not os.path.isdir(args.layer_path):
    raise ValueError('the layer path is not a directory:%s' % (args.layer_path, ))

if not os.access(args.layer_path, os.R_OK):
    raise ValueError('can not access layer path:%s' % (args.layer_path, ))

if not os.path.isdir(args.bin_path):
    raise ValueError('the binary path is not a directory:%s' % (args.bin_path, ))

if not os.access(args.bin_path, os.W_OK):
    raise ValueError('can not access binary path:%s' % (args.bin_path, ))


for layer_name in os.listdir(args.layer_path):
    if layer_name == '.DS_Store':
        continue

    layer_path = os.path.join(args.layer_path, layer_name)
    if not os.access(os.path.join(layer_path, 'main.vim'), os.R_OK):
        continue

    install_script_path = os.path.join(layer_path, 'install.py')
    if not os.access(install_script_path, os.R_OK):
        continue

    installer_lib.load_installer(layer_name, install_script_path)


for installer in installer_lib.all_installer():
    installer.layer_path = args.layer_path
    installer.bin_path = args.bin_path

    print installer.name
    installer.install()
