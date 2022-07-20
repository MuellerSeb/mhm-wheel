import os
from wheel.bdist_wheel import bdist_wheel as _bdist_wheel
from skbuild import setup


class generic_py_bdist_wheel(_bdist_wheel):
    def finalize_options(self):
        _bdist_wheel.finalize_options(self)
        self.root_is_pure = False

    def get_tag(self):
        python, abi, plat = _bdist_wheel.get_tag(self)
        python, abi = "py2.py3", "none"
        return python, abi, plat


# the default mhm version to link against
mhm_version = "develop"
version = "5.12.0.dev0"
# maybe overwrite the default cmake config
mhm_version = os.getenv("MHM_BUILD_VERSION", mhm_version)
mhm_build_type = os.getenv("MHM_BUILD_TYPE", "Release")
# you can set MHM_BUILD_PARALLEL=0 or MHM_BUILD_PARALLEL=1
mhm_omp = "ON" if int(os.getenv("MHM_BUILD_PARALLEL", "0")) else "OFF"
# init cmake args
cmake_args = [
    f"-DMHM_BUILD_TYPE={mhm_build_type}",
    f"-DMHM_BIND_VERSION={mhm_version}",
    f"-DMHM_BUILD_PARALLEL={mhm_omp}",
]
print(f"## mHM setup: build-type '{mhm_build_type}'")
print(f"## mHM setup: version '{mhm_version}'")
print(f"## mHM setup: OpenMP usage '{mhm_omp}'")

setup(
    version=version,
    packages=["mhm_pydist"],
    package_dir={"": "src"},
    cmake_install_dir="src/mhm_pydist",
    cmake_args=cmake_args,
    cmdclass={"bdist_wheel": generic_py_bdist_wheel},
    zip_safe=False,
)

