from __future__ import unicode_literals

import installer
import platform
import os
import shutil


class StdCfgInstaller(installer.YXVimInstaller):

    def __init__(self, name):
        super(StdCfgInstaller, self).__init__(name)

    def install(self):
        src_path = os.path.join(os.path.dirname(__file__), 'src', 'tellenc', 'tellenc.cpp')
        dst_path = os.path.join(self.bin_path, 'tellenc')

        if os.access(dst_path, os.R_OK):
            if os.access(dst_path, os.X_OK):
                return
            self.uninstall()

        if platform.system() == 'Darwin' and os.system('hash clang') is 0:
            cmd = 'clang++ -O2 %s -o %s' % (src_path, dst_path)
        elif platform.system() == 'Windows':
            cmd = 'cl /EHsc /Ox /Fe%s.exe tellenc.cpp' % (src_path, dst_path)
        else:
            cmd = 'g++ -O2 %s -o %s -s' % (src_path, dst_path)

        return True if os.system(cmd) is 0 else False

    def uninstall(self):
        dst_path = os.path.join(self.bin_path, 'tellenc')
        if os.path.isfile(dst_path):
            os.remove(dst_path)
        elif os.path.isdir(dst_path):
            shutil.rmtree(dst_path, True)

installer.regist_installer(StdCfgInstaller('stdcfg'))
