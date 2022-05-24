load("@rules_python//python/pip_install:requirements.bzl", "compile_pip_requirements")

package(default_visibility=["//visibility:public"])

# To get the beam python, we set up a constraint, a toolchain that is compatible
# with that constraint, and then use that constraint in py_binary to pivot to
# the new toolchain
constraint_setting(
    name = "python_lang_version",
)

constraint_value(
    name = "python3_9",
    constraint_setting = ":python_lang_version",
)

toolchain(
    name = "beam_3_9_toolchain_x86",
    # straight outta external/python3_beam_toolchains/BUILD.bazel, but with the
    # version hack constraint applied
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
        ":python3_9",
    ],
    toolchain = "@python3_beam_x86_64-unknown-linux-gnu//:python_runtimes",
    toolchain_type = "@bazel_tools//tools/python:toolchain_type",
)

toolchain(
    name = "beam_3_9_toolchain_arm64",
    # straight outta external/python3_beam_toolchains/BUILD.bazel, but with the
    # version hack constraint applied
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
        ":python3_9",
    ],
    toolchain = "@python3_beam_aarch64-unknown-linux-gnu//:python_runtimes",
    toolchain_type = "@bazel_tools//tools/python:toolchain_type",
)

platform(
    name = "linux_x86",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
        ":python3_9",
    ],
)

platform(
    name = "linux_arm64",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
        ":python3_9",
    ],
)

#platform(
#	name = "local_host_python39",
#	constraint_values = [
#		":python3_9",
#	],
#	parents = ["@local_config_platform//:host"],
#)

# Edit requirements.in, update dependencies with:
# bazel run //app:requirements.update
compile_pip_requirements(
    name = "requirements",
    extra_args = [
        "--allow-unsafe",
    ],
)
