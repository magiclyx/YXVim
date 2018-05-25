from __future__ import unicode_literals

import installer
import platform
import os
import shutil


class StdIdeInstaller(installer.YXVimInstaller):

    def __init__(self, name):
        super(StdCfgInstaller, self).__init__(name)

    def install(self):
        src_path = os.path.join(os.path.dirname(__file__), 'src', 'ctags', '.ctags')
        dst_path = os.path.abspath('~/.ctags')

        if os.access(dst_path, os.R_OK):
            self.uninstall()

        if platform.system() == 'Darwin' and os.system('hash clang') is 0:
            shutil.copyfile(src_path, dst_path)
        elif platform.system() == 'Windows':
            pass
        else:
            shutil.copyfile(src_path, dst_path)

        return True

    def uninstall(self):
        dst_path = os.path.abspath('~/.ctags')
        if os.path.isfile(dst_path):
            os.remove(dst_path)
        elif os.path.isdir(dst_path):
            shutil.rmtree(dst_path, True)

installer.regist_installer(StdIdeInstaller('stdide'))


