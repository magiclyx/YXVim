from __future__ import unicode_literals
import sys


class YXVimInstaller(object):

    def __init__(self, name):
        self.name = name
        self.layer_path = None
        self.bin_path = None

    def install(self):
        pass

    def uninstall(self):
        pass

    def reinstall(self):
        self.uninstall()
        self.install()

    def updated(self):
        self.reinstall()

    def version(self):
        return 0


def load_installer(load_module_name, load_module_path):

    if load_module_name in sys.modules:
        return sys.modules[load_module_name]

    if sys.version_info[0] == 2:
        import imp
        return imp.load_source(load_module_name, load_module_path)
    elif sys.version_info[0] is 3:
        if sys.version_info[0:2] > (3, 4):
            import importlib.util
            spec = importlib.util.spec_from_file_location(load_module_name, load_module_path)
            result_module = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(result_module)
            sys.modules[load_module_name] = result_module
            return result_module
        else:
            import importlib.machinery
            return importlib.machinery.SourceFileLoader(load_module_name, load_module_path).load_module()


installer_list = []


def regist_installer(installer):

    if not isinstance(installer, YXVimInstaller) and not issubclass(installer, YXVimInstaller):
        return

    installer_list.append(installer)


def all_installer():
    return installer_list




