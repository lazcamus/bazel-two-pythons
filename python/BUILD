package(default_visibility = ["//visibility:public"])

constraint_setting(
    name = "python_lang_version",
)

constraint_value(
    name = "python3_9",
    constraint_setting = ":python_lang_version",
)

constraint_value(
    name = "python3_10",
    constraint_setting = ":python_lang_version",
)

toolchain(
    name = "python_3_9_toolchain_x86",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
    ],
    # straight outta external/python3_9_toolchains/BUILD.bazel, but with the
    # version hack constraint applied
    target_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
        ":python3_9",
    ],
    toolchain = "@python3_9_x86_64-unknown-linux-gnu//:python_runtimes",
    toolchain_type = "@bazel_tools//tools/python:toolchain_type",
)

toolchain(
    name = "python_3_9_toolchain_arm64",
    # straight outta external/python3_9_toolchains/BUILD.bazel, but with the
    # version hack constraint applied
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
    ],
    target_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
        ":python3_9",
    ],
    toolchain = "@python3_9_aarch64-unknown-linux-gnu//:python_runtimes",
    toolchain_type = "@bazel_tools//tools/python:toolchain_type",
)

toolchain(
    name = "python_3_10_toolchain_x86",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
    ],
    # straight outta external/python3_9_toolchains/BUILD.bazel, but with the
    # version hack constraint applied
    target_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
        ":python3_10",
    ],
    toolchain = "@python3_10_x86_64-unknown-linux-gnu//:python_runtimes",
    toolchain_type = "@bazel_tools//tools/python:toolchain_type",
)

toolchain(
    name = "python_3_10_toolchain_arm64",
    # straight outta external/python3_9_toolchains/BUILD.bazel, but with the
    # version hack constraint applied
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
    ],
    target_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
        ":python3_10",
    ],
    toolchain = "@python3_10_aarch64-unknown-linux-gnu//:python_runtimes",
    toolchain_type = "@bazel_tools//tools/python:toolchain_type",
)

platform(
    name = "linux_x86_python39",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
        ":python3_9",
    ],
)

platform(
    name = "linux_arm64_python39",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
        ":python3_9",
    ],
)

platform(
    name = "local_host_python39",
    constraint_values = [
        ":python3_9",
    ],
    parents = ["@local_config_platform//:host"],
)

platform(
    name = "linux_x86_python310",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
        ":python3_10",
    ],
)

platform(
    name = "linux_arm64_python310",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
        ":python3_10",
    ],
)

platform(
    name = "local_host_python310",
    constraint_values = [
        ":python3_10",
    ],
    parents = ["@local_config_platform//:host"],
)
