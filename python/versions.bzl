"""
Convenience macro to gen versions constraints, platforms, and toolchains for
multiple python versions

"""

def multipython_gen_toolchains(toolchains = None):
    """One macro to rule them all

    Args:
      toolchains:
        List of python_register_toolchains labels from WORKSPACE.

        For example, if you had:
            python_register_toolchains(
                name = "python3_10",
                python_version = "3.10.2",
                register_toolchains = False,
            )
            python_register_toolchains(
                name = "python3_9",
                python_version = "3.9",
                register_toolchains = False,
            )
        then pass:
          [ "python3_9", "python3_10" ]

        NOTE: the last one passed in seems to be the "default"
    """

    if not toolchains:
        fail("toolchains must be a list of labels for python toolchains")

    native.constraint_setting(
        name = "python_lang_version",
    )
    for label in toolchains:
        native.constraint_value(
            name = label,
            constraint_setting = ":python_lang_version",
        )

        for arch in ("x86_64", "aarch64"):
            native.toolchain(
                name = "%s_toolchain_%s" % (label, arch),
                exec_compatible_with = [
                    "@platforms//os:linux",
                    "@platforms//cpu:%s" % arch,
                ],
                target_compatible_with = [
                    "@platforms//os:linux",
                    "@platforms//cpu:%s" % arch,
                    ":%s" % label,
                ],
                toolchain = "@%s_%s-unknown-linux-gnu//:python_runtimes" % (label, arch),
                toolchain_type = "@bazel_tools//tools/python:toolchain_type",
            )
            native.platform(
                name = "linux_%s_%s" % (arch, label),
                constraint_values = [
                    "@platforms//os:linux",
                    "@platforms//cpu:%s" % arch,
                    ":%s" % label,
                ],
            )

        native.platform(
            name = "local_host_%s" % label,
            constraint_values = [":%s" % label],
            parents = ["@local_config_platform//:host"],
        )

    return
