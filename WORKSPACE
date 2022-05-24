workspace(
    name = "two_snakes",
)

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
    name = "rules_python",
    sha256 = "cdf6b84084aad8f10bf20b46b77cb48d83c319ebe6458a18e9d2cebf57807cdd",
    strip_prefix = "rules_python-0.8.1",
    url = "https://github.com/bazelbuild/rules_python/archive/refs/tags/0.8.1.tar.gz",
)

load("@rules_python//python:repositories.bzl", "python_register_toolchains")

# Install the default 3.10.2 python toolchain
python_register_toolchains(
    name = "python3",
    # Available versions are listed in @rules_python//python:versions.bzl.
    python_version = "3.10.2",
)

load("@python3//:defs.bzl", python_interpreter = "interpreter")
load("@rules_python//python:pip.bzl", "pip_install", "pip_parse")

# Add on the beam 3.9 toolchain
python_register_toolchains(
    name = "python3_beam",
    python_version = "3.9",
)

load("@python3_beam//:defs.bzl", beam_python_interpreter = "interpreter")

pip_parse(
    name = "beam_deps",
    python_interpreter_target = beam_python_interpreter,
    requirements_lock = "//beam:requirements.txt",
)

load("@beam_deps//:requirements.bzl", _beam_deps = "install_deps")

_beam_deps()

# this picks up the beam python toolchains
# could be: register_toolchains("//beam:all")
# but for debugging
register_toolchains("//beam:beam_3_9_toolchain_arm64", "//beam:beam_3_9_toolchain_x86")
# could be: register_execution_platforms("//beam:all")
# but for debugging
register_execution_platforms("//beam:linux_arm64", "//beam:linux_x86")
