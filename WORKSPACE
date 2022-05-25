workspace(
    name = "two_snakes",
)

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
    name = "python3_10",
    # Available versions are listed in @rules_python//python:versions.bzl.
    python_version = "3.10.2",
    register_toolchains = False,
)

load("@python3_10//:defs.bzl", python_interpreter = "interpreter")

python_register_toolchains(
    name = "python3_9",
    python_version = "3.9",
    register_toolchains = False,
)

load("@python3_9//:defs.bzl", python_interpreter_3_9 = "interpreter")
load("@rules_python//python:pip.bzl", "pip_install", "pip_parse")

pip_parse(
    name = "beam_deps",
    python_interpreter_target = python_interpreter_3_9,
    requirements_lock = "//beam:requirements.txt",
)

load("@beam_deps//:requirements.bzl", _beam_deps = "install_deps")

_beam_deps()

# this picks up the beam python toolchains
# could be: register_toolchains("//beam:all")
# but for debugging
register_toolchains("//python:all")

register_execution_platforms("//python:all")
